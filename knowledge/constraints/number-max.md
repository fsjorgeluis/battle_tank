---
schema_version: "1.0"
id: "pico8.constraint.number-max"
kind: "constraint"
title: "Valor máximo de un número PICO-8"
summary: "El máximo de un número PICO-8 es de aproximadamente 32767.99999."
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
    target: "pico8.constraint.number-min"
claims:
  - id: "pico8.constraint.number-max.claim.1"
    statement: "El valor máximo de un número PICO-8 es de aproximadamente 32767.99999 (0x7fff.ffff)."
    evidence:
      locator: "5 PICO-8 Program Structure > Quirks of PICO-8"
      quote_or_paraphrase: "a range of -32768 (-0x8000) to approximately 32767.99999 (0x7fff.ffff)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.number-max.claim.2"
    statement: "Añadir 1 a un contador cada frame hace que se desborde tras alrededor de 18 minutos."
    evidence:
      locator: "5 PICO-8 Program Structure > Quirks of PICO-8"
      quote_or_paraphrase: "If you add 1 to a counter each frame, it will overflow after around 18 minutes!"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "number"
  property: "maximum-value"
  operator: "approx"
  value: 32767.99999
  unit: "number-units"
  scope: "pico-8 number"
  enforcement: "fixed representation; no editor check"
---

## Consecuencia práctica

Los contadores basados en incrementos de 1 por frame se desbordan tras ~18 minutos; hay que planificar resets o usar representaciones alternativas para cronómetros largos.

## Ambigüedades

La fuente califica el máximo como "approximately"; se conserva como `approx`.
