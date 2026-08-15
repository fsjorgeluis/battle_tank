---
schema_version: "1.0"
id: "pico8.api.ovalfill"
kind: "api"
title: "OVALFILL"
summary: "Dibuja una elipse rellena simétrica en x e y dentro del rectángulo delimitador dado."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "OVALFILL"
relationships:
  - type: "related"
    target: "pico8.api.oval"
  - type: "related"
    target: "pico8.api.circfill"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.ovalfill.claim.1"
    statement: "OVALFILL(x0, y0, x1, y1, [col]) dibuja un óvalo relleno, simétrico en x e y."
    evidence:
      locator: "6.2 Graphics > OVALFILL"
      quote_or_paraphrase: "Draw an oval that is symmetrical in x and y (an ellipse), with the given bounding rectangle."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ovalfill.claim.2"
    statement: "El patrón de relleno de PICO-8 es observado por OVALFILL."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "The PICO-8 fill pattern is a 4x4 2-colour tiled pattern observed by: CIRC() CIRCFILL() RECT() RECTFILL() OVAL() OVALFILL() PSET() LINE()"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
ovalfill(x0, y0, x1, y1, [col])
```

## Semántica

Dibuja una elipse rellena inscrita en el rectángulo definido por (x0, y0) y (x1, y1), respetando el patrón de relleno activo.

## Parámetros y retorno

- `x0`, `y0`, `x1`, `y1`: rectángulo delimitador.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

El manual no documenta el efecto de un rectángulo degenerado.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `ovalfill`.

## Ambigüedades

Ninguna documentada.
