---
schema_version: "1.0"
id: "pico8.constraint.cartdata-id-length"
kind: "constraint"
title: "Longitud máxima del ID de CARTDATA"
summary: "El ID de un slot CARTDATA puede tener hasta 64 caracteres (a..z, 0..9, _)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.11 Cartridge Data"
    anchor: "CARTDATA"
relationships:
  - type: "related"
    target: "pico8.api.cartdata"
  - type: "related"
    target: "pico8.constraint.cartdata-number-count"
constraint:
  subject: "cartdata slot id"
  property: "length"
  operator: "max"
  value: "64"
  unit: "characters"
  scope: "pico8.api.cartdata"
  enforcement: "validación de cadena del ID"
claims:
  - id: "pico8.constraint.cartdata-id-length.claim.1"
    statement: "El ID de CARTDATA es un string de hasta 64 caracteres."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "ID is a string up to 64 characters long"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cartdata-id-length.claim.2"
    statement: "Los caracteres legales del ID son a..z, 0..9 y subrayado (_)."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "Legal characters are a..z, 0..9 and underscore (_)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cartdata-id-length.claim.3"
    statement: "El ID debe ser suficientemente inusual para que otros cartuchos no usen accidentalmente el mismo."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "should be unusual enough that other cartridges do not accidentally use the same id"
    classification: "fact"
    confidence: "high"
---

## Consecuencia práctica

El ID elegido para `cartdata()` debe usar el conjunto a..z, 0..9 y `_` y no superar los 64 caracteres. Se recomienda un identificador distintivo por juego.

## Ambigüedades

Ninguna documentada.
