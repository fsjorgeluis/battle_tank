---
schema_version: "1.0"
id: "pico8.constraint.cartdata-number-count"
kind: "constraint"
title: "Capacidad de números del slot CARTDATA"
summary: "Un slot CARTDATA almacena exactamente 64 números (256 bytes)."
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
    target: "pico8.constraint.persistent-cart-data-size"
  - type: "related"
    target: "pico8.constraint.cartdata-id-length"
  - type: "related"
    target: "pico8.api.cartdata"
  - type: "related"
    target: "pico8.api.dget"
  - type: "related"
    target: "pico8.api.dset"
constraint:
  subject: "cartdata slot"
  property: "number-count"
  operator: "fixed"
  value: "64"
  unit: "numbers"
  scope: "pico8.api.cartdata"
  enforcement: "DGET/DSET index range 0..63"
claims:
  - id: "pico8.constraint.cartdata-number-count.claim.1"
    statement: "CARTDATA(), DSET() y DGET() permiten almacenar 64 números (256 bytes) de datos persistentes en el PICO-8 del usuario."
    evidence:
      locator: "6.11 Cartridge Data"
      quote_or_paraphrase: "Using CARTDATA(), DSET(), AND DGET(), 64 numbers (256 bytes) of persistent data can be stored on the user's PICO-8 that persists after the cart is unloaded or PICO-8 is shutdown."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cartdata-number-count.claim.2"
    statement: "Un slot abierto con CARTDATA(ID) puede almacenar y recuperar hasta 256 bytes (64 números) mediante DSET() y DGET()."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "Opens a permanent data storage slot indexed by ID that can be used to store and retrieve up to 256 bytes (64 numbers) worth of data using DSET() and DGET()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cartdata-number-count.claim.3"
    statement: "DGET(INDEX) y DSET(INDEX, VALUE) operan sobre índices 0..63."
    evidence:
      locator: "6.11 Cartridge Data > DGET"
      quote_or_paraphrase: "Get the number stored at INDEX (0..63); Set the number stored at index (0..63)"
    classification: "fact"
    confidence: "high"
---

## Consecuencia práctica

El slot de `cartdata()` se compone de 64 números, accesibles por índice 0..63 con `dget()`/`dset()`. El mismo área corresponde a los 256 bytes de 0x5e00..0x5eff (restricción `pico8.constraint.persistent-cart-data-size`).

## Ambigüedades

Ninguna documentada.
