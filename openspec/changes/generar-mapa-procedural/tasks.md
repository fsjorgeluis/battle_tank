## 1. Preparar assets y flags de sprite

- [x] 1.1 Dibujar el sprite 14 (base enemiga) en el editor de sprites de PICO-8.
- [x] 1.2 Configurar flags de sprite: sprite 11 (ladrillo) con flag 0 y flag 1; sprite 12 (metal) con flag 0; sprite 13 (base aliada) con flag 0 y flag 2; sprite 14 (base enemiga) con flag 0 y flag 2.
- [ ] 1.3 Verificar en consola que `fget(11,0)`, `fget(11,1)`, `fget(12,0)`, `fget(13,0)`, `fget(13,2)`, `fget(14,0)` y `fget(14,2)` devuelven `true`.
- [x] 1.4 Confirmar que la sección `__gfx__` del `.p8` conserva los sprites dibujados por el usuario tras cualquier operación de código.

## 2. Crear módulo de generación de mapa

- [x] 2.1 Crear `map.lua` con constantes `MAP_W=16`, `MAP_H=16`, `TILE_BRICK=11`, `TILE_METAL=12`, `TILE_BASE_ALLY=13`, `TILE_BASE_ENEMY=14`, `FLAG_SOLID=0`, `FLAG_BREAKABLE=1`, `FLAG_BASE=2`.
- [x] 2.2 Implementar `map_clear()` que llene la región 16×16 con ladrillo (`mset`).
- [x] 2.3 Implementar `map_place_base_with_shield()`: limpiar un área 4×3 frente a la base, colocar la base y su escudo de ladrillos con apertura frontal de 2 tiles.
- [x] 2.4 Reimplementar `map_dig_path()` como `map_recursive_division(x, y, w, h)` que genere un laberinto perfecto con pasillos de 1 tile, trazando paredes y abriendo una puerta por división.
- [x] 2.5 Implementar `map_erode_walls(prob)` que elimine paredes interiores al azar (probabilidad 0.10) para crear pocas rutas alternativas, respetando bordes y zonas de base.
- [x] 2.6 Implementar `map_place_metal_border()` que reemplace el anillo exterior por metal.
- [x] 2.7 Implementar `map_scatter_metal(count)` que coloque de 5 a 10 bloques de metal sobre ladrillos interiores, nunca dentro del escudo de una base.
- [x] 2.8 Implementar `map_ensure_base_connectivity()` que talla un corto corredor de 1 tile desde la apertura frontal de cada base hacia el laberinto para garantizar conectividad.
- [x] 2.9 Actualizar `map_generate()` para invocar los pasos en orden: limpiar, dejar borde y limpiar interior, división recursiva, erosión, colocar bases con escudo, garantizar conectividad de bases, borde de metal, metal disperso.
- [x] 2.9 Eliminar `map_randomize()`, `map_cellular_automata()` y `map_thicken_walls()` (reemplazados por división recursiva + erosión).

## 3. Integrar renderizado del mapa

- [x] 3.1 En `_draw`, llamar `map(0,0,0,0,16,16)` antes de dibujar entidades.
- [ ] 3.2 Verificar visualmente que el mapa aparece detrás del jugador, enemigos y balas.

## 4. Actualizar colisiones del jugador

- [x] 4.1 Implementar función auxiliar `map_is_solid(tx,ty)` usando `fget(mget(tx,ty), FLAG_SOLID)`.
- [x] 4.2 Actualizar `player.lua` para que el movimiento consulte `map_is_solid` en los tiles que cubre la hitbox del tanque.
- [ ] 4.3 Verificar que el jugador no atraviesa ladrillos, metal ni bases.
- [ ] 4.4 Verificar que el jugador puede moverse cómodamente por pasillos de 2 tiles.

## 5. Corregir interacción bala-tile

- [x] 5.1 Actualizar `bullet.lua` para que cada bala consulte el tile de su centro cada frame.
- [x] 5.2 Si el tile tiene flag 1 (rompible), destruirlo con `mset(tx,ty,0)` y eliminar la bala.
- [x] 5.3 Si el tile tiene flag 0 (sólido) pero no flag 1, eliminar la bala sin destruir el tile.
- [x] 5.4 Si el tile tiene flag 2 (base), eliminar la bala y notificar al sistema de estado.
- [x] 5.5 Corregir el tile de spawn para que sea el tile del jugador (no el punto de nacimiento de la bala) y añadir chequeo del tile frontal según dirección de movimiento.
- [ ] 5.6 Verificar que disparar pegado a un ladrillo destruye ese ladrillo, no el contiguo.
- [ ] 5.7 Verificar que las balas rebotan en metal y detonan bases.

## 6. Añadir condiciones de victoria y derrota

- [x] 6.1 Añadir estado global `victoria` a la máquina de estados en `states.lua`.
- [x] 6.2 Implementar transición a estado victoria cuando una bala impacta la base enemiga.
- [x] 6.3 Implementar transición a estado game over cuando una bala impacta la base aliada.
- [x] 6.4 Dibujar pantalla de victoria con mensaje y prompt de X para reintentar.
- [ ] 6.5 Verificar que al reintentar desde victoria o game over se regenera el mapa y se reinicia la partida.

## 7. Actualizar posiciones de spawn

- [x] 7.1 Posicionar al jugador en el centro del tile (7,12), dos tiles debajo de la base aliada, al iniciar la partida.
- [x] 7.2 Implementar función `map_find_empty_top_spawn()` que devuelva un tile vacío de la fila 1 o 2.
- [x] 7.3 Usar esa función para colocar al enemigo en su spawn inicial.
- [ ] 7.4 Verificar que el enemigo no spawnea dentro del escudo de la base enemiga ni dentro de un muro.

## 8. Validación final y ajustes

- [ ] 8.1 Ejecutar el cartucho y jugar una partida completa: destruir la base enemiga y verificar victoria.
- [ ] 8.2 Ejecutar otra partida, permitir que destruyan la base aliada y verificar derrota.
- [ ] 8.3 Verificar que el mapa es diferente en cada partida.
- [ ] 8.4 Verificar que existe al menos un camino desde la base aliada hasta la base enemiga.
- [ ] 8.5 Verificar que los pasillos son de 1 tile, que el mapa se siente laberíntico y que la erosión crea rutas alternativas.
- [ ] 8.6 Verificar que las bases están protegidas por ladrillos.
- [ ] 8.7 Comprobar tokens con `info` y CPU con `stat(1)` o CTRL-P.
- [x] 8.8 Ajustar probabilidad de erosión de paredes a 0.10, rediseñar escudos de base con área 4×3 y añadir conectividad garantizada para que el mapa se sienta laberíntico y las bases estén protegidas.
