---
schema_version: "1.0"
id: "pico8.constraint.display-resolution"
kind: "constraint"
title: "Resolución de pantalla"
summary: "La pantalla de PICO-8 tiene una resolución fija de 128x128 píxeles."
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
    target: "pico8.constraint.palette-color-count"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.constraint.display-resolution.claim.1"
    statement: "La pantalla de PICO-8 tiene una resolución de 128x128 píxeles."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Display: 128x128, fixed 16 colour palette"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "display"
  property: "resolution"
  operator: "fixed"
  value: "128x128"
  unit: "pixels"
  scope: "display screen"
  enforcement: "hardware fixed (pantalla de la consola virtual)"
---

## Consecuencia práctica

Todas las operaciones de dibujo trabajan sobre un área visible de 128x128 píxeles. Coordenadas fuera de ese rango se recortan o quedan fuera de pantalla; por ejemplo, PGET y SGET fuera de rango devuelven 0 salvo valor personalizado.

## Ambigüedades

Ninguna documentada.
