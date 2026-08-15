---
schema_version: "1.0"
id: "pico8.api.btnp"
kind: "api"
title: "BTNP"
summary: "btnp() devuelve true cuando un botón se pulsa en el borde y repite tras 15 frames, cada 4 frames (a 30fps)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.4 Input"
    anchor: "BTNP"
relationships:
  - type: "related"
    target: "pico8.api.btn"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.api.btnp.claim.1"
    statement: "btnp(b, [pl]) devuelve true cuando un botón está pulsado y no lo estaba en el frame anterior."
    evidence:
      locator: "6.4 Input > BTNP"
      quote_or_paraphrase: "returns true when a button is down AND it was not down the last frame"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btnp.claim.2"
    statement: "btnp repite después de 15 frames, devolviendo true cada 4 frames a partir de entonces (a 30fps; el doble a 60fps)."
    evidence:
      locator: "6.4 Input > BTNP"
      quote_or_paraphrase: "It also repeats after 15 frames, returning true every 4 frames after that (at 30fps -- double that at 60fps)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btnp.claim.3"
    statement: "El estado que lee btnp se resetea al inicio de cada llamada a _update o _update60; conviene usarlo desde esas funciones."
    evidence:
      locator: "6.4 Input > BTNP"
      quote_or_paraphrase: "The state that BTNP reads is reset at the start of each call to _UPDATE or _UPDATE60, so it is preferable to use BTNP from inside one of those functions"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btnp.claim.4"
    statement: "Los retardos personalizados se configuran con poke(0x5f5c, delay) para el retardo inicial (255 significa no repetir nunca) y poke(0x5f5d, delay) para el retardo de repetición."
    evidence:
      locator: "6.4 Input > BTNP"
      quote_or_paraphrase: "POKE(0X5F5C, DELAY) -- SET THE INITIAL DELAY BEFORE REPEATING. 255 MEANS NEVER REPEAT. POKE(0X5F5D, DELAY) -- SET THE REPEATING DELAY."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btnp.claim.5"
    statement: "El valor 0 en cualquiera de los dos retardos restaura el comportamiento por defecto (retardos 15 y 4)."
    evidence:
      locator: "6.4 Input > BTNP"
      quote_or_paraphrase: "In both cases, 0 can be used for the default behaviour (delays 15 and 4)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
btnp(b [, pl])
```

## Semántica

"Button Pressed": detecta el borde de pulsación de `b` para el jugador `pl`. A diferencia de `btn`, no devuelve true mientras el botón se mantiene pulsado: sólo en el borde y luego con repetición periódica.

## Parámetros y retorno

- `b`: 0..5 (mismo mapeo que `btn`).
- `pl` (opcional): índice de jugador, por defecto 0.
- Retorno: booleano.

## Efectos y límites

- Repetición: tras 15 frames de mantener pulsado, devuelve true cada 4 frames (a 30fps; el doble de frames a 60fps).
- El estado leído se resetea al inicio de cada `_update`/`_update60`.
- Los retardos de repetición se ajustan vía `poke(0x5f5c)` y `poke(0x5f5d)`; `255` en el inicial desactiva la repetición.

## Ejemplos relacionados

El programa de ejemplo del ciclo de juego de la sección 5 usa `btnp(5)` para cambiar el color de un círculo al pulsar el botón X.

## Ambigüedades

Ninguna documentada.
