---
schema_version: "1.0"
id: "pico8.api.pset"
kind: "api"
title: "PSET"
summary: "Establece el píxel en (x, y) al índice de color col (0..15); sin col usa el color de dibujo actual."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "PSET"
relationships:
  - type: "related"
    target: "pico8.api.pget"
  - type: "related"
    target: "pico8.api.color"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.pset.claim.1"
    statement: "PSET(x, y, [col]) establece el píxel en x, y al índice de color col (0..15)."
    evidence:
      locator: "6.2 Graphics > PSET"
      quote_or_paraphrase: "Sets the pixel at x, y to colour index COL (0..15)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pset.claim.2"
    statement: "Cuando col no se especifica, se usa el color de dibujo actual."
    evidence:
      locator: "6.2 Graphics > PSET"
      quote_or_paraphrase: "When COL is not specified, the current draw colour is used."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pset.claim.3"
    statement: "El manual muestra un bucle que dibuja un degradado con PSET(X, Y, X*Y/8)."
    evidence:
      locator: "6.2 Graphics > PSET"
      quote_or_paraphrase: "FOR Y=0,127 DO FOR X=0,127 DO PSET(X, Y, X*Y/8) END END"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
pset(x, y, [col])
```

## Semántica

Escribe un píxel en la pantalla con el índice de color dado. Sin color explícito, usa el color de dibujo actual.

## Parámetros y retorno

- `x`, `y`: coordenadas del píxel en píxeles.
- `col` (opcional): índice de color 0..15.
- Retorno: no especificado por la fuente.

## Efectos y límites

Acepta también un patrón de relleno en los bits altos del parámetro de color (ver `pico8.api.fillp`).

## Ejemplos relacionados

El manual muestra el degradado de ejemplo: `PSET(X, Y, X*Y/8)` para toda la pantalla.

## Ambigüedades

Ninguna documentada.
