---
schema_version: "1.0"
id: "pico8.constraint.peek-result-max"
kind: "constraint"
title: "Máximo de resultados de PEEK"
summary: "PEEK(ADDR, [N]) devuelve como máximo 8192 resultados cuando se especifica N."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "PEEK"
relationships:
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.constraint.poke-values-max"
claims:
  - id: "pico8.constraint.peek-result-max.claim.1"
    statement: "Si N se especifica, PEEK() devuelve ese número de resultados (máx: 8192)."
    evidence:
      locator: "6.7 Memory > PEEK"
      quote_or_paraphrase: "If N is specified, PEEK() returns that number of results (max: 8192)."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "peek"
  property: "result-count"
  operator: "max"
  value: "8192"
  unit: "results"
  scope: "pico8.api.peek"
  enforcement: "peek parameter N"
---

## Consecuencia práctica

La unidad es el resultado devuelto por la firma de `peek` (un byte por resultado); el límite se aplica al parámetro opcional `n`, no al tamaño del área de memoria.

## Ambigüedades

Ninguna documentada.
