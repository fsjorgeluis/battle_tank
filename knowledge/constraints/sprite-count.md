---
schema_version: "1.0"
id: "pico8.constraint.sprite-count"
kind: "constraint"
title: "Capacidad de sprites del banco dedicado"
summary: "PICO-8 tiene una capacidad fija de 128 sprites de 8x8 en el banco dedicado de la hoja de sprites."
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
    target: "pico8.constraint.sprite-shared-count"
  - type: "related"
    target: "pico8.constraint.sprite-size"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.constraint.sprite-count.claim.1"
    statement: "PICO-8 tiene una capacidad fija de 128 sprites de 8x8."
    evidence:
      locator: "6.2 Graphics"
      quote_or_paraphrase: "PICO-8 has a fixed capacity of 128 8x8 sprites, plus another 128 that overlap with the bottom half of the map data"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.sprite-count.claim.2"
    statement: "Las especificaciones describen un único banco de 128 sprites de 8x8, más 128 compartidos."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Sprites: Single bank of 128 8x8 sprites (+128 shared)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "sprite sheet"
  property: "dedicated-sprite-count"
  operator: "fixed"
  value: "128"
  unit: "sprites"
  scope: "sprite sheet bank"
  enforcement: "sprite editor capacity"
---

## Consecuencia práctica

El banco dedicado contiene los sprites 0..127; la API SPR acepta índices 0..255, donde los 128 superiores pertenecen al banco compartido con el mapa. El diseño de assets debe repartir los sprites entre ambos bancos según su necesidad de coexistir con los datos de mapa.

## Ambigüedades

Ninguna documentada.
