## Why

El sonido del motor del tanque es un blip único, activado por flanco (`src/player.lua:60-68`): se dispara una vez al cruzar `speed >= 0.15` y se corta en seco al soltar la tecla. No transmite el estado del movimiento: un jugador no puede "oír" si está acelerando, manteniendo velocidad o deslizándose a cero. Un rumble que responde a la aceleración hace la conducción más legible y satisfactoria, con coste casi nulo (1 slot SFX, 1 canal).

## What Changes

- Reemplazar el disparo de flanco de `SFX_MOTOR` por un motor continuo cuyo **tono** sigue la velocidad real del tanque (`pl.speed`) en cada frame.
- Acelerar: el tono sube (realizando un "rev" de 8..16 notas).
- Al soltar la tecla: el motor baja de tono y se enlentece de forma **física-acoplada**, siguiendo el decaimiento por fricción existente (`SPEED_FRICTION=0.9`); se detiene en silencio por debajo de un umbral bajo.
- El bucle SFX se reinicia a un `offset` de nota según velocidad (PICO-8 no puede variar el tono de un sonido en reproducción; `pico8.api.sfx.claim.1`). El hum suena de forma continua por el propio bucle y solo se re-arranca cuando cambia el `offset` (cruce de escalón de velocidad); no hay golpeo periódico.
- La calidad de motor pasará de 1 canal a seguir usando 1 canal (`CH_MOTOR=3`), sin colisionar con efectos existentes.
- Corregir de paso: cortar el motor al pasar a `GS_GAMEOVER` (hoy el bucle sigue sonando porque `pl_update` deja de ejecutarse).

## Capabilities

### New Capabilities
- `player-motor-sound`: sonido de motor del jugador continuo y acoplado a la velocidad real — tono derivado de `pl.speed`, arranque/parada por umbral bajo, reinicio del bucle con `offset` dinámico.

### Modified Capabilities
- Ninguna: `player-movement` no contiene ningún requisito de sonido en su spec (el umbral `0.15` es un detalle de implementación en `src/player.lua`); el cálculo de `pl.speed` no cambia y todos los requisitos de sonido viven en `player-motor-sound`.

## Impact

- **Código**: `src/player.lua` (bloque motor, líneas 60-68), `src/const.lua` (constantes del motor), `src/states.lua` (corte de motor en game over). Sin cambios en `pl.speed` ni en colisiones.
- **Audio**: 1 slot SFX (`3`) rediseñado a bucle de 32 notas (hum continuo); 1 canal de los 4 disponibles (`pico8.constraint.audio-channels`, `pico8.constraint.sound-instruments`). Sin música afectada.
- **Presupuestos**: tokens +~15; CPU/frame despreciable (1-2 llamadas `sfx` por frame como máximo); sin sprites, mapa ni cartdata nuevos.
- **Dependencias**: comportamiento determinista de `sfx(n, ch, offset, length)` para reinicio a offset y parada con `n=-1` (`pico8.api.sfx.claim.1`, `pico8.api.sfx.claim.6`).