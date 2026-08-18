## Why

El combate actual carece de toda respuesta visual y sonora: un enemigo muere instantáneamente con una sola bala y simplemente desaparece, y disparar no comunica ningún efecto sobre el tanque. El resultado se siente plano, sin "game feel". Se quiere que cada impacto (enemigo y jugador) y cada disparo lean claros y tengan peso, manteniendo el estilo minimalista del cartucho.

## What Changes

- Los enemigos dejan de morir con un único impacto: tienen vida (`ENEMY_HP`). Cada bala resta 1 de vida; al llegar a 0 el enemigo muere.
- El enemigo comunica el daño con color: su sprite migra progresivamente de su paleta original (gris/blanco) hacia rojo según la vida restante, y destella en blanco al recibir cada impacto.
- Al morir, el enemigo dispara una ráfaga explosiva procedural (destello blanco + anillo expansivo + escombros) visible ~0.5 s, además del sonido.
- Cada impacto en enemigo genera una pequeña chispa visual en el punto del golpe.
- Disparar produce retroceso físico real: el tanque recibe un impulso opuesto al cañón que se integra a través del sistema de colisiones existente (muros y enemigos lo frenan). El retroceso contra un enemigo vivo puede activar el daño por contacto existente (riesgo asumido por diseño).
- El cañón muestra un destello de fogonazo de 2 frames al disparar.
- Se añaden piezas de sonido con canales reservados (pico8.constraint.audio-channels): disparo corto (canal 1), golpe de impacto intermedio (canal 2), explosión al morir un enemigo (canal 0) y un retumbo de motor en bucle que suena mientras el tanque se desplaza (canal 3).

El marcador solo se incrementa en la muerte, no por impacto (`KILL_POINTS`).

## Capabilities

### New Capabilities

- `combat-feedback`: respuesta visual y sonora del combate: chispa de impacto, color de daño en el enemigo, explosión de muerte, fogonazo de disparo y retroceso físico del tanque, con sus efectos SFX (disparo, golpe, explosión) y el retumbo de motor del tanque mientras se mueve.

### Modified Capabilities

- `enemies`: el enemigo pasa a tener vida (`ENEMY_HP`) y deja de morir con un único impacto; el color del sprite refleja la vida restante; la muerte solo ocurre cuando la vida llega a 0, que es cuando se elimina, se otorgan puntos y se dispara la explosión.
- `projectiles`: la colisión de la bala pasa de "matar al enemigo" a "aplicar 1 de daño y desaparecer"; la bala se consume en cualquier impacto y dispara la respuesta visual/sonora correspondiente.

## Impact

Código afectado:

- `src/const.lua`: constantes nuevas (`ENEMY_HP`, retroceso, tintes, índices y canales de SFX, incluido el del motor).
- `src/enemy.lua`: campo `hp`, función de daño, muerte en vida 0 y dibujado con tinte según vida.
- `src/bullet.lua`: la colisión aplica daño en lugar de matar.
- `src/player.lua`: integración del retroceso físico, del fogonazo y del arranque/parada del retumbo de motor.
- `src/fx.lua` (nuevo): módulo de efectos transitorios (chispa y explosión), actualización y dibujo.
- `src/states.lua` y `src/ui.lua`: puntos de enganche de actualización y dibujo de efectos.
- `battle_tank.p8`: `#include` de `src/fx.lua` y autoría de los SFX en la sección `__sfx__` (incluido el retumbo de motor con rango de bucle).

Conocimiento de referencia:

- `pico8.api.pal`, `pico8.api.spr`, `pico8.api.circfill`, `pico8.api.pset`, `pico8.api.rectfill`, `pico8.api.rnd`, `pico8.api.time`, `pico8.api.cos`, `pico8.api.sin`.
- `pico8.api.sfx`, `pico8.constraint.audio-channels`, `pico8.constraint.sound-instruments`, `pico8.concept.audio-editors` (rango de bucle del SFX).
- `pico8.api.line`, `pico8.api.btn` (uso existente del retroceso y contacto en `player.lua`).

Presupuesto afectado:

- Tokens: ~+200-280 (tope `pico8.constraint.token-limit`: 8192).
- CPU por frame: despreciable en promedio; los efectos son transitorios y poco frecuentes (un enemigo a la vez).
- Sprites: ninguno nuevo (efectos procedurales, estilo rectfill actual).
- Audio: 4 de 64 SFX (0 explosión, 1 disparo, 2 golpe, 3 motor); 4 de 4 canales ocupados; sin canal libre para música futura (SFX y MUSIC comparten el bus, pico8.constraint.audio-channels).
- ROM/RAM: sin cambios significativos.