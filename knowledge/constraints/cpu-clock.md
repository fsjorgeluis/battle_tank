---
schema_version: "1.0"
id: "pico8.constraint.cpu-clock"
kind: "constraint"
title: "Velocidad de CPU virtual"
summary: "PICO-8 define una velocidad de CPU virtual de 8 MHz."
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
    target: "pico8.constraint.cpu-cycles-per-instruction"
  - type: "related"
    target: "pico8.constraint.cpu-throughput"
claims:
  - id: "pico8.constraint.cpu-clock.claim.1"
    statement: "Existe una velocidad de CPU virtual de 8 MHz."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "there is a virtual CPU speed of 8MHz"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cpu-clock.claim.2"
    statement: "A 8 MHz con ~2 ciclos por instrucción VM se obtienen ~4M instrucciones de VM por segundo, el valor publicado en Specifications."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "8MHz / ~2 cycles per vm instruction ~ 4M vm insts/sec (derivado aritmético)"
    classification: "derived"
    confidence: "high"
constraint:
  subject: "cpu"
  property: "clock-speed"
  operator: "fixed"
  value: 8
  unit: "MHz"
  scope: "runtime"
  enforcement: "virtual timing guarantee; observed via CPU meter (CTRL-P / stat(1))"
---

## Consecuencia práctica

El reloj virtual permite que un cartucho hecho en una máquina potente corra razonablemente en máquinas más lentas. Al presupuestar coste por frame hay que partir de esta velocidad y del coste de cada operación.

## Ambigüedades

Ninguna documentada.
