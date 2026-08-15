---
schema_version: "1.0"
id: "pico8.constraint.cpu-cycles-per-instruction"
kind: "constraint"
title: "Ciclos por instrucción de VM"
summary: "Cada instrucción de la VM Lua cuesta alrededor de 2 ciclos de CPU virtual."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "5 PICO-8 Program Structure > CPU"
relationships:
  - type: "related"
    target: "pico8.constraint.cpu-clock"
  - type: "related"
    target: "pico8.constraint.cpu-throughput"
claims:
  - id: "pico8.constraint.cpu-cycles-per-instruction.claim.1"
    statement: "Cada instrucción de la VM Lua cuesta alrededor de 2 ciclos."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "each lua vm instruction costs around 2 cycles"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cpu-cycles-per-instruction.claim.2"
    statement: "Las operaciones integradas, como dibujar sprites, también tienen un coste de CPU."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "Built-in operations like drawing sprites also have a CPU cost."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "cpu"
  property: "cycles-per-vm-instruction"
  operator: "approx"
  value: 2
  unit: "cycles"
  scope: "runtime"
  enforcement: "cost model for CPU budgeting; observed via CPU meter"
---

## Consecuencia práctica

El coste no se limita a las instrucciones Lua: las operaciones integradas consumen CPU. La métrica del manual es orientativa; la fuente usa "around", por lo que no debe tratarse como un coste exacto.

## Ambigüedades

La fuente usa "around 2 cycles"; el validador lo conserva como `operator: approx` y no se convierte en un valor fijo.
