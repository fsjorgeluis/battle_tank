---
schema_version: "1.0"
id: "pico8.constraint.palette-color-count"
kind: "constraint"
title: "Número de colores de la paleta"
summary: "PICO-8 usa una paleta fija de 16 colores, indexados del 0 al 15."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "Specifications"
relationships:
  - type: "related"
    target: "pico8.constraint.display-resolution"
  - type: "related"
    target: "pico8.api.color"
claims:
  - id: "pico8.constraint.palette-color-count.claim.1"
    statement: "La paleta de colores de PICO-8 es fija y consta de 16 colores."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Display: 128x128, fixed 16 colour palette"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.palette-color-count.claim.2"
    statement: "Los índices de color van de 0 (negro) a 15 (peach), cada uno con un nombre propio."
    evidence:
      locator: "6.2 Graphics > Colour indexes"
      quote_or_paraphrase: "Colour indexes: 0 black ... 15 peach"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "palette"
  property: "color-count"
  operator: "fixed"
  value: "16"
  unit: "colours"
  scope: "display palette"
  enforcement: "hardware fixed; índices 0..15 en las APIs de color"
---

## Consecuencia práctica

El parámetro de color de las funciones de dibujo (PSET, SPR, CIRC, etc.) se expresa como índice 0..15. Los cambios de color en pantalla se logran mediante re-mapeos de paleta (PAL, PALT), no con colores fuera de ese rango.

## Ambigüedades

Ninguna documentada.
