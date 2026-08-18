## 1. Constantes del motor

- [x] 1.1 Ajustar en `src/const.lua` las constantes semanticas a hum continuo: mantener `ENGINE_FLOOR=0.03`, `MOTOR_SWEEP=12`, `MOTOR_OFF_MIN`, `MOTOR_STEP=3`, `SFX_MOTOR=3` y `CH_MOTOR=3`; retirar `MOTOR_TICK_MIN`/`MOTOR_TICK_MAX` (sin tick, sin thud) (pico8.constraint.audio-channels, pico8.constraint.sound-instruments)

## 2. Diseno del slot SFX 3 (hum continuo)

- [x] 2.1 Rediseniar el slot SFX 3 en el cartucho (`battle_tank.p8`) como bucle de 32 notas de hum grave continuo (sin golpe periodico), con barrido de trabajo de 12 notas reutilizado por offset; verificar edicion con EXPORT/IMPORT (pico8.concept.export-tools)
- [x] 2.2 Confirmar por oido en PICO-8 que el slot reproduce como bucle de hum continuo y que el re-arranque por cambio de `offset` no produce clicks percibidos como fallo (design D1)

## 3. Motor continuo en `pl_update`

- [x] 3.1 Reemplazar el bloque de motor actual (src/player.lua:55-77) por la version de hum continuo basada en `pl.speed`: calcular `norm` y `offset` cuantizado cada frame; arrancar en bucle con `sfx(SFX_MOTOR,CH_MOTOR,offset)` al superar `ENGINE_FLOOR`; retirar la logica de `tick` (pico8.api.sfx.claim.1)
- [x] 3.2 Re-arrancar el bucle solo cuando cambie el `offset` (cruce de escalon de velocidad), guardando el ultimo offset para evitar re-arranques espurios a velocidad constante; sin retrigger por `tick`
- [x] 3.3 Detener el canal (`sfx(-1,CH_MOTOR)`) cuando `pl.speed < ENGINE_FLOOR` (pico8.api.sfx.claim.6)

## 4. Silencio en reinicio y game over

- [x] 4.1 Verificar que `st_reset()` silencia el canal `CH_MOTOR` al iniciar partida (ya existe; mantener)
- [x] 4.2 Anadir el corte de `CH_MOTOR` en la transicion a `GS_GAMEOVER` en `src/states.lua`, de modo que el motor no siga sonando al perder

## 5. Verificacion en PICO-8

- [x] 5.1 Ejecutar el cartucho (`pico8 battle_tank.p8`) y comprobar aceptacion normal: arranque por umbral, subida de tono acelerando, velocidad constante estable (sin golpeteo), spool-down fisico-acoplado al soltar, silencio en reposo
- [x] 5.2 Comprobar aceptacion de bordes/estados: reinicio de partida sin sonido heredado, corte de motor en game over, re-arranque limpio en nueva partida
- [x] 5.3 Comprobar regresion: disparos (boom/shot/hit, canales 0/1/2) siguen sonando y el motor no les roba el canal
- [x] 5.4 Verificar presupuestos: tokens con `info` (delta `~+15`) y CPU con stat(1)/CTRL-P (holgado, 1-2 llamadas sfx por frame) (pico8.constraint.cpu-throughput, pico8.constraint.token-limit)