## Context

El motor actual es un blip de flanco en `src/player.lua:60-68`: `sfx(SFX_MOTOR, CH_MOTOR)` se dispara una vez al cruzar `pl.speed >= 0.15` y se corta en seco (`sfx(-1, CH_MOTOR)`) al volver a bajar. No transmite aceleracion ni desaceleracion. Se usa el slot SFX 3 en el canal 3 (`src/const.lua:82-83`).

Restricciones de plataforma relevantes (aplican al diseno):
- Bus de 4 canales fijos y 64 definiciones de sonido (pico8.constraint.audio-channels, pico8.constraint.sound-instruments). El slot 3 y el canal 3 quedan reservados al motor, como hoy.
- `sfx(n, ch, offset, length)` reproduce el SFX desde una nota de inicio `offset` (0..31 en notas); con `n=-1` detiene el canal (pico8.api.sfx.claim.1, pico8.api.sfx.claim.6). No existe cambio de tono en reproduccion: el tono queda fijado por la nota donde se reinicia el bucle.
- Bucle de juego dirigido por plataforma a 30fps (15fps si `_draw` no cabe): el motor debe reiniciarse correctamente a cualquier fps (pico8.concept.game-loop).

Fisica jugador ya existente: `SPEED_ACCEL=0.15`, `SPEED_FRICTION=0.9`, `SPEED_MAX=1.5`, `pl.speed` integrado con clamp en `src/player.lua:38-45`. Soltar la tecla decae `1.5 -> ~0.03` en ~40 frames (~1.3s): ese decaimiento es el "coast-down" disponible sin codigo extra.

## Goals / Non-Goals

**Goals:**
- Motor continuo cuyo tono deriva de `pl.speed` en cada frame.
- Desaceleracion fisica-acoplada: al soltar la tecla, el sonido baja de tono junto con `pl.speed` real, hasta un umbral bajo de silencio.
- Coste contenido: 1 slot SFX (3) y 1 canal (3) como hoy; sin tocar balas, enemigos ni colisiones.
- Silencio garantizado en reinicio de partida y en transicion a game over (hoy el bucle sigue sonando en game over porque `pl_update` deja de ejecutarse).

**Non-Goals:**
- No modificar la fisica de movimiento (`pl.speed`, friccion, clamp, colisiones).
- No usar un segundo canal ni slot extra: todo el motor queda en 1 slot (3) y 1 canal (3); los canales 0/1/2 quedan libres para boom/shot/hit.
- No generar musica ni cambiar SFX de disparo, impacto o explosion.
- No inventar tono "en vivo": el tono siempre se materializa reiniciando el bucle a un `offset` (limitacion PICO-8).

## Decisions

### D1: Un unico bucle de 32 notas (hum continuo) con reinicio por `offset`

El slot 3 se redisenia como un bucle grave continuo (hum) sin golpe periodico insertado en el patron. El tono se elige reiniciando el bucle en un `offset` 0..31. El hum suena de forma continua por el propio loop del SFX; solo se re-arranca al cambiar el `offset` (ver D4).

Alternativas consideradas:
- **Escalera de slots** (un SFX por peldaño de tono): mas slots (4-5), misma limitacion de pasos, mas trabajo de edicion. Descartada.
- **Patron con golpe periodico insertado (thud)**: produce el putt-putt, pero el jugador quiere solo hum y exigiria ademas reinicio por tick (ver D4). Descartada.
- **Canal doble (hum en 3, thud en 2)**: innecesario sin thud y colisionaria con `CH_HIT` en combate. Descartada.

### D2: Fisica-acoplada: `pl.speed` es el envolvente

Todo el envelope (arranque, tono, ritmo, parada) se lee de `pl.speed` cada frame. No hay timers ni decrescendos guionados. Soltar la tecla decae por `SPEED_FRICTION=0.9`, por lo que el "spool-down" hereda automaticamente la curva de friccion (~1.3s). La fuente de verdad es una: el mismo numero que mueve el tanque.

