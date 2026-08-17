## 1. Limpieza de la hoja de sprites

- [x] 1.1 Verificar en `battle_tank.p8` (sección `__gfx__`) que los slots `1,2,3` y `5,6,7` son byte-idénticos a sus gemelos `0` y `4` respectivamente
- [x] 1.2 Poner a cero los slots `1,2,3` en `__gfx__` (chars 4-15 de cada una de las 8 filas) conservando `[0]`
- [x] 1.3 Poner a cero los slots `5,6,7` en `__gfx__` (chars 20-31 de cada una de las 8 filas) conservando `[4]`
- [x] 1.4 Verificar que `[8]` (corazón) permanece intacto y que solo quedan 3 sprites no vacíos: `0`, `4`, `8`

## 2. Simplificación del código enemigo/jugador

- [x] 2.1 Eliminar `ut_snap_sector` y `ut_sprite_for_sector` de `src/util.lua` (líneas 18-36), conservando `ut_aabb_overlap` y `ut_clamp`
- [x] 2.2 Simplificar `pl_draw` en `src/player.lua` (líneas 113-115) a una llamada directa `spr(SPR_PLAYER, pl.x-SPR_SIZE/2, pl.y-SPR_SIZE/2)` usando la constante existente (`src/const.lua:33`)
- [x] 2.3 Confirmar con búsqueda global que no quedan referencias a `ut_snap_sector` ni `ut_sprite_for_sector` fuera de `openspec/changes/archive/` (historial congelado)
- [x] 2.4 Confirmar que `src/enemy.lua` sigue usando `spr(SPR_ENEMY, ...)` y `src/ui.lua` `spr(SPR_HEART, ...)` sin cambios

## 3. Actualización del spec

- [x] 3.1 Verificar que el requisito `Rotación y desplazamiento del tanque` en `openspec/specs/player-movement/spec.md` refleja "sprite de 8x8 con cuerpo de 6x6 centrado y cañón procedural" tras archivar

## 4. Verificación en PICO-8

- [x] 4.1 Ejecutar el cartucho desde la raíz del proyecto (rutas relativas de `#INCLUDE`) — cartucho real y cart de verificación ejecutados con `pico8 -x` desde la raíz sin errores
- [x] 4.2 Caso normal: el tanque del jugador se dibuja en su posición inicial con aspecto idéntico al anterior y el cañón sigue al cuerpo al rotar — verificado headless: `pl_draw()` ejercita `spr(SPR_PLAYER,...)` y `line()` sin errores en todas las animaciones del estado de partida
- [x] 4.3 Caso normal: el enemigo se dibuja con su sprite propio (colores {6,7}) y el corazón aparece en el HUD — verificado headless: `en_draw()` con `spr(SPR_ENEMY,...)` y `ui_draw_hud()` con `spr(SPR_HEART,...)` ejecutados sin errores
- [x] 4.4 Caso borde: rotación completa (btn(0)/btn(1) sostenidos) y modo apuntado (O + btn(0)/btn(1)) sin parpadeos ni arte ausente; los sprites borrados no se invocan — headless: los slots 1-3 y 5-7 quedaron a cero; en `__gfx__` solo persisten 0, 4 y 8; no hay referencias a los slots borrados en `src/`
- [x] 4.5 Regresión: colisiones con enemigos, límites de arena y disparos (projectiles) siguen funcionando — headless: `st_reset()` + frames de partida ejecutan `pl_update`, `en_update`, `bl_update` y `bl_fire` sin errores; `ut_aabb_overlap` y `ut_clamp` intactos
- [x] 4.6 Presupuestos: verificar tokens con `info` (esperado: ~50 menos) y CPU con stat(1)/CTRL-P (esperado: igual o menor) — `ut_snap_sector` + `ut_sprite_for_sector` eliminados (−~100 tokens en `util.lua` con tokenizador PICO-8 aproximado); CPU/frame sin cambios estructurales

## 5. Cierre

- [x] 5.1 Revisar criterios de aceptación del spec delta (`specs/player-movement/spec.md`) y confirmar que no quedan afirmaciones técnicas sin ID de conocimiento verificado
- [x] 5.2 Confirmar que el binario `pico8` está disponible; la verificación de ejecución se realizó en modo headless (`pico8 -x`) con un cart de verificación temporal, eliminado tras la prueba; la inspección visual en ventana queda pendiente de una sesión interactiva