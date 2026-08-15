---
schema_version: "1.0"
id: "pico8.api.oval"
kind: "api"
title: "OVAL"
summary: "Dibuja una elipse simétrica en x e y dentro del rectángulo delimitador dado."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "OVAL"
relationships:
  - type: "related"
    target: "pico8.api.ovalfill"
  - type: "related"
    target: "pico8.api.circ"
claims:
  - id: "pico8.api.oval.claim.1"
    statement: "OVAL(x0, y0, x1, y1, [col]) dibuja un óvalo simétrico en x e y (una elipse), con el rectángulo delimitador dado."
    evidence:
      locator: "6.2 Graphics > OVAL"
      quote_or_paraphrase: "Draw an oval that is symmetrical in x and y (an ellipse), with the given bounding rectangle."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
oval(x0, y0, x1, y1, [col])
```

## Semántica

Dibuja el contorno de una elipse inscrita en el rectángulo definido por (x0, y0) y (x1, y1).

## Parámetros y retorno

- `x0`, `y0`, `x1`, `y1`: rectángulo delimitador.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

El manual no documenta el efecto de un rectángulo degenerado (cero o negativo).

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `oval`.

## Ambigüedades

Ninguna documentada.
