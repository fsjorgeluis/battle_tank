## Context

Ver `proposal.md` para la motivación. El estado actual usa tres flags de sprite (`FLAG_SOLID`, `FLAG_BREAKABLE`, `FLAG_BASE`) para clasificar tiles y un modelo de movimiento escalar (`pl.speed`) acoplado a la dirección del cañón (`pl.body_a`). El render del mapa es una única llamada a `map()` antes de las entidades (`pico8.api.map`). La interacción bala↔tile actual se decide puramente por flags, lo que no escala bien cuando un mismo tile necesita comportamientos distintos para balas y tanques.

## Goals / Non-Goals

**Goals:**
- Extender el sistema de flags de sprite a seis flags para la física de movimiento y el render: sólido, rompible, lento, deslizante y overlay. Las interacciones bala↔tile se modelan con una tabla en código.
- Separar la dirección del cañón (`body_a`) del vector de velocidad (`vx, vy`) para permitir deslizamiento real en hielo.
- Aplicar multiplicadores de aceleración, velocidad máxima y fricción según el tile bajo el centro del tanque.
- Renderizar los tiles `OVERLAY` (bosque) después de todas las entidades usando una segunda pasada con `spr()` (`pico8.api.spr`).
- Hacer que las balas ignoren el agua al resolver colisiones, manteniendo el resto del comportamiento de balas intacto.
- Incluir sprites placeholder distinguibles para los nuevos tiles.
- Diseñar las consultas de tile y física como funciones reutilizables para futuro movimiento de enemigos.

**Non-Goals:**
- Modificar la generación procedural del mapa para esparcir tiles especiales.
- Introducir animación de agua, daño por tile o efectos ambientales.
- Cambiar el comportamiento de ladrillo, metal o bases más allá de mantener sus flags.
- Implementar movimiento de enemigos; solo se deja la física lista para reutilizar.

## Decisions

### 1. Flags de sprite para física de movimiento, tabla Lua para interacción bala↔tile
**Elegido:** usar `fset`/`fget` para los comportamientos binarios del tanque (`SOLID`, `SLOW`, `SLIDE`, `BREAKABLE`, `OVERLAY`) y una tabla Lua (`BULLET_TILE_ACT`) para la interacción bala↔tile, que tiene más de dos estados (atraviesa / destruye / rebota / victoria / game over).

**Rationale:**
- La física de movimiento es binaria (bloquea/no bloquea, ralentiza/no ralentiza, desliza/no desliza), por lo que `fget()` nativo es rápido y barato en tokens en el hot path (`pico8.api.fget`, `pico8.api.fset`).
- La interacción bala↔tile no es binaria: una bala puede atravesar, destruir, rebotar o activar una condición de victoria/derrota. Forzar eso en un bit por caso (por ejemplo `WATER`, `BULLET_PASS`) agota rápidamente los 8 flags y genera un modelo forzado.
- La tabla de balas se consulta solo en colisión, no en el hot path de movimiento, así que su costo es irrelevante para la CPU por frame.
- Se reduce el uso de flags de 7 a 6, dejando 2 libres para futuras propiedades binarias.

**Alternativas consideradas:**
- Codificar todo en flags de sprite: consistente con el flujo de edición del sprite editor, pero forzaba estados de tres o más valores en bits booleanos (agua sólida para tanques pero pasable para balas, bosque pasable para ambos pero overlay). Se descarta por ser un modelo pobre para la interacción bala↔tile.
- Tabla `tile → comportamiento` global en Lua: más flexible, pero movería también la física de movimiento fuera de flags, perdiendo la ventaja de `fget()` barato en el hot path. Se descarta para la parte de movimiento.

### 2. Usar el tile bajo el centro del tanque para decidir la física
**Elegido:** muestrear `tx=flr(pl.x/8), ty=flr(pl.y/8)` una vez por frame.

**Rationale:**
- Es simple, predecible y barato en CPU.
- El tanque ocupa 8×8 píxeles, igual que un tile, por lo que el centro es una aproximación razonable de "sobre qué tile está".
- Evita reglas de "mayoría de tiles" que añadirían complejidad y tokens sin mejorar el feel perceptible.

**Alternativas consideradas:**
- Muestrear los cuatro puntos del borde del tanque y tomar el más restrictivo: más robusto en transiciones, pero consume más tokens y CPU. Se descarta para mantener la simplicidad del cambio.

### 3. Separar `body_a` del vector de velocidad
**Elegido:** reemplazar `pl.speed` por `pl.vx` y `pl.vy`; `body_a` sigue controlando el sprite y la dirección de disparo.

**Rationale:**
- Es el único modelo que produce deslizamiento real en hielo: el tanque conserva inercia en una dirección mientras el jugador puede apuntar en otra.
- No afecta el render ni el disparo, que ya dependen de `body_a`.
- Facilita futuras mejoras como empujes o retroceso direccional.

**Alternativas consideradas:**
- Mantener `pl.speed` y solo bajar la fricción en hielo: más simple, pero el tanque siempre se mueve exactamente hacia donde apunta, por lo que no hay deslizamiento auténtico. Se descarta porque el deslizamiento es el objetivo central del hielo.

