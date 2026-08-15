---
schema_version: "1.0"
id: "pico8.api.circ"
kind: "api"
title: "CIRC"
summary: "Dibuja un círculo con centro (x, y) y radio r; con radio negativo no se dibuja."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CIRC"
relationships:
  - type: "related"
    target: "pico8.api.circfill"
  - type: "related"
    target: "pico8.api.oval"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.circ.claim.1"
    statement: "CIRC(x, y, r, [col]) dibuja un círculo en x, y con radio r."
    evidence:
      locator: "6.2 Graphics > CIRC"
      quote_or_paraphrase: "Draw a circle or filled circle at x,y with radius r"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.circ.claim.2"
    statement: "Si r es negativo, el círculo no se dibuja."
    evidence:
      locator: "6.2 Graphics > CIRC"
      quote_or_paraphrase: "If r is negative, the circle is not drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.circ.claim.3"
    statement: "Cuando los bits 0x1800.0000 están fijados en COL y 0x5F34 & 2 == 2, el círculo se dibuja invertido."
    evidence:
      locator: "6.2 Graphics > CIRC"
      quote_or_paraphrase: "When bits 0x1800.0000 are set in COL, and 0x5F34 & 2 == 2, the circle is drawn inverted."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
circ(x, y, r, [col])
```

## Semántica

Dibuja el contorno de un círculo con centro en (x, y) y radio r.

## Parámetros y retorno

- `x`, `y`: centro del círculo.
- `r`: radio en píxeles.
- `col` (opcional): índice de color; los bits altos pueden codificar patrón de relleno o inversión.
- Retorno: no especificado por la fuente.

## Efectos y límites

Con radio negativo no se dibuja. La inversión requiere fijar bits 0x1800.0000 en COL y el modo de inversión en memoria (0x5F34).

## Ejemplos relacionados

El manual usa `CIRCFILL(80,80,120,100,12)` como comando de ejemplo en Hello World; no muestra un ejemplo directo de `circ`.

## Ambigüedades

Ninguna documentada.
