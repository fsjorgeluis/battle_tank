---
schema_version: "1.0"
id: "pico8.constraint.sprite-sheet-size"
kind: "constraint"
title: "Dimensiones de la hoja de sprites"
summary: "La hoja de sprites completa se comporta como una imagen de 128x128 píxeles."
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
    target: "pico8.constraint.sprite-size"
  - type: "related"
    target: "pico8.constraint.display-resolution"
claims:
  - id: "pico8.constraint.sprite-sheet-size.claim.1"
    statement: "La hoja de sprites, formada por los 256 sprites, se puede pensar como una imagen de 128x128 píxeles."
    evidence:
      locator: "6.2 Graphics"
      quote_or_paraphrase: "These 256 sprites are collectively called the sprite sheet, and can be thought of as a 128x128 pixel image."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "sprite sheet"
  property: "image-dimensions"
  operator: "fixed"
  value: "128x128"
  unit: "pixels"
  scope: "sprite sheet image"
  enforcement: "disposición de memoria de la hoja de sprites"
---

## Consecuencia práctica

Las APIs SGET/SSET acceden a píxeles de la hoja de sprites con coordenadas 0..127 en ambos ejes. SSPR recorta rectángulos de esta imagen para estirarlos a la pantalla.

## Ambigüedades

Ninguna documentada.
