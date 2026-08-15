---
schema_version: "1.0"
id: "pico8.constraint.number-min"
kind: "constraint"
title: "Valor mínimo de un número PICO-8"
summary: "El mínimo de un número PICO-8 es -32768 (-0x8000)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "5 PICO-8 Program Structure > Quirks of PICO-8"
relationships:
  - type: "related"
    target: "pico8.constraint.number-precision"
  - type: "related"
    target: "pico8.constraint.number-max"
claims:
  - id: "pico8.constraint.number-min.claim.1"
    statement: "El valor mínimo de un número PICO-8 es -32768 (-0x8000)."
    evidence:
      locator: "5 PICO-8 Program Structure > Quirks of PICO-8"
      quote_or_paraphrase: "a range of -32768 (-0x8000) to approximately 32767.99999 (0x7fff.ffff)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "number"
  property: "minimum-value"
  operator: "fixed"
  value: -32768
  unit: "number-units"
  scope: "pico-8 number"
  enforcement: "fixed representation; no editor check"
---

## Consecuencia práctica

Los valores no pueden bajar de -32768. Este límite está vinculado a la representación de 16 bits que describe la fuente.

## Ambigüedades

Ninguna documentada.
