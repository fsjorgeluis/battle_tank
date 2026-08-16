---
schema_version: "1.0"
id: "pico8.constraint.map-cell-width"
kind: "constraint"
title: "Anchura de celda del mapa"
summary: "Cada celda del mapa almacena un valor de 8 bits (un byte por tile)."
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
    target: "pico8.api.mget"
  - type: "related"
    target: "pico8.api.mset"
claims:
  - id: "pico8.constraint.map-cell-width.claim.1"
    statement: "El mapa de PICO-8 es una cuadrícula de 128x32 valores de 8 bits."
    evidence:
      locator: "6.6 Map"
      quote_or_paraphrase: "The PICO-8 map is a 128x32 grid of 8-bit values"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.map-cell-width.claim.2"
    statement: "El formato del mapa es un byte por tile, donde cada byte normalmente codifica un índice de sprite."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Map format is one byte per tile, where each byte normally encodes a sprite index."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "map cell"
  property: "width"
  operator: "fixed"
  value: "8"
  unit: "bits"
  scope: "map grid cell"
  enforcement: "map storage format"
---

## Consecuencia práctica

Cada celda almacena un valor 0..255, suficiente para los 256 índices de sprite (0..255) o para datos arbitrarios de un byte. `mget`/`mset` exponen ese valor, y la zona MAP de la RAM base (0x2000 por defecto) lo contiene como un byte por tile.

## Ambigüedades

Ninguna documentada.
