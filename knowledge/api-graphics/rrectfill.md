---
schema_version: "1.0"
id: "pico8.api.rrectfill"
kind: "api"
title: "RRECTFILL"
summary: "Dibuja un rectángulo relleno con esquinas redondeadas; ancho y alto deben ser mayores que 0."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "RRECTFILL"
relationships:
  - type: "related"
    target: "pico8.api.rrect"
  - type: "related"
    target: "pico8.api.rectfill"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.rrectfill.claim.1"
    statement: "RRECTFILL(x, y, w, h, r, [col]) dibuja un rectángulo relleno con esquinas redondeadas."
    evidence:
      locator: "6.2 Graphics > RRECTFILL"
      quote_or_paraphrase: "Draw a rounded rectangle or filled rectangle with rounded corners."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rrectfill.claim.2"
    statement: "El ancho (w) y la altura (h) están en píxeles y ambos deben ser mayores que 0 para que la forma se dibuje."
    evidence:
      locator: "6.2 Graphics > RRECTFILL"
      quote_or_paraphrase: "The width (W) and height (H) are in pixels, and must both be more than 0 for the shape to be drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rrectfill.claim.3"
    statement: "Cuando los bits 0x1800.0000 están fijados en COL y (PEEK(0x5F34) & 2) == 2, RRECTFILL se dibuja invertido."
    evidence:
      locator: "6.2 Graphics > RRECTFILL"
      quote_or_paraphrase: "When bits 0x1800.0000 are set in COL, and (PEEK(0x5F34) & 2) == 2, RRECTFILL is drawn inverted."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rrectfill(x, y, w, h, r, [col])
```

## Semántica

Dibuja un rectángulo relleno con esquinas redondeadas, respetando el patrón de relleno activo.

## Parámetros y retorno

- `x`, `y`: posición de la esquina superior izquierda.
- `w`, `h`: ancho y alto en píxeles; ambos deben ser mayores que 0.
- `r` (opcional, por defecto 0): radio de las esquinas.
- `col` (opcional): índice de color; los bits altos pueden codificar inversión.
- Retorno: no especificado por la fuente.

## Efectos y límites

Con w o h iguales a 0 o negativos la forma no se dibuja. La inversión requiere bits 0x1800.0000 en COL y el modo de inversión en memoria.

## Ejemplos relacionados

El manual ilustra la variante rellena: `rrectfill(50,80,40,30,2,8)` dibuja un rectángulo rojo de 40x30 con esquinas de radio 2.

## Ambigüedades

Ninguna documentada.
