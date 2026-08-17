## Context

Primer cartucho del proyecto (repo greenfield). Ver `proposal.md` para el "why".
Restricciones que condicionan el diseño: P8 Lua restringido, 8192 tokens de
código, bucle `_init`/`_update`/`_draw` a 30fps (`pico8.concept.game-loop`),
pantalla 128x128 (`pico8.constraint.display-resolution`), ángulo normalizado
donde 1.0 = vuelta completa con `sin()` invertido para pantalla
(`pico8.api.cos`, `pico8.api.sin`), 6 botones (`pico8.constraint.controller-button-count`)
y entrada en borde con `btnp` resetada por frame (`pico8.api.btnp`).

## Goals / Non-Goals

**Goals:**
- Arquitectura modular por dominio que soporte iteraciones futuras (muros,
  disparos, enemigos móviles) sin refactor grande.
- Movimiento de tanque rotatorio con cuerpo 8-direcciones y cañón continuo
  desacoplado (toggle en btn(4)).
- Lógica pura (colisiones, snap de sector) aislada y verificable con `assert`.
- Bajo coste de tokens/CPU para dejar presupuesto a las siguientes iteraciones.

**Non-Goals:**
- Sin muros, mapa, balas, SFX, música ni enemigos móviles (iteraciones futuras).
- Sin menú de ajustes ni persistencia (cartdata).
- Sin modo 60fps: se usa `_update` a 30fps.
- Sin rejilla de tiles: el jugador se mueve con coordenadas libres y cajas AABB.

## Decisions

### D1. Layout de código con `#INCLUDE`
El cartucho `battle_tank.p8` vive en la raíz del repo y su sección `__lua`
contiene solo directivas `#INCLUDE`. Cada módulo es un `.lua` en `src/`
inyectado en el arranque (`pico8.concept.include-directive`).

```
battle_tank.p8  (rome, gfx, gfx_map, sfx, __lua = #INCLUDE ...)
└── src/
    ├── const.lua   -- constantes semanticas (estados, colores, velocidades)
    ├── util.lua    -- utilidades puras: aabb_overlap, clamp, snap_sector
    ├── states.lua  -- maquina de estados + init/reset de partida
    ├── player.lua  -- update/draw del tanque del jugador
    ├── enemy.lua   -- entidad enemiga (estatica)
    └── ui.lua      -- HUD, menu, game over
```

Prefijos de modulo en funciones globales: `ut_`, `st_`, `pl_`, `en_`, `ui_`;
constantes en mayusculas (convencion del proyecto). El `#INCLUDE` se aplana al
exportar, sin dependencias externas al distribuir.

### D2. Maquina de estados global minima
Una variable global `gs` (tabla) con `state` y el estado compartido de partida
(tabla `game`). `_update`/`_draw` delegan en funciones `st_update_*`/`st_draw_*`
según el estado. Transiciones explicitas y completas:

```
            (btnp(5) en "Jugar")
   MENU ──────────────────────────────► PLAY
    ▲                                    │
    │                                    │ lifes==0 (toque)
    │ btnp(5) en "Salir" STOPS            ▼
    └────────────────────────────────── GAMEOVER
                                          │
                                          └── btnp(5) "Reintentar" → st_reset() → PLAY
```

El cartucho arranca siempre en MENU (`st_init`). `st_reset()` reconstruye el
estado de partida desde cero (posiciones, angulos, vidas, contador de toques,
enemigo) cubriendo el requisito de reinicio limpio del `game-flow`.

### D3. Modelo cinematico del tanque
Estado del jugador en una tabla `pl`:

- `x, y`: posicion del centro del sprite (coorde. libres, continuas).
- `body_a`: angulo del cuerpo en `[0,1)`. btn(0) (izq) gira en sentido
  antihorario, btn(1) (der) en horario. El incremento por frame es constante
  (rotacion continua, no por saltos).
- `turret_a`: angulo del cañon. Con btn(4) mantenido, btn(0)/btn(1) rotan
  `turret_a`; en modo normal `turret_a` sigue a `body_a` cada frame (el cañon
  siempre apunta adelante salvo al apuntar).
- `speed`: escalar a lo largo del cuerpo. Aceleracion por btn(2), retroceso por
  btn(3), friccion en reposo. Se clampa a `[-SPEED_MAX, SPEED_MAX]`.

Cada frame: `vel = speed`; `dx = cos(body_a) * speed`, `dy = sin(body_a) *
speed` (`pico8.api.cos/sin`). El angulo 0 corresponde a derecha; 0.25 a
arriba; el modelo es exacto gracias a 1.0 = vuelta completa.

**Alternativa descartada**: velocidades vectoriales en x/y con direcciones
cardinales fijas (estilo humanoide). Rechazada porque no reproduce el tacto de
tanque giando (girar-correr) que pide el jugador, y complicaria el toggle de
cañon.

### D4. Render: 4 sprites base + volteos + cañon por software
- **Cuerpo**: snapshot del `body_a` por sector de 1/8 (`snap_sector` en
  `util.lua`); 4 sprites base (N/NE/E/SE) que con volteo X/Y de `spr()`
  cubren las 8 direcciones (`pico8.api.spr`, flags en `pico8.api.fget`).
- **Cañon**: se dibuja con `line()` desde el centro hacia `turret_a`
  (procedural, sin sprite). Esto da rotacion suave continua y ahorra sprites.
- **Enemigo**: 1 sprite propio y estatico.
- **Vidas**: 1 sprite de corazon dibujado 3 veces en el HUD; las perdidas se
  omiten (o se dibujan en color oscuro).

Presupuesto de sprites: 4 (cuerpo) + 1 (enemigo) + 1 (corazon) = 6 de 128
(`pico8.constraint.sprite-count`).

