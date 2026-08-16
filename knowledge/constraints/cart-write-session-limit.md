---
schema_version: "1.0"
id: "pico8.constraint.cart-write-session-limit"
kind: "constraint"
title: "Máximo de cartuchos escribibles por sesión"
summary: "CSTORE con FILENAME puede escribir hasta 64 cartuchos en una sesión."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "CSTORE"
relationships:
  - type: "related"
    target: "pico8.api.cstore"
  - type: "related"
    target: "pico8.constraint.cart-rom-size"
claims:
  - id: "pico8.constraint.cart-write-session-limit.claim.1"
    statement: "Si se especifica FILENAME en CSTORE(), los datos se escriben directamente en ese cartucho en disco; hasta 64 cartuchos pueden escribirse en una sesión."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "If FILENAME is specified, the data is written directly to that cartridge on disk. Up to 64 cartridges can be written in one session."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "cstore"
  property: "cartridges-per-session"
  operator: "max"
  value: "64"
  unit: "cartridges"
  scope: "pico8.api.cstore"
  enforcement: "cstore session limit"
---

## Consecuencia práctica

El límite se aplica al uso de `cstore` con `filename` (escritura directa en disco): no más de 64 cartuchos distintos por sesión.

## Ambigüedades

Ninguna documentada.