### 4. Anular el vector de velocidad al colisionar con un sólido
**Elegido:** al detectar que el tanque entra en un tile sólido, revertir posición y poner `vx=vy=0`.

**Rationale:**
- Evita que un tanque deslizando sobre hielo quede atascado empujando contra una pared.
- Es consistente con el comportamiento actual de "detenerse" al chocar.
- Simple de implementar y de depurar.

**Alternativas consideradas:**
- Solo revertir posición y dejar que la fricción frene: en hielo la fricción es baja, así que el tanque seguiría intentando moverse hacia la pared varios frames. Se descarta para evitar atascos.
- Reflejar solo el componente perpendicular de la velocidad: más realista, pero requiere determinar qué lado de la caja colisionó, lo que aumenta tokens y complejidad. Se deja para un futuro refinamiento.

### 5. Dibujar overlay con `spr()` en segunda pasada
**Elegido:** recorrer todos los tiles del mapa (16×14) y dibujar con `spr()` aquellos con flag `OVERLAY` después de las entidades.

**Rationale:**
- PICO-8 no tiene capas de mapa nativas; `map()` dibuja todos los tiles de una región sin filtrar por flag (`pico8.api.map`).
- El mapa es pequeño (224 tiles), por lo que recorrerlo completo cada frame tiene un costo despreciable frente al presupuesto de CPU.
- `spr()` permite dibujar el sprite exacto que está en el tile, incluyendo variantes de bosque.

**Alternativas consideradas:**
- Usar una segunda región del mapa como capa de overlay: complica la edición y el uso de `mget`/`mset`. Se descarta.
- Dibujar bosques como entidades desde una lista separada: requiere mantener sincronizada una lista con el mapa y es más lento si hay muchos tiles. Se descarta.

### 6. Las balas usan una tabla de lookup por tile
**Elegido:** crear `BULLET_TILE_ACT` en `const.lua`, que mapea cada tile relevante a una acción (`BULLET_PASS`, `BULLET_DESTROY`, `BULLET_BOUNCE`, `BULLET_VICTORY`, `BULLET_GAMEOVER`). En `bullet.lua` se consulta `BULLET_TILE_ACT[mget(tx,ty)]` al impactar.

**Rationale:**
- Modela de forma natural los cinco estados posibles de interacción bala↔tile.
- Evita agregar flags como `WATER` o `BULLET_PASS` que solo sirven para un caso especial.
- Mantiene `map_is_solid()` simple y reusable solo para el movimiento de entidades.
- Es fácil extender: agregar un nuevo tile con comportamiento de bala especial solo requiere una entrada en la tabla.

**Alternativas consideradas:**
- Añadir un flag `BULLET_PASS` genérico: más flexible que `FLAG_WATER`, pero sigue siendo un booleano para un problema que no es binario. Se descarta.
- Crear `map_is_bullet_solid(tx,ty)` que ignore agua por flag: resuelve el caso del agua pero no escala si aparecen más estados (rebote especial, bala que atraviesa ciertos muros, etc.). Se descarta.

## Risks / Trade-offs

- **[Risk]** Separar velocidad de dirección puede cambiar el feel incluso sobre tierra firme si la fricción no se ajusta bien.
  → **Mitigación:** calibrar `SPEED_FRICTION` para que el tanque se sienta lo más parecido posible al actual cuando no está en hielo; verificar en pruebas de regresión.
- **[Risk]** El overlay de bosque se dibuja sobre todos los elementos, incluyendo balas y efectos, lo que puede oscurecer información importante si se usa en exceso.
  → **Mitigación:** es una decisión de diseño intencional (ocultamiento visual); en la generación procedural futura se controlará la densidad de bosques.
- **[Risk]** La ausencia de generación procedural deja sin tiles especiales en partidas normales, dificultando la validación visual.
  → **Mitigación:** incluir una función de test temporal que coloque unos pocos tiles de cada tipo en posiciones seguras del mapa, documentada como paso de prueba y removable cuando llegue la generación.
- **[Risk]** Los sprites placeholder pueden no ser distinguibles a primera vista con la paleta limitada.
  → **Mitigación:** usar colores contrastantes (verde para bosque, azul claro para hielo, marrón para arena, azul oscuro para agua) y verificar visualmente en PICO-8.

## Migration Plan

No aplica migración de datos. El cambio es local al cartucho:
1. Añadir constantes y sprites en `src/const.lua` y `battle_tank.p8`.
2. Configurar flags y helpers en `src/map.lua`.
3. Refactorizar movimiento del jugador en `src/player.lua`.
4. Ajustar colisión de balas en `src/bullet.lua`.
5. Añadir pasada de overlay en `src/ui.lua`.
6. Ejecutar el cartucho, colocar tiles de test y verificar física y render.
7. Confirmar tokens con `info()` y CPU con `stat(1)`/CTRL-P.

## Open Questions

Ninguna. Las decisiones de alcance (flags de sprite, separación de velocidad, overlay con `spr()`, balas cruzan agua) fueron confirmadas durante la exploración.
