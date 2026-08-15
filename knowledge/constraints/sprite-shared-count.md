---
schema_version: "1.0"
id: "pico8.constraint.sprite-shared-count"
kind: "constraint"
title: "Sprites compartidos con el mapa"
summary: "Otros 128 sprites se solapan con la mitad inferior de los datos de mapa ('datos compartidos')."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
relationships:
  - type: "related"
    target: "pico8.constraint.sprite-count"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.constraint.sprite-shared-count.claim.1"
    statement: "Otros 128 sprites se solapan con la mitad inferior de los datos de mapa, los llamados 'datos compartidos'."
    evidence:
      locator: "6.2 Graphics"
      quote_or_paraphrase: "plus another 128 that overlap with the bottom half of the map data ('shared data')"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.sprite-shared-count.claim.2"
    statement: "Las especificaciones expresan estos sprites adicionales como '+128 shared'."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Sprites: Single bank of 128 8x8 sprites (+128 shared)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "sprite sheet"
  property: "shared-sprite-count"
  operator: "fixed"
  value: "128"
  unit: "sprites"
  scope: "shared with map data"
  enforcement: "overlap con la mitad inferior de los datos de mapa"
---

## Consecuencia práctica

Los 128 sprites compartidos comparten memoria con la mitad inferior del tilemap: escribir sprite o mapa en esa región se afectan mutuamente. La hoja de sprites completa (256 sprites) se trata como una imagen de 128x128 píxeles.

## Ambigüedades

Ninguna documentada.
