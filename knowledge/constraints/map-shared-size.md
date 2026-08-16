---
schema_version: "1.0"
id: "pico8.constraint.map-shared-size"
kind: "constraint"
title: "Tamaño del mapa con memoria compartida"
summary: "El mapa alcanza 128x64 tiles cuando se usa el área de memoria compartida."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
relationships:
  - type: "related"
    target: "pico8.constraint.map-size"
  - type: "related"
    target: "pico8.constraint.sprite-shared-count"
  - type: "related"
    target: "pico8.api.map"
claims:
  - id: "pico8.constraint.map-shared-size.claim.1"
    statement: "El mapa es una cuadrícula de 128x64 cuando se usa la memoria compartida."
    evidence:
      locator: "6.6 Map"
      quote_or_paraphrase: "or 128x64 when using the shared memory"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.map-shared-size.claim.2"
    statement: "El área 0x1000 es GFX2/MAP2 (compartido); las direcciones de mapa 0x30..0x3f se toman como 0x10..0x1f (área de memoria compartida)."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "0X1000 GFX2/MAP2 (SHARED) ... Map addresses 0x30..0x3f are taken to mean 0x10..0x1f (shared memory area)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "map"
  property: "grid-dimensions"
  operator: "fixed"
  value: "128x64"
  unit: "tiles"
  scope: "map using shared memory"
  enforcement: "shared GFX2/MAP2 region"
---

## Consecuencia práctica

Al usar el área compartida (0x1000..0x1fff), el mapa gana 32 filas adicionales y solapa con el banco de sprites compartido con el mapa (`pico8.constraint.sprite-shared-count`). El modo de dibujo de `map` cubre ese espacio compartido cuando corresponde.

## Ambigüedades

Ninguna documentada.
