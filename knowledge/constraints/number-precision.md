---
schema_version: "1.0"
id: "pico8.constraint.number-precision"
kind: "constraint"
title: "Precisión mínima de números PICO-8"
summary: "El paso mínimo entre números PICO-8 es de aproximadamente 0.00002."
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
    target: "pico8.constraint.number-min"
  - type: "related"
    target: "pico8.constraint.number-max"
claims:
  - id: "pico8.constraint.number-precision.claim.1"
    statement: "El paso mínimo entre números PICO-8 es de aproximadamente 0.00002 (0x0.0001)."
    evidence:
      locator: "5 PICO-8 Program Structure > Quirks of PICO-8"
      quote_or_paraphrase: "the minimum step between numbers is approximately 0.00002 (0x0.0001)"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "number"
  property: "minimum-step"
  operator: "approx"
  value: 0.00002
  unit: "number-units"
  scope: "pico-8 number"
  enforcement: "fixed representation; no editor check"
---

## Consecuencia práctica

Los números no tienen precisión infinita: acumular incrementos muy pequeños puede redondear. La fuente califica el paso como "approximately", por lo que el límite se conserva como `approx`.

## Ambigüedades

La fuente no especifica el comportamiento exacto de redondeo; sólo el paso mínimo aproximado.
