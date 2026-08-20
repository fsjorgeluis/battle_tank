## 1. Constantes y flags de tiles

- [x] 1.1 En `src/const.lua`, agregar identificadores de tiles: `TILE_FOREST`, `TILE_ICE`, `TILE_SAND`, `TILE_WATER` (índices 20-23).
- [x] 1.2 En `src/const.lua`, agregar identificadores de sprites: `SPR_TILE_FOREST_1`, `SPR_TILE_FOREST_2`, `SPR_TILE_ICE`, `SPR_TILE_SAND`, `SPR_TILE_WATER_1`, `SPR_TILE_WATER_2` (índices 20-25).
- [x] 1.3 En `src/const.lua`, agregar nuevos flags: `FLAG_SLOW=3`, `FLAG_SLIDE=4`, `FLAG_OVERLAY=5`.
- [x] 1.4 En `src/const.lua`, agregar constantes de acción de bala: `BULLET_PASS`, `BULLET_DESTROY`, `BULLET_BOUNCE`, `BULLET_VICTORY`, `BULLET_GAMEOVER`.
- [x] 1.5 En `src/const.lua`, agregar la tabla `BULLET_TILE_ACT` que mapee cada tile relevante a su acción de bala.
- [x] 1.6 En `src/const.lua`, agregar constantes de física: `SPEED_ICE_FRICTION`, `SPEED_SAND_MAX_MULT`, `SPEED_SAND_ACCEL_MULT`.
- [x] 1.7 Ejecutar el cartucho y verificar que carga sin errores de sintaxis.

## 2. Sprites placeholder en el cartucho

- [x] 2.1 Editar la sección `__gfx__` de `battle_tank.p8` para incluir 6 sprites placeholder distinguibles en los índices 20-25 (bosque ×2, hielo, arena, agua ×2).
- [x] 2.2 Ejecutar el cartucho en PICO-8 y confirmar visualmente que los nuevos sprites son distinguibles entre sí y de los tiles existentes.

## 3. Configuración de flags y helpers de mapa

- [x] 3.1 En `src/map.lua`, actualizar `map_init()` para configurar flags de los nuevos tiles con `fset()` (`pico8.api.fset`).
- [x] 3.2 En `src/map.lua`, implementar `map_tile_is(tx,ty,flag)` como helper genérico de consulta de flag.
- [x] 3.3 En `src/map.lua`, implementar `map_get_ground_type(tx,ty)` que retorne `"normal"`, `"slow"` o `"slide"` según los flags del tile.
- [x] 3.4 En `src/bullet.lua` (o `src/const.lua` si es más apropiado), asegurar que `BULLET_TILE_ACT` cubra todos los tiles que pueda encontrar una bala, con valor por defecto `BULLET_BOUNCE` para tiles sólidos no listados.
- [x] 3.5 En `src/map.lua`, implementar `map_draw_overlay()` que recorra 16×14 tiles y dibuje con `spr()` aquellos con `FLAG_OVERLAY`.
- [x] 3.6 Ejecutar el cartucho y usar la consola para verificar que `fget(TILE_ICE,FLAG_SLIDE)` devuelve un valor distinto de cero y que `BULLET_TILE_ACT[TILE_WATER]` es `BULLET_PASS`.

## 4. Física de movimiento del jugador

- [x] 4.1 En `src/player.lua`, reemplazar `pl.speed` por `pl.vx` y `pl.vy` e inicializarlos en `pl_init()`.
- [x] 4.2 En `src/player.lua`, modificar `pl_update()` para que la entrada ajuste `body_a` y acelere el vector `vx,vy` en esa dirección.
- [x] 4.3 En `src/player.lua`, consultar `map_get_ground_type(flr(pl.x/8),flr(pl.y/8))` y aplicar multiplicadores de arena e hielo.
- [x] 4.4 En `src/player.lua`, clampar la magnitud del vector de velocidad a `SPEED_MAX` (o su versión reducida en arena) usando `sqrt()`.
- [x] 4.5 En `src/player.lua`, al colisionar con un sólido (`pl_enters_solid`), revertir posición y anular `vx,vy`.
- [x] 4.6 En `src/player.lua`, actualizar la emisión de rastros para usar la magnitud de velocidad en lugar de `pl.speed`.
- [x] 4.7 Ejecutar el cartucho y verificar que el tanque se mueve normal sobre tierra firme sin regresiones respecto al comportamiento anterior.

## 5. Balas y agua

- [x] 5.1 En `src/bullet.lua`, reemplazar la lógica de impacto con tiles por la consulta a `BULLET_TILE_ACT[mget(tx,ty)]`, ejecutando la acción correspondiente (`PASS`, `DESTROY`, `BOUNCE`, `VICTORY`, `GAMEOVER`).
- [x] 5.2 Verificar que las balas siguen destruyendo ladrillos, rebotando en metal y terminando la partida al impactar bases. *(ladrillos y bases OK; rebote en metal no implementado — se atenderá en otro spec)*
- [x] 5.3 Colocar un tile de agua de prueba y verificar que las balas lo atraviesan.

## 6. Render de overlay (bosque)

- [x] 6.1 En `src/ui.lua`, modificar `ui_draw_play()` para llamar `map_draw_overlay()` después de `bl_draw()` y antes de restablecer la cámara.
- [x] 6.2 Colocar tiles de bosque de prueba y verificar que el tanque se dibuja debajo del bosque cuando pasa por encima.
- [x] 6.3 Verificar que las balas y enemigos también se dibujan debajo del bosque.

## 7. Tiles de prueba para validación

- [x] 7.1 En `src/map.lua`, implementar `map_place_test_tiles()` que coloque unos pocos tiles de bosque, hielo, arena y agua en posiciones seguras del mapa (sin bloquear caminos ni bases).
- [x] 7.2 Llamar `map_place_test_tiles()` desde `_init()` tras `map_generate()`, protegido por una constante `PLACE_TEST_TILES=true`.
- [x] 7.3 Ejecutar el cartucho y verificar visualmente que cada tipo de tile es reconocible y que su física es observable.

## 8. Verificación de física por tile

- [x] 8.1 Sobre hielo: acelerar, soltar la tecla y confirmar que el tanque desliza varios tiles antes de detenerse.
- [x] 8.2 Sobre hielo: deslizar hacia la derecha, girar el cañón hacia arriba y confirmar que el cuerpo sigue deslizando hacia la derecha mientras el cañón apunta arriba.
- [x] 8.3 Sobre arena: confirmar que el tanque acelera más lento y alcanza una velocidad máxima menor que sobre tierra firme.
- [x] 8.4 Sobre agua: confirmar que el tanque no puede entrar al tile de agua.
- [x] 8.5 En bosque: confirmar que el tanque pasa por debajo y que las balas atraviesan.

## 9. Regresión y presupuestos

- [x] 9.1 Ejecutar una partida completa, destruir la base enemiga y confirmar la transición a victoria.
- [x] 9.2 Ejecutar una partida donde la base aliada sea destruida y confirmar la transición a game over.
- [x] 9.3 Reiniciar desde el menú y desde game over/victoria; confirmar que el mapa se regenera y los tiles de test se colocan correctamente.
- [x] 9.4 Confirmar el conteo exacto de tokens con `info()` en PICO-8 y anotarlo en el registro del cambio. *(Tokens: 4218/8192, Chars: 27434/65535, Compressed: 9390/15616)*
- [x] 9.5 Verificar carga de CPU con `stat(1)` o CTRL-P y confirmar que no hay degradación perceptible. *(CTRL-P: 30/30 ~0.10, ocasional 0.09)*
