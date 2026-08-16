---
schema_version: "1.0"
id: "pico8.api.flip"
kind: "api"
title: "FLIP"
summary: "Cambia el back buffer a pantalla y espera el siguiente frame; sólo hace falta en bucles principales manuales."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "FLIP"
relationships:
  - type: "related"
    target: "pico8.concept.game-loop"
  - type: "related"
    target: "pico8.api.extcmd"
claims:
  - id: "pico8.api.flip.claim.1"
    statement: "FLIP() cambia el back buffer a pantalla y espera al siguiente frame."
    evidence:
      locator: "6.1 System > FLIP"
      quote_or_paraphrase: "Flip the back buffer to screen and wait for next frame."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flip.claim.2"
    statement: "FLIP no es necesaria cuando hay definida una callback _DRAW() o _UPDATE(), porque el flip se realiza automáticamente."
    evidence:
      locator: "6.1 System > FLIP"
      quote_or_paraphrase: "This call is not needed when there is a _DRAW() or _UPDATE() callback defined, as the flip is performed automatically."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flip.claim.3"
    statement: "Al usar un bucle principal manual, normalmente se necesita una llamada a FLIP."
    evidence:
      locator: "6.1 System > FLIP"
      quote_or_paraphrase: "But when using a custom main loop, a call to FLIP is normally needed"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flip.claim.4"
    statement: "Si el programa no llama a FLIP antes de que termine el frame y no hay una _DRAW en curso, el contenido actual del back buffer se copia a pantalla."
    evidence:
      locator: "6.1 System > FLIP"
      quote_or_paraphrase: "If your program does not call FLIP before a frame is up, and a _DRAW() callback is not in progress, the current contents of the back buffer are copied to screen."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flip.claim.5"
    statement: "EXTCMD(\"REC_FRAMES\") graba exactamente un frame por cada llamada a FLIP(), independientemente de la velocidad de ejecución."
    evidence:
      locator: "6.1 System > Recording GIFs"
      quote_or_paraphrase: "To record exactly one frame each time FLIP() is called, regardless of the runtime framerate or how long it took to generate the frame, use: EXTCMD(\"REC_FRAMES\")"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
flip()
```

## Semántica

Presenta el back buffer en pantalla y espera el siguiente frame. Sólo es necesaria cuando se usa un bucle principal manual en lugar de las callbacks `_update`/`_draw`.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- Con `_draw()`/`_update()` definidas, el flip es automático y llamar a `FLIP()` es innecesario.
- Al terminar el frame sin `FLIP()` y sin `_draw` en curso, el back buffer se copia igualmente a pantalla.

## Ejemplos relacionados

```lua
::_:::
cls()
-- dibujo
flip()
goto _
```

## Ambigüedades

Ninguna documentada.
