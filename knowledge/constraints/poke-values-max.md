---
schema_version: "1.0"
id: "pico8.constraint.poke-values-max"
kind: "constraint"
title: "Máximo de valores de POKE"
summary: "POKE(ADDR, VAL1, VAL2, ...) escribe como máximo 8192 valores en una llamada."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "POKE"
relationships:
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.constraint.peek-result-max"
claims:
  - id: "pico8.constraint.poke-values-max.claim.1"
    statement: "Si se proporciona más de un parámetro a POKE(), se escriben secuencialmente (máx: 8192)."
    evidence:
      locator: "6.7 Memory > POKE"
      quote_or_paraphrase: "If more than one parameter is provided, they are written sequentially (max: 8192)."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "poke"
  property: "value-count"
  operator: "max"
  value: "8192"
  unit: "values"
  scope: "pico8.api.poke"
  enforcement: "poke parameter count"
---

## Consecuencia práctica

La unidad es el valor pasado a la firma de `poke` (un byte por valor); el límite se aplica al número de parámetros de una sola llamada, no al tamaño del área de memoria.

## Ambigüedades

Ninguna documentada.
