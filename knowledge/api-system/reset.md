---
schema_version: "1.0"
id: "pico8.api.reset"
kind: "api"
title: "RESET"
summary: "Restaura los valores por defecto de la RAM de estado 0x5f00..0x5f7f (paleta, cámara, recorte y patrón de relleno)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "RESET"
relationships:
  - type: "related"
    target: "pico8.api.pal"
  - type: "related"
    target: "pico8.api.camera"
  - type: "related"
    target: "pico8.api.clip"
  - type: "related"
    target: "pico8.api.fillp"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.api.reset.claim.1"
    statement: "RESET() restablece los valores de RAM 0x5f00..0x5f7f a sus valores por defecto."
    evidence:
      locator: "6.1 System > RESET"
      quote_or_paraphrase: "Reset the values in RAM from 0x5f00..0x5f7f to their default values."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reset.claim.2"
    statement: "Lo restablecido incluye la paleta, la posición de cámara, el recorte y el patrón de relleno."
    evidence:
      locator: "6.1 System > RESET"
      quote_or_paraphrase: "This includes the palette, camera position, clipping and fill pattern."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reset.claim.3"
    statement: "RESET() puede llamarse desde un programa en ejecución, y el estado de dibujo se restablece también al ejecutar un programa."
    evidence:
      locator: "6.2 Graphics"
      quote_or_paraphrase: "The draw state is reset each time a program is run, or by calling RESET()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reset.claim.4"
    statement: "El manual recomienda RESET si el estado de dibujo impide ver el texto en el prompt."
    evidence:
      locator: "6.1 System > RESET"
      quote_or_paraphrase: "If you get lost at the command prompt because the draw state makes viewing text impossible, try typing RESET!"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
reset()
```

## Semántica

Restaura el estado de dibujo a sus valores por defecto escribiendo los valores de la RAM de estado. No descarga el programa ni borra memoria de código.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- Cubre paleta, cámara, rectángulo de recorte y patrón de relleno.
- El mismo restablecimiento ocurre automáticamente al ejecutar un programa.

## Ejemplos relacionados

`RESET()` desde la consola recupera un prompt legible tras alterar el estado de dibujo.

## Ambigüedades

Ninguna documentada.
