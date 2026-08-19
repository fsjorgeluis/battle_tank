## 1. Preparar assets y flags de sprite

- [x] 1.1 Dibujar el sprite 14 (base enemiga) en el editor de sprites de PICO-8.
- [x] 1.2 Configurar flags de sprite: sprite 11 (ladrillo) con flag 0 y flag 1; sprite 12 (metal) con flag 0; sprite 13 (base aliada) con flag 0 y flag 2; sprite 14 (base enemiga) con flag 0 y flag 2.
- [x] 1.3 Verificar en consola que `fget(11,0)`, `fget(11,1)`, `fget(12,0)`, `fget(13,0)`, `fget(13,2)`, `fget(14,0)` y `fget(14,2)` devuelven un valor verdadero (en PICO-8 la consola no imprime booleanos directamente; usar `print(fget(11,0))` para ver el resultado).
- [x] 1.4 Confirmar que la sección `__gfx__` del `.p8` conserva los sprites dibujados por el usuario tras cualquier operación de código.

## 2. Crear módulo de generación de mapa

- [x] 2.1 Crear `map.lua` con constantes `MAP_W=16`, `MAP_H=16`, `TILE_BRICK=11`, `TILE_METAL=12`, `TILE_BASE_ALLY=13`, `TILE_BASE_ENEMY=14`, `FLAG_SOLID=0`, `FLAG_BREAKABLE=1`, `FLAG_BASE=2`.
- [x] 2.2 Implementar `map_clear()` que llene la región 16×16 con ladrillo (`mset`).
- [x] 2.3 Elegir `BASE_ENEMY_X` y `BASE_ALLY_X` aleatorias en `[2, 13]` al inicio de `map_generate()`.
- [x] 2.4 Implementar `map_is_base_zone(tx,ty)` que devuelva `true` para los rectángulos de 3×2 tiles alrededor de cada base.
- [x] 2.5 Reimplementar `map_place_base_with_shield(bx,by,s)` para crear una cámara 3×2 completamente sellada: base central, paredes laterales y muro frontal de ladrillos; usar metal cuando la pared toque el borde del mapa (`x=1` o `x=14`).
- [x] 2.6 Reimplementar `map_dig_path()` como `map_recursive_division(x, y, w, h)` que genere un laberinto perfecto con pasillos de 1 tile, trazando paredes y abriendo una puerta por división, sin colocar paredes dentro de `map_is_base_zone(tx,ty)`.
- [x] 2.7 Actualizar `map_erode_walls(prob)` para que respete `map_is_base_zone(tx,ty)` en lugar de rangos hardcodeados.
- [x] 2.8 Implementar `map_place_metal_border()` que reemplace el anillo exterior por metal.
- [x] 2.9 Actualizar `map_scatter_metal(count)` para que respete `map_is_base_zone(tx,ty)` en lugar de rangos hardcodeados.
- [x] 2.10 Eliminar `map_ensure_base_connectivity()` o reemplazarlo por `map_check_connectivity()` (BFS ligero) que verifique que ambas cámaras están conectadas; regenerar si falla.
- [x] 2.11 Actualizar `map_generate()` para invocar los pasos en orden: elegir posiciones de bases, limpiar, dejar borde y limpiar interior, división recursiva (respetando zonas de base), erosión, colocar bases con cámara sellada, borde de metal, metal disperso, verificación de conectividad.
- [x] 2.12 Eliminar `map_randomize()`, `map_cellular_automata()` y `map_thicken_walls()` (reemplazados por división recursiva + erosión).

## 3. Integrar renderizado del mapa

- [x] 3.1 En `_draw`, llamar `map(0,0,0,0,16,16)` antes de dibujar entidades.
- [x] 3.2 Verificar visualmente que el mapa aparece detrás del jugador, enemigos y balas.

## 4. Actualizar colisiones del jugador

