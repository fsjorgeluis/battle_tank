## 1. Constantes y límites derivados

- [x] 1.1 Agregar `HUD_H = 16` en `src/const.lua`.
- [x] 1.2 Definir `WORLD_W = MAP_W * 8` y `WORLD_H = MAP_H * 8` en `src/const.lua` (o en `src/map.lua` si se prefiere mantenerlas junto a las dimensiones del mapa), documentando que representan el tamaño lógico del mundo en píxeles.
- [x] 1.3 Revisar que ninguna otra constante asuma 128 píxeles de alto para el mundo.

## 2. Separación visual del HUD

- [x] 2.1 Modificar `ui_draw_play()` en `src/ui.lua` para aplicar `camera(0, -HUD_H)` antes de dibujar el mundo y las entidades.
- [x] 2.2 Modificar `ui_draw_play()` en `src/ui.lua` para llamar `camera(0, 0)` inmediatamente antes de `ui_draw_hud()`.
- [x] 2.3 Verificar que `ui_draw_hud()` sigue usando coordenadas de pantalla fijas y no requiere cambios.
- [x] 2.4 Ejecutar el cartucho y confirmar visualmente que el HUD no se solapa con tiles del borde superior.

## 3. Redimensión del mapa procedural

- [x] 3.1 Cambiar `MAP_H = 16` a `MAP_H = 14` en `src/map.lua`.
- [x] 3.2 Actualizar `map_place_bases()` para ubicar la base aliada en la fila 12 en lugar de la fila 14.
- [x] 3.3 Actualizar `map_is_base_zone()` para reflejar la nueva zona de la base aliada (filas 11 y 12).
- [x] 3.4 Actualizar `map_place_base_with_shield()` para que el límite interior de colocación de paredes sea `MAP_H - 2` (fila 12) en lugar de 14.
- [x] 3.5 Actualizar `map_check_connectivity()` para iniciar el BFS en `{BASE_ALLY_X, 10}` (dos filas arriba de la nueva base aliada).
- [x] 3.6 Corregir `map_erode_walls()` para que itere `y=2,MAP_H-3` en lugar de `y=2,MAP_W-3`.
- [x] 3.7 Actualizar el requerimiento de render del mapa a `map(0, 0, 0, 0, 16, 14)` en `src/ui.lua`.
- [x] 3.8 Ejecutar el cartucho y verificar que el mapa generado cabe debajo del HUD sin cortes ni solapamientos.

## 4. Ajuste de spawn y límites del jugador

- [x] 4.1 Modificar `pl_init()` en `src/player.lua` para spawner al jugador en el tile (`BASE_ALLY_X`, 10), dos filas por encima de la base aliada.
- [x] 4.2 Reemplazar el clamp vertical `ut_clamp(pl.y, SPR_SIZE/2, 127-SPR_SIZE/2)` por `ut_clamp(pl.y, SPR_SIZE/2, WORLD_H-SPR_SIZE/2)` en `src/player.lua`.
- [x] 4.3 Ejecutar el cartucho y comprobar que el jugador no puede atravesar el borde inferior ni superior del mundo.

## 5. Ajuste de límites de balas

- [x] 5.1 Reemplazar el límite vertical de desecho de balas en `src/bullet.lua` (`b.y > 127+BULLET_SIZE`) por `b.y > WORLD_H+BULLET_SIZE`.
- [x] 5.2 Mantener el límite horizontal derivado de `WORLD_W` si aplica, o verificar que el valor actual siga correcto.
- [x] 5.3 Ejecutar el cartucho y comprobar que las balas desaparecen al salir del área jugable por cualquier borde.

## 6. Verificación final y regresión

- [x] 6.1 Ejecutar una partida completa: destruir la base enemiga y confirmar la transición a victoria.
- [x] 6.2 Ejecutar una partida donde la base aliada sea destruida y confirmar la transición a game over.
- [x] 6.3 Reiniciar desde el menú y desde game over/victoria; confirmar que el mapa se regenera y el HUD se dibuja correctamente.
- [x] 6.4 Verificar tokens con `info` en PICO-8 y confirmar que no hay aumento inesperado.
- [x] 6.5 Verificar carga de CPU con `stat(1)` o CTRL-P y confirmar que no hay degradación perceptible.
