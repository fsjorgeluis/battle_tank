---
schema_version: "1.0"
id: "pico8.api.rectfill"
kind: "api"
title: "RECTFILL"
summary: "Dibuja un rectángulo relleno con esquinas en (x0, y0) y (x1, y1)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "RECTFILL"
relationships:
  - type: "related"
    target: "pico8.api.rect"
  - type: "related"
    target: "pico8.api.rrectfill"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.rectfill.claim.1"
    statement: "RECTFILL(x0, y0, x1, y1, [col]) dibuja un rectángulo relleno con esquinas en (x0, y0) y (x1, y1)."
    evidence:
      locator: "6.2 Graphics > RECTFILL"
      quote_or_paraphrase: "Draw a rectangle or filled rectangle with corners at (X0, Y0), (X1, Y1)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rectfill.claim.2"
    statement: "El patrón de relleno de PICO-8 es observado por RECTFILL."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "The PICO-8 fill pattern is a 4x4 2-colour tiled pattern observed by: CIRC() CIRCFILL() RECT() RECTFILL() OVAL() OVALFILL() PSET() LINE()"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rectfill(x0, y0, x1, y1, [col])
```

## Semántica

Dibuja un rectángulo relleno cuyas esquinas opuestas son (x0, y0) y (x1, y1), respetando el patrón de relleno activo.

## Parámetros y retorno

- `x0`, `y0`, `x1`, `y1`: esquinas del rectángulo.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

El manual no documenta el comportamiento con esquinas invertidas.

## Ejemplos relacionados

`RECTFILL(80,80,120,100,12)` aparece como comando de ejemplo en la sección Hello World.

## Ambigüedades

Ninguna documentada.
