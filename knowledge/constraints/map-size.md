---
schema_version: "1.0"
id: "pico8.constraint.map-size"
kind: "constraint"
title: "Tamaño por defecto de la cuadrícula del mapa"
summary: "El mapa de PICO-8 es una cuadrícula fija de 128x32 valores de 8 bits por defecto."
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
    target: "pico8.constraint.map-shared-size"
  - type: "related"
    target: "pico8.constraint.map-cell-width"
  - type: "related"
    target: "pico8.api.map"
  - type: "related"
    target: "pico8.api.mget"
claims:
  - id: "pico8.constraint.map-size.claim.1"
    statement: "El mapa de PICO-8 es una cuadrícula de 128x32 valores de 8 bits, o de 128x64 cuando se usa la memoria compartida."
    evidence:
      locator: "6.6 Map"
      quote_or_paraphrase: "The PICO-8 map is a 128x32 grid of 8-bit values, or 128x64 when using the shared memory."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.map-size.claim.2"
    statement: "La anchura del mapa puede reasignarse en la dirección 0x5F57 (MAP SIZE): 0 significa 256 y el valor por defecto es 128."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "0X5F57 MAP SIZE: map width. 0 means 256. Defaults to 128."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "map"
  property: "grid-dimensions"
  operator: "fixed"
  value: "128x32"
  unit: "tiles"
  scope: "default map"
  enforcement: "map editor capacity"
---

## Consecuencia práctica

Los 128 tiles de ancho por 32 de alto constituyen el espacio del mapa por defecto; las APIs `mget`, `mset`, `map` y `tline` operan sobre esta cuadrícula. La anchura puede configurarse vía `0x5F57` (0 = 256 tiles), y la altura queda determinada por la región de memoria asignada (ver re-mapeo en 6.7).

## Ambigüedades

Ninguna documentada.
