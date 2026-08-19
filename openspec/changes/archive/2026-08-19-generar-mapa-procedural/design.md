## Context

El cartucho actual ejecuta el bucle de juego sobre una arena vacía de 128×128 píxeles. El jugador, la bala y el enemigo existen en coordenadas de pantalla sin referencia a tiles. Para añadir obstáculos y bases, movemos la representación del mundo a la cuadrícula de mapa nativa de PICO-8 (16×16 tiles de 8×8 píxeles), que cubre exactamente la pantalla visible (`pico8.constraint.display-resolution`, `pico8.constraint.sprite-size`).

Durante la primera implementación se sobreescribieron los sprites dibujados por el usuario al guardar el cartucho `.p8`. Los ajustes deben preservar la sección `__gfx__` existente y realizar cambios únicamente en archivos `.lua`.

## Goals / Non-Goals

**Goals:**
- Generar un mapa 16×16 laberíntico y conectado en cada partida mediante división recursiva seguida de erosión de paredes.
- Distinguir ladrillo rompible, metal irrompible y bases usando flags de sprite (`pico8.api.fget`, `pico8.api.fset`).
- Renderizar el mapa detrás de las entidades con `pico8.api.map`.
- Integrar colisiones y daño de balas con el mapa.
- Añadir condiciones de victoria/derrota por destrucción de bases.

**Non-Goals:**
- IA de navegación enemiga (cambio separado; los enemigos seguirán su lógica actual).
- Efectos de partículas, sonido de destrucción de muro ni pantallas de victoria/derrota elaboradas.
- Múltiples tipos de mapa o biomas.

## Decisions

### Preservar los sprites existentes del usuario
**Rationale:** Los sprites 11-14 ya fueron dibujados por el usuario con un estilo particular. Cualquier regeneración del cartucho debe conservar la sección `__gfx__` y modificar solo el código Lua.
**Procedimiento:** No ejecutar operaciones de PICO-8 que reescriban el `.p8` completo (como guardar desde el editor). Los cambios se hacen en `src/*.lua` y se reconstruye el cartucho concatenando secciones si fuera necesario.

### Usar el mapa nativo de PICO-8 en lugar de una cuadrícula Lua paralela
**Rationale:** `mget()`/`mset()` y `map()` están optimizados para la plataforma y permiten renderizar toda la cuadrícula con una sola llamada. Una cuadrícula paralela duplicaría memoria y complejidad.
**Alternativas consideradas:** Mantener una tabla Lua `grid[16][16]` separada. Rechazada porque PICO-8 ya reserva memoria de mapa y provee APIs directas (`pico8.api.mget`, `pico8.api.mset`, `pico8.api.map`).

### Modelar propiedades de tiles con flags de sprite
**Rationale:** Desacopla la lógica de juego de los índices de sprite. Si más adelante se reordenan los sprites, solo hay que reconfigurar flags en el editor, no código.
**Flags propuestos:**
- Flag 0: sólido (bloquea movimiento).
- Flag 1: rompible (la bala lo destruye).
- Flag 2: base (activa victoria/derrota).

### Algoritmo de división recursiva + erosión
**Rationale:** El autómata celular produjo cuevas abiertas en lugar de un laberinto estructurado. La división recursiva genera un laberinto perfecto con pasillos claros de 1 tile. Sin embargo, un laberinto perfecto tiene exactamente un camino entre dos puntos, lo cual es frustrante para tanques porque puede atrapar al jugador. La erosión aleatoria de paredes internas introduce ciclos y rutas alternativas, convirtiendo el laberinto en un campo de batalla táctico.
**Pasos concretos:**
1. Elegir `BASE_ENEMY_X` y `BASE_ALLY_X` aleatorias en `[2, 13]`.
2. `map_clear()` llena todo de ladrillo.
3. Se deja el borde exterior como ladrillo y se limpia el interior.
4. `map_recursive_division(x, y, w, h)` genera un laberinto perfecto, respetando las zonas de base marcadas por `map_is_base_zone(tx,ty)`:
   - Si el área es demasiado pequeña, detenerse.
   - Elegir orientación (horizontal si `h > w`, vertical si `w > h`, aleatorio si iguales).
   - Trazar una pared horizontal o vertical a través de la zona, salvo que el tile pertenezca a una zona de base.
   - Abrir exactamente una puerta (tile vacío) en dicha pared.
   - Llamar recursivamente en los dos sub-espacios.
5. `map_erode_walls(0.10)` recorre paredes interiores y elimina ~10 % de ellas al azar, respetando bordes y zonas de base protegidas.
6. `map_place_bases()` coloca bases dentro de cámaras 3×2 completamente selladas con ladrillos (o metal cuando la pared toca el borde del mapa).
7. `map_place_metal_border()` reemplaza el anillo exterior por metal irrompible.
8. `map_scatter_metal()` esparce bloques de metal en el interior, evitando zonas de base.
9. Opcionalmente, `map_check_connectivity()` verifica por BFS que el laberinto conecta ambas cámaras; si falla, se regenera el mapa.

