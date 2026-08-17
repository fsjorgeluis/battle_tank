## Why

La iteración previa (`add-movement-and-gameover`, `fix-tank-and-enemy-sprites`)
dejó el cañón listo pero inerte: `pl.turret_a` rota con el toggle de apuntado
pero no dispara. Este cambio hace que el cañón dispare balas que matan al
enemigo, introduciendo la primera mecánica de objetivo en el juego y un
marcador de puntos por baja. Es el primer uso real del cañón y prepara el
terreno para el spawner de enemigos futuro.

## What Changes

- **Disparo del cañón**: pulsar X (btnp(5)) en estado partida dispara una bala
  desde la boca del cañón en dirección `pl.turret_a`, tanto en modo normal como
  en modo apuntado. Una cadencia mínima (cooldown) limita la tasa de disparo.
- **Bala procedural**: la bala se dibuja con `rectfill` (0 sprites) y avanza a
  velocidad constante por frame. Se elimina al salir de la arena o por
  timeout (no hay muros que la detengan en esta iteración).
- **Muerte del enemigo**: cuando la bala colisiona (AABB) con el enemigo vivo,
  la bala desaparece y el enemigo muere.
- **Marcador**: cada baja suma puntos (`gs.game.score += KILL_POINTS`), se
  muestra en el HUD durante la partida y en la pantalla de game over.
- **Respawn del enemigo**: el enemigo muerto reaparece tras un retardo en otra
  zona de la arena (distinta de la que ocupaba), manteniendo la presión del
  enemigo estático como amenaza.
- **Enemigo como lista**: el enemigo pasa de ser un singleton (`en`) a una
  lista `enemies`, preparando la estructura para el spawner que llegará en una
  iteración futura.
- **Gating por vivos**: el daño por contacto y el bloqueo sólido solo aplican
  a enemigos vivos; un enemigo muerto no sigue dañando ni bloqueando.
- **Reinicio limpio**: `st_reset()` limpia las balas, reinicia el marcador y
  re-siembra el enemigo en su zona inicial.

## Capabilities

### New Capabilities

- `projectiles`: disparo de balas desde el cañón del jugador, movimiento,
  despawn y colisión con enemigos.
- `score`: marcador incremental por baja del enemigo, visible en HUD y game
  over, reiniciado en cada partida.

### Modified Capabilities

- `enemies`: el enemigo pasa de estático inmortal a entidad que puede morir por
  una bala y reaparecer en otra zona tras un retardo; además se modela como
  lista (`enemies`) en lugar de singleton `en`.
- `game-flow`: el estado partida acepta la entrada de disparo (X) y el reinicio
  limpio (`st_reset`) ahora limpia también balas y marcador.

## Impact

- **Código**: nuevo módulo `src/bullet.lua` (prefijo `bl_`, tabla `bl` con lista
  `bullets`); modificación de `enemy.lua` (lista de enemigos + respawn),
  `player.lua` (colisiones contra la lista y solo vivos), `states.lua`
  (entrada de disparo en `st_update_play`, reset limpio), `const.lua` y `ui.lua`
  (marcador en HUD, dibujado de balas). Se añade el `#INCLUDE` de balas en
  `battle_tank.p8`.
- **Tokens**: presupuesto objetivo +60..120 sobre el total actual (módulo de
  balas + entrada de disparo + gating de vivos) (`pico8.constraint.token-limit`).
- **Sprites**: 0 sprites nuevos; la bala es procedural con `rectfill`
  (`pico8.api.rectfill`, `pico8.constraint.sprite-count`).
- **CPU**: coste por frame mínimo (una bala por disparo ocasional × AABB);
  el bucle sigue corriendo a 30fps (`pico8.concept.game-loop`,
  `pico8.constraint.cpu-throughput`).
- **Audio**: sin SFX en esta iteración; se mantiene la reserva de canales de
  `design.md` D8 para shoot/hit/explosion (`pico8.constraint.audio-channels`).
- **Entrada**: X (btnp(5)) dispara en estado partida; `btnp` se resetea al
  inicio de cada `_update` y repite tras 15 frames cada 4 (`pico8.api.btnp`,
  `pico8.constraint.controller-button-count`).
- **Mapa**: sin uso; el respawn elige zonas libres de la arena 128x128
  (`pico8.constraint.display-resolution`).