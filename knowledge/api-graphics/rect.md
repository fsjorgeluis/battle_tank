---
schema_version: "1.0"
id: "pico8.api.rect"
kind: "api"
title: "RECT"
summary: "Dibuja un rectángulo con esquinas en (x0, y0) y (x1, y1)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "RECT"
relationships:
  - type: "related"
    target: "pico8.api.rectfill"
  - type: "related"
    target: "pico8.api.rrect"
  - type: "related"
    target: "pico8.api.line"
claims:
  - id: "pico8.api.rect.claim.1"
    statement: "RECT(x0, y0, x1, y1, [col]) dibuja un rectángulo con esquinas en (x0, y0) y (x1, y1)."
    evidence:
      locator: "6.2 Graphics > RECT"
      quote_or_paraphrase: "Draw a rectangle or filled rectangle with corners at (X0, Y0), (X1, Y1)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rect(x0, y0, x1, y1, [col])
```

## Semántica

Dibuja el contorno de un rectángulo cuyas esquinas opuestas son (x0, y0) y (x1, y1).

## Parámetros y retorno

- `x0`, `y0`, `x1`, `y1`: esquinas del rectángulo.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

El manual no documenta el comportamiento con esquinas invertidas.

## Ejemplos relacionados

El manual usa `RECTFILL(80,80,120,100,12)` como ejemplo en Hello World; no muestra un ejemplo directo de `rect`.

## Ambigüedades

Ninguna documentada.