### Pasillos de 1 tile
**Rationale:** Decisión del usuario. En una cuadrícula de 16×16, los pasillos de 1 tile permiten un laberinto denso y complejo. El sprite del tanque de 8×8 rozará visualmente las paredes, pero la hitbox reducida permite navegarlos.

### Protección de bases con cámaras 3×2 completamente selladas
**Rationale:** El escudo anterior dejaba la base expuesta por el frente y el corredor de conectividad recto generaba una línea de visión directa. Una cámara 3×2 sellada obliga al jugador a destruir al menos un ladrillo para acceder a la base, eliminando los atajos visuales y añadiendo tensión táctica.
**Patrón:** Para una base en (bx, by), la cámara ocupa `x=bx-1..bx+1` e `y=by..by±1` (frente a la base). La base se coloca en `(bx, by)`. Los laterales `(bx-1, by)` y `(bx+1, by)` son ladrillos. El muro frontal completo `(bx-1, by±1)`, `(bx, by±1)` y `(bx+1, by±1)` son ladrillos. La retaguardia queda protegida por el borde exterior de metal. Si una pared lateral cae en la columna 1 o 14, se usa metal irrompible en lugar de ladrillo, extendiendo el borde del mapa y reforzando la protección en posiciones extremas.
**Conectividad:** La cámara se marca como zona protegida antes de la división recursiva, por lo que el laberinto crece alrededor de ella sin túneles artificiales. El jugador llega a la cámara a través del laberinto natural y debe romper un ladrillo para entrar. Un BFS ligero opcional verifica que ambas cámaras estén en la misma región conectada.

### Borde exterior de metal + metal disperso
**Rationale:** El borde evita que entidades salgan de pantalla y proporciona un marco indestructible. El metal disperso añade obstáculos permanentes que obligan a tomar decisiones tácticas.
**Cantidad:** 5-10 bloques de metal en el interior, colocados solo sobre ladrillos y nunca dentro de las zonas de base protegidas por `map_is_base_zone(tx,ty)`.

## Risks / Trade-offs

- **[Risk]** El laberinto perfecto podría atrapar al jugador o dificultar el combate.
  → **Mitigation:** La erosión del 10 % de paredes internas crea ciclos y rutas alternativas, evitando pasillos únicos sin abrir demasiado el mapa.

- **[Risk]** La erosión podría dejar el mapa demasiado abierto o demasiado cerrado.
  → **Mitigation:** Probabilidad de erosión ajustada a 0.10 para mantener la sensación de laberinto denso con pocas rutas alternativas.

- **[Risk]** Los bloques de metal aleatorios podrían cortar rutas alternativas.
  → **Mitigation:** Solo se colocan sobre tiles de ladrillo, nunca sobre tiles vacíos, y nunca dentro de las zonas de base protegidas.

- **[Risk]** El tanque spawnea sobre la base aliada.
  → **Mitigation:** El spawn del jugador usa `BASE_ALLY_X` y se ubica en `y=12`, dos tiles por encima de la base aliada, fuera de la cámara sellada.

- **[Risk]** Una base sellada podría quedar aislada del laberinto si el generador coloca paredes alrededor.
  → **Mitigation:** Las cámaras se marcan como zonas protegidas antes de la división recursiva, y opcionalmente se verifica conectividad mediante BFS, regenerando el mapa si es necesario.

- **[Risk]** Al eliminar el corredor recto de conectividad podría persistir una línea de visión directa entre bases.
  → **Mitigation:** La conectividad depende únicamente del laberinto de división recursiva; al no tallar un túnel central, no hay garantía de línea recta despejada.

- **[Risk]** La colisión bala-tile por muestreo de un solo tile hace que disparos desde muy cerca traspasen el muro inmediato.
  → **Mitigation:** Se reemplaza el muestreo puntual por comprobación del tile actual y el tile frontal según la dirección de movimiento.

## Presupuestos previstos

- **Tokens:** La generación del mapa y las consultas de flags añaden ~100-150 tokens, dentro del límite de 8192 (`pico8.constraint.token-limit`).
- **CPU:** La generación ocurre en `_init`, fuera del presupuesto por frame. En `_update`/`_draw` solo se ejecutan `mget()` por entidad y una llamada a `map()`, ambos baratos (`pico8.constraint.cpu-throughput`).
- **Sprites:** Se usan los sprites 11-14; el 15 queda libre.
- **Mapa:** Se usa una región de 16×16 tiles dentro de los 128×32 disponibles (`pico8.constraint.map-size`).

## Open Questions

- ¿Las balas enemigas futuras también destruirán ladrillos? El diseño actual asume que cualquier bala consulta los mismos flags, por lo que la respuesta será sí sin cambios adicionales cuando llegue la IA.
- ¿Se añade un efecto visual o sonoro al romper un ladrillo? Dejado fuera del alcance; se puede agregar en un cambio posterior de pulido.