**Alternativa descartada**: 8 sprites de cuerpo sin volteos. Rechazada por
gastar sprites innecesariamente; los volteos son nativos a `spr()`.

### D5. Colisiones AABB entre cuerpo del jugador y enemigo
Caja del jugador ligeramente menor que el sprite (inset 1px, "perdon al
jugador") y caja del enemigo igual a su sprite. Función pura
`ut_aabb_overlap(ax1,ay1,ax2,ay2, bx1,by1,bx2,by2)` en `util.lua`.

Paso del jugador por frame:
1. Guarda `prev` (x,y).
2. Avanza segun `dx,dy`.
3. Si la nueva caja sale de la arena (0..127), se clampa a los bordes
   (`ut_clamp`).
4. Si la nueva caja solapa la del enemigo, revierte al `prev` (colision solida:
   el enemigo no es empujado ni atravesado). El jugador puede rodearlo girando.

Este orden cubre "enemigo no es empujado" y "limites de arena" sin mover el
enemigo jamas. La deteccion de contacto para daño usa la misma caja: se marca
`hit=true` al solapar con el jugador vulnerable.

### D6. Daño e invulnerabilidad de 3s con parpadeo
Campo `pl.invuln_until` = `t() + 3.0` cuando se recibe un toque
(`pico8.api.time`: t() avanza contando updates, coherente en modo 30fps).
Reglas por frame:

- Si `t() > pl.invuln_until` el jugador es vulnerable; si colisiona con el
  enemigo: `game.hits += 1`, `pl.lifes -= 1`, invuln_until = t()+3.0, y se
  actualiza el HUD.
- Mientras sea invulnerable, el cuerpo se dibuja solo en frames alternos
  (`flr(t()*BLINK_HZ) % 2 == 0`) produciendo el parpadeo; sin perder vidas.

`BLINK_HZ` ~ 8. Cero vidas → `st_set_state(GAMEOVER)`.

### D7. UI por software (print + rect/line)
- Menu: titulo con `print()`, dos opciones con cursor de seleccion animado con
  btnp(2)/btnp(3) en circulo. Confirmar Jugar (btnp(5)) → PLAY; Salir (btnp(5))
  → `stop()` detiene la ejecucion del cartucho (`pico8.api.stop`).
- HUD: corazones + contador de toques ("toques: n").
- Game over: texto centrado con `print`, "toques recibidos: <hits>", y
  "X para reintentar" usando `btnp(5)`.

### D8. Sin audio en esta iteracion
No se reservan canales aun (`pico8.constraint.audio-channels`). El primer
incremento con SFX asignara canales por evento (shoot, hit, explosion). Se
documenta aqui para que la iteracion de audio no sorprenda en el budget.

## Risks / Trade-offs

- **Toggle de apuntado sin balas** → el cañon gira pero no dispara; puede
  sentirse "gratuito". Mitigacion: la spec player-movement lo limita a mover el
  angulo, y la iteracion de disparo lo vuelve util. Riesgo aceptado por el
  jugador (quiere validar el feel temprano).
- **Colision por reverido** → a velocidades altas el tanque podria "saltar" un
  frame entero dentro del enemigo y quedar la caja revertida solo 1 frame.
  Mitigacion: `SPEED_MAX` conservador (<= 2px/frame) y cajas pequenas; suficiente
  para esta iteracion.
- **Angulos continuos y sprites por sector** → al snap del cuerpo a 8
  direcciones el arte rotara a saltos de 45°. Mitigacion: con cañon continuo de
  `line()`, el jugador percibe movimiento suave; los saltos de cuerpo son el
  look de Battle City.
- **t() ligada a fps** → la invulnerabilidad es "3 segundos de update"; a 30fps
  son 90 frames reales salvo caida a 15fps (entonces 45 frames). Aceptable: es
  tiempo de juego coherente, no tiempo de pared.

## Presupuestos previstos

| Recurso | Estimado | Limite | Notas |
| --- | --- | --- | --- |
| Tokens | < 900 | 8192 | margen amplio para iteraciones |
| CPU/frame | < 1% a 30fps | ~133k instr. | 2 entidades, AABB, drawing minimo |
| Sprites | 6 | 128 | 4 cuerpo + 1 enemigo + 1 corazon |
| Mapa | 0 | 128x32 tiles | sin muros (world building) |
| Canales audio | 0 | 4 | se reservan en iteracion de SFX |
| RAM | minimal | 64k | tablas pequenas |
| Cartdata | 0 | 64 numeros | sin persistencia |

## Migration Plan

Greenfield: no hay despliegue previo. El cartucho se crea de cero. Rollback
equivale a no aplicar el cambio: al ser el primer commit, git permite descartar
sin impacto en otras areas. La validacion es por ejecucion en `pico8` contra
los criterios de aceptacion de cada spec.

## Open Questions

- Posicion exacta del enemigo y de salida del jugador. Se eligen valores
  sensatos (enemigo centrol en la arena, jugador en una esquina) y se ajustan
  al probar; no altera specs ni descompone tareas.

## Conocimiento verificado de soporte

- `pico8.concept.include-directive`, `pico8.concept.game-loop`, `pico8.api.cos`,
  `pico8.api.sin`, `pico8.api.btn`, `pico8.api.btnp`, `pico8.api.time`,
  `pico8.api.stop`, `pico8.api.spr`, `pico8.api.print`, `pico8.api.line`,
  `pico8.constraint.token-limit`, `pico8.constraint.display-resolution`,
  `pico8.constraint.sprite-count`, `pico8.constraint.cpu-throughput`,
  `pico8.constraint.audio-channels`, `pico8.constraint.controller-button-count`.