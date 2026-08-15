---
schema_version: "1.0"
id: "pico8.api.rrect"
kind: "api"
title: "RRECT"
summary: "Dibuja un rectángulo con esquinas redondeadas; ancho y alto deben ser mayores que 0."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "RRECT"
relationships:
  - type: "related"
    target: "pico8.api.rrectfill"
  - type: "related"
    target: "pico8.api.rect"
claims:
  - id: "pico8.api.rrect.claim.1"
    statement: "RRECT(x, y, w, h, r, [col]) dibuja un rectángulo redondeado o un rectángulo relleno con esquinas redondeadas."
    evidence:
      locator: "6.2 Graphics > RRECT"
      quote_or_paraphrase: "Draw a rounded rectangle or filled rectangle with rounded corners."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rrect.claim.2"
    statement: "El ancho (w) y la altura (h) están en píxeles y ambos deben ser mayores que 0 para que la forma se dibuje."
    evidence:
      locator: "6.2 Graphics > RRECT"
      quote_or_paraphrase: "The width (W) and height (H) are in pixels, and must both be more than 0 for the shape to be drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rrect.claim.3"
    statement: "El radio (r) por defecto es 0 y es el tamaño del cuarto de círculo en cada esquina; el radio usado se limita al rango 0..min(ancho, alto)/2."
    evidence:
      locator: "6.2 Graphics > RRECT"
      quote_or_paraphrase: "Radius (R) defaults to 0, and is the size of the quarter-circle to be drawn at each corner. The radius used is clamped to fall the range 0 .. min(width,height)/2."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rrect.claim.4"
    statement: "El manual muestra el ejemplo rrectfill(50,80,40,30,2,8) para un rectángulo rojo redondeado de 40x30 píxeles."
    evidence:
      locator: "6.2 Graphics > RRECT"
      quote_or_paraphrase: "Draw a red (colour 8) rounded rectangle 40 pixels wide and 30 pixels talls with 3 pixels missing at each corner (radius 2): rrectfill(50,80,40,30,2,8)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rrect(x, y, w, h, r, [col])
```

## Semántica

Dibuja un rectángulo con esquinas redondeadas. El radio define el tamaño del cuarto de círculo de cada esquina y se limita a la mitad del lado menor.

## Parámetros y retorno

- `x`, `y`: posición de la esquina superior izquierda.
- `w`, `h`: ancho y alto en píxeles; ambos deben ser mayores que 0.
- `r` (opcional, por defecto 0): radio de las esquinas.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

Con w o h iguales a 0 o negativos la forma no se dibuja.

## Ejemplos relacionados

El manual ilustra la variante rellena con `rrectfill(50,80,40,30,2,8)`.

## Ambigüedades

Ninguna documentada.