- [x] 4.1 Implementar función auxiliar `map_is_solid(tx,ty)` usando `fget(mget(tx,ty), FLAG_SOLID)`.
- [x] 4.2 Actualizar `player.lua` para que el movimiento consulte `map_is_solid` en los tiles que cubre la hitbox del tanque.
- [x] 4.3 Verificar que el jugador no atraviesa ladrillos, metal ni bases.
- [x] 4.4 Verificar que el jugador puede moverse cómodamente por pasillos de 1 tile.

## 5. Corregir interacción bala-tile

- [x] 5.1 Actualizar `bullet.lua` para que cada bala consulte el tile de su centro cada frame.
- [x] 5.2 Si el tile tiene flag 1 (rompible), destruirlo con `mset(tx,ty,0)` y eliminar la bala.
- [x] 5.3 Si el tile tiene flag 0 (sólido) pero no flag 1, eliminar la bala sin destruir el tile.
- [x] 5.4 Si el tile tiene flag 2 (base), eliminar la bala y notificar al sistema de estado.
- [x] 5.5 Corregir el tile de spawn para que sea el tile del jugador (no el punto de nacimiento de la bala) y añadir chequeo del tile frontal según dirección de movimiento.
- [x] 5.6 Verificar que disparar pegado a un ladrillo destruye ese ladrillo, no el contiguo.
- [x] 5.7 Verificar que las balas desaparecen al impactar metal y detonan bases.

## 6. Añadir condiciones de victoria y derrota

- [x] 6.1 Añadir estado global `victoria` a la máquina de estados en `states.lua`.
- [x] 6.2 Implementar transición a estado victoria cuando una bala impacta la base enemiga.
- [x] 6.3 Implementar transición a estado game over cuando una bala impacta la base aliada.
- [x] 6.4 Dibujar pantalla de victoria con mensaje y prompt de X para reintentar.
- [x] 6.5 Verificar que al reintentar desde victoria o game over se regenera el mapa y se reinicia la partida.

## 7. Actualizar posiciones de spawn

- [x] 7.1 Posicionar al jugador en el centro del tile (`BASE_ALLY_X`,12), dos tiles por encima de la base aliada, al iniciar la partida.
- [x] 7.2 Actualizar `map_find_empty_top_spawn()` para que excluya la zona de la cámara de la base enemiga (`x=BASE_ENEMY_X-1..BASE_ENEMY_X+1`, `y=1..2`) y devuelva un tile vacío de la fila 1 o 2.
- [x] 7.3 Usar esa función para colocar al enemigo en su spawn inicial.
- [x] 7.4 Verificar que el enemigo no spawnea dentro de la cámara sellada de la base enemiga ni dentro de un muro.

## 8. Validación final y ajustes

- [x] 8.1 Ejecutar el cartucho y jugar una partida completa: destruir la base enemiga y verificar victoria.
- [x] 8.2 Ejecutar otra partida, permitir que destruyan la base aliada y verificar derrota.
- [x] 8.3 Verificar que el mapa es diferente en cada partida.
- [x] 8.4 Verificar que existe al menos un camino a través del laberinto para acercarse a ambas bases, sin corredores rectos artificiales.
- [x] 8.5 Verificar que no hay línea de visión directa desde la zona de spawn del jugador hasta la base enemiga.
- [x] 8.6 Verificar que las bases están completamente rodeadas por ladrillos destruibles (o metal en el borde del mapa), sin aperturas permanentes.
- [x] 8.7 Comprobar tokens con `info` y CPU con `stat(1)` o CTRL-P.
  - Tokens: 3791 / 8192
  - Chars: 23635 / 65535
  - Compressed: 8122 / 15616
  - `stat(1)` no imprime en la terminal de PICO-8; devuelve un valor que debe mostrarse con `print(stat(1))` o en el medidor CTRL-P.
- [x] 8.8 Ajustar probabilidad de erosión de paredes a 0.10, rediseñar escudos de base con área 4×3 y añadir conectividad garantizada para que el mapa se sienta laberíntico y las bases estén protegidas.
