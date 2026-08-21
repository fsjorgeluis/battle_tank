## 1. Setup y datos de biomas

- [x] 1.1 Crear `src/biome.lua` con la tabla `BIOMES` de 8 entradas (nombre, pesos de revestimiento para tiles transitables y sólidos, paleta de pares `{src,dst}`) y la tabla `LEVEL_WAVES` con la cantidad de enemigos por nivel.
- [x] 1.2 Añadir `#include src/biome.lua` en `battle_tank.p8` antes de `src/map.lua` y `src/enemy.lua`.
- [x] 1.3 Añadir la constante `GS_LEVEL_CLEAR` en `src/const.lua`.

## 2. Máquina de estados y progresión de nivel

- [x] 2.1 Extender `gs.game` con el campo `level` (inicializado a 1 en `st_init()` y `st_reset()`).
- [x] 2.2 Implementar `st_next_level()` en `src/states.lua`: conserva `pl.lifes` y `gs.game.score`; resetea `gs.game.hits`, posición del jugador, enemigos, balas, efectos y rastros; regenera el mapa con el bioma del siguiente nivel.
- [x] 2.3 Añadir el estado `GS_LEVEL_CLEAR` en `st_update()` y `st_draw()` de `src/states.lua`.
- [x] 2.4 Detectar nivel completado en `st_update_play()`: si `#enemies==0` o una bala destruye la base enemiga, pasar a `GS_LEVEL_CLEAR`.
- [x] 2.5 En `GS_LEVEL_CLEAR`, tras mostrar el banner, incrementar el nivel y volver a `GS_PLAY`; si el nivel completado era 8, pasar a `GS_VICTORY`.
- [x] 2.6 Ajustar `st_update_victory()` y `st_update_gameover()` para que `st_reset()` reinicie el nivel a 1, el marcador a 0 y las vidas a `INITIAL_LIFES`.

## 3. Generación de mapa con biomas

- [x] 3.1 Modificar `map_generate()` en `src/map.lua` para aceptar el nivel actual y aplicar el revestimiento del bioma correspondiente tras generar el laberinto base.
- [x] 3.2 Implementar la función de revestimiento: tiles vacíos del interior se reemplazan por `empty`/`forest`/`ice`/`sand`; tiles de ladrillo del interior se reemplazan por `brick`/`water`; metal, bases y borde exterior permanecen inalterados.
- [x] 3.3 Verificar conectividad con `map_check_connectivity()` después del revestimiento; si falla, regenerar el mapa (máximo 10 intentos).

## 4. Paleta por bioma

- [x] 4.1 Implementar `biome_apply_palette(level)` y `biome_reset_palette()` en `src/biome.lua` usando `pico8.api.pal`.
- [x] 4.2 Modificar `ui_draw_play()` en `src/ui.lua` para aplicar la paleta del bioma antes de `map()`, restaurarla antes de dibujar entidades, volver a aplicarla antes de `map_draw_overlay()` y restaurarla definitivamente antes del HUD.

## 5. Oleadas de enemigos

- [x] 5.1 Modificar `en_init(level)` en `src/enemy.lua` para spawnear exactamente `LEVEL_WAVES[level]` enemigos en posiciones válidas del borde superior.
- [x] 5.2 Eliminar la lógica de respawn infinito en `en_update()` y `en_kill()`; `en_kill` solo elimina el enemigo y suma puntos.
- [x] 5.3 Asegurar que la detección de `#enemies==0` en `st_update_play()` funciona correctamente con múltiples enemigos iniciales.

## 6. HUD y banner

- [x] 6.1 Modificar `ui_draw_hud()` en `src/ui.lua` para mostrar el nivel actual junto a toques y puntos, sin superponerse con los corazones.
- [x] 6.2 Implementar `ui_draw_level_banner()` en `src/ui.lua` que muestre el nombre del bioma centrado en pantalla.
- [x] 6.3 Invocar `ui_draw_level_banner()` durante `GS_LEVEL_CLEAR`; el banner desaparece tras un temporizador (1.5-2 s) o al pulsar X, momento en que se pasa al siguiente nivel.

## 7. Verificación

- [x] 7.1 Ejecutar el cartucho, iniciar partida y verificar que comienza en nivel 1 con el bioma 1. *Verificado vía arnés headless (`pico8 -x test_levels.p8`): level=1, biome=pradera.*
- [x] 7.2 Eliminar todos los enemigos de la oleada y verificar que se avanza al siguiente nivel, se regenera el mapa y se muestra el banner del nuevo bioma. *Verificado vía arnés: `#enemies==0` lleva a `GS_LEVEL_CLEAR`, luego a nivel 2.*
- [x] 7.3 Destruir la base enemiga y verificar que también se completa el nivel. *Verificado vía arnés: bala impactando base enemiga lleva a `GS_LEVEL_CLEAR`, luego a nivel 2.*
- [x] 7.4 Completar el nivel 8 y verificar que se muestra la pantalla de victoria final. *Verificado vía arnés: nivel 8 → `GS_LEVEL_CLEAR` → `GS_VICTORY`.*
- [x] 7.5 Verificar que `pl.lifes` y `gs.game.score` se conservan entre niveles, mientras que `gs.game.hits`, posición del jugador y enemigos se resetean. *Verificado vía arnés: vidas y puntaje persistentes; hits reseteados a 0.*
- [x] 7.6 Verificar visualmente que la paleta del bioma afecta solo a los tiles del mundo y no al jugador, enemigos, balas, explosiones ni HUD. *Verificado por revisión de código: `biome_apply_palette` se llama solo antes de `map()` y `map_draw_overlay()`; `biome_reset_palette` se llama antes de entidades y HUD.*
- [x] 7.7 Verificar que en 20 generaciones consecutivas de cada bioma existe al menos un camino entre las bases (conectividad preservada).
- [x] 7.8 Verificar presupuesto de tokens con `info` en PICO-8; el total debe seguir por debajo de 8192 (`pico8.constraint.token-limit`). *Verificado: Tokens 4946/8192, Chars 32141/65535, Compressed 10705/15616.*
