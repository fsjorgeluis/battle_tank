---
schema_version: "1.0"
id: "pico8.constraint.sprite-size"
kind: "constraint"
title: "Tamaño de sprite"
summary: "Cada sprite de la hoja de sprites mide 8x8 píxeles."
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
  - id: "pico8.constraint.sprite-size.claim.1"
    statement: "Cada sprite de la hoja de sprites mide 8x8 píxeles."
    evidence:
      locator: "6.2 Graphics"
      quote_or_paraphrase: "PICO-8 has a fixed capacity of 128 8x8 sprites"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.sprite-size.claim.2"
    statement: "El bloque de especificaciones describe el banco como de sprites de 8x8."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Single bank of 128 8x8 sprites (+128 shared)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "sprite"
  property: "cell-size"
  operator: "fixed"
  value: "8x8"
  unit: "pixels"
  scope: "single sprite"
  enforcement: "grid del editor de sprites"
---

## Consecuencia práctica

La API SPR blitea sprites de 8x8 píxeles; los parámetros opcionales w y h indican cuántos sprites de ancho y alto se copian. Los sprites mayores se componen en tiempo de dibujo, no en el editor.

## Ambigüedades

Ninguna documentada.
