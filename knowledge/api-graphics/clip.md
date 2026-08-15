---
schema_version: "1.0"
id: "pico8.api.clip"
kind: "api"
title: "CLIP"
summary: "Establece el rectángulo de recorte en píxeles al que se limitan todas las operaciones de dibujo."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CLIP"
relationships:
  - type: "related"
    target: "pico8.api.cls"
  - type: "related"
    target: "pico8.api.camera"
claims:
  - id: "pico8.api.clip.claim.1"
    statement: "CLIP(x, y, w, h, [clip_previous]) establece el rectángulo de recorte en píxeles; todas las operaciones de dibujo se recortan al rectángulo en x, y con ancho w y alto h."
    evidence:
      locator: "6.2 Graphics > CLIP"
      quote_or_paraphrase: "Sets the clipping rectangle in pixels. All drawing operations will be clipped to the rectangle at x, y with a width and height of w, h."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.clip.claim.2"
    statement: "CLIP() sin parámetros restablece el recorte."
    evidence:
      locator: "6.2 Graphics > CLIP"
      quote_or_paraphrase: "CLIP() to reset."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.clip.claim.3"
    statement: "Cuando clip_previous es verdadero, el nuevo recorte se limita a su vez por el recorte anterior."
    evidence:
      locator: "6.2 Graphics > CLIP"
      quote_or_paraphrase: "When CLIP_PREVIOUS is true, clip the new clipping region by the old one."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
clip(x, y, w, h, [clip_previous])
```

## Semántica

Fija el rectángulo de recorte en píxeles. Toda operación de dibujo posterior queda limitada a esa región hasta que se cambie el recorte o se restablezca.

## Parámetros y retorno

- `x`, `y`: esquina superior izquierda del rectángulo en píxeles.
- `w`, `h`: ancho y alto del rectángulo en píxeles.
- `clip_previous` (opcional, booleano): si es verdadero, el nuevo rectángulo se recorta contra el anterior.
- Retorno: no especificado por la fuente.

## Efectos y límites

El rectángulo de recorte forma parte del estado de dibujo, que se restablece al ejecutar el programa o con `RESET()`. `CLS` también restablece el rectángulo de recorte.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `clip`.

## Ambigüedades

Ninguna documentada.