Alternativa descartada: decrescendo guionado (secuencia de notas descendentes con volumen decreciente pre-grabada) — se desacopla del movimiento visible y requiere editar mas notas.

### D3: Mapeo tono = f(speed) con cuantizacion

```
norm   = clamp(speed / SPEED_MAX, 0, 1)
offset = MOTOR_OFF_MIN + flr(norm * MOTOR_SWEEP / MOTOR_STEP) * MOTOR_STEP
```
- Barrido de 12 notas (`MOTOR_SWEEP`) dentro del rango aceptado (8..16). Mas ancho suena a sirena; mas estrecho no se percibe.
- Cuantizacion a pasos de 3 notas (`MOTOR_STEP`) para evitar re-arranques por frame que provoquen crepitidos: el tono cambia por escalones audibles, no nota a nota.

### D4: Re-arranque solo al cambiar el tono (sin tick)

El bucle del hum suena continuo por si mismo. El unico re-arranque ocurre cuando la velocidad cruza un escalon de cuantizacion (el `offset` cambia). No hay retrigger por `tick`: reiniciar a intervalos fijos produciria el golpeteo (thud) que se quiere eliminar. Por ello las constantes `MOTOR_TICK_MIN`/`MOTOR_TICK_MAX` dejan de ser necesarias y se retiran del plan (y del codigo via /opsx-apply).

Se guarda `last_offset` para no re-arrancar el canal sin necesidad cuando nada cambio; el re-arranque es deterministico y funcional a 15 y 30fps porque depende del valor de `pl.speed`, no de tiempo.

Detalle de implementacion: durante la aceleracion, cada cruce de escalon re-arranca el bucle subiendo (acelerando) o bajando (frenando) el tono. En crucero el `offset` es estable y no hay re-arranques.

### D5: Umbral de parada bajo

El motor arranca cuando `pl.speed > ENGINE_FLOOR` (0.03) y se corta (`sfx(-1, CH_MOTOR)`, pico8.api.sfx.claim.6) por debajo. Reemplaza el viejo umbral de flanco `>= 0.15`. Se evita que un tanque "a ralentí" ruja fuerte y se garantiza silencio total en reposo.

### D6: Corte en game over

Al pasar a `GS_GAMEOVER`, `st_update_play` deja de llamar a `pl_update` y el motor seguiria sonando. Se anade `sfx(-1, CH_MOTOR)` en la transicion a game over (y ya existe en `st_reset`). Sin esto, el bucle continuo nuevo haria mas visible el fallo actual.

## Risks / Trade-offs

- **Wrap-dip / click al re-arrancar** (el reinicio a media rampa "cae" a la nota inicial del patron) -> como no hay golpe que lo absorba, cada cambio de `offset` debe leerse como un cambio de tono limpio; si hace click, se estrecha el barrido o se ensancha el patron grave.
- **Escalones de tono audibles / crepitidos al re-arrancar** -> cuantizacion `MOTOR_STEP=3` y patron en base a ruido/grave que enmascara clicks; el re-arranque se limita a cambios de offset o tick.
- **Barrido demasiado ancho = sirena** -> cap de 8..16 notas; se parte de 12 y se afina por oido en el editor SFX de PICO-8.
- **Edicion del hex del SFX (32 notas) propensa a error** -> los datos del patron se generan con un script de un solo uso reproducido en tareas; se verifica escuchando en PICO-8.
- **Corte brusco bajo el umbral** -> el umbral (0.03) esta al final del decaimiento, donde el volumen percibido ya es minimo; aceptable.

## Open Questions

- Datos exactos del patron de notas (notas concretas del hum, velocidad del SFX, flags de loop): se resuelven por oido en PICO-8 durante la implementacion; el contrato (offset 0..31, barrido 12 notas) queda fijado por las constantes del juego.