---
schema_version: "1.0"
id: "pico8.api.circfill"
kind: "api"
title: "CIRCFILL"
summary: "Dibuja un círculo relleno con centro (x, y) y radio r; con radio negativo no se dibuja."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CIRCFILL"
relationships:
  - type: "related"
    target: "pico8.api.circ"
  - type: "related"
    target: "pico8.api.ovalfill"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.circfill.claim.1"
    statement: "CIRCFILL(x, y, r, [col]) dibuja un círculo relleno en x, y con radio r."
    evidence:
      locator: "6.2 Graphics > CIRCFILL"
      quote_or_paraphrase: "Draw a circle or filled circle at x,y with radius r"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.circfill.claim.2"
    statement: "Si r es negativo, el círculo no se dibuja."
    evidence:
      locator: "6.2 Graphics > CIRCFILL"
      quote_or_paraphrase: "If r is negative, the circle is not drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.circfill.claim.3"
    statement: "Cuando los bits 0x1800.0000 están fijados en COL y 0x5F34 & 2 == 2, el círculo se dibuja invertido."
    evidence:
      locator: "6.2 Graphics > CIRCFILL"
      quote_or_paraphrase: "When bits 0x1800.0000 are set in COL, and 0x5F34 & 2 == 2, the circle is drawn inverted."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.circfill.claim.4"
    statement: "El patrón de relleno de PICO-8 es observado por CIRCFILL."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "The PICO-8 fill pattern is a 4x4 2-colour tiled pattern observed by: CIRC() CIRCFILL() RECT() RECTFILL() OVAL() OVALFILL() PSET() LINE()"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
circfill(x, y, r, [col])
```

## Semántica

Dibuja un círculo relleno con centro en (x, y) y radio r, respetando el patrón de relleno activo.

## Parámetros y retorno

- `x`, `y`: centro del círculo.
- `r`: radio en píxeles.
- `col` (opcional): índice de color; los bits altos pueden codificar patrón de relleno o inversión.
- Retorno: no especificado por la fuente.

## Efectos y límites

Con radio negativo no se dibuja. El manual muestra la combinación con el patrón de relleno: `FILLP(0b0011010101101000)` y `CIRCFILL(64,64,20, 0x4E)` para un círculo marrón y rosa.

## Ejemplos relacionados

`CIRCFILL(80,80,120,100,12)` y `CIRCFILL(70,90,20,14)` aparecen como comandos de ejemplo en la sección Hello World.

## Ambigüedades

Ninguna documentada.
