---
schema_version: "1.0"
id: "pico8.constraint.persistent-cart-data-size"
kind: "constraint"
title: "Tamaño de los datos persistentes del cartucho"
summary: "PICO-8 reserva 256 bytes de datos persistentes de cartucho en 0x5e00..0x5eff."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "Base RAM Memory Layout"
relationships:
  - type: "related"
    target: "pico8.constraint.ram-size"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke"
claims:
  - id: "pico8.constraint.persistent-cart-data-size.claim.1"
    statement: "La RAM base incluye PERSISTENT CART DATA de 256 bytes en la dirección 0x5e00."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "0X5E00 PERSISTENT CART DATA (256 BYTES)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.persistent-cart-data-size.claim.2"
    statement: "Los datos persistentes se mapean a 0x5e00..0x5eff pero sólo se almacenan si se ha llamado a CARTDATA()."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Persistent cart data is mapped to 0x5e00..0x5eff but only stored if CARTDATA() has been called."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "persistent cart data"
  property: "size"
  operator: "fixed"
  value: "256"
  unit: "bytes"
  scope: "persistent cart data"
  enforcement: "0x5e00..0x5eff mapping"
---

## Consecuencia práctica

Los 256 bytes de 0x5e00..0x5eff son el área de persistencia de partidas; sólo se conservan tras llamar a `CARTDATA()` (API que pertenece a la fase data-math, sección 6.11).

## Ambigüedades

Ninguna documentada.
