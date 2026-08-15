---
schema_version: "1.0"
id: "pico8.constraint.cpu-throughput"
kind: "constraint"
title: "Rendimiento de CPU virtual"
summary: "La CPU virtual ofrece 4M de instrucciones de máquina virtual por segundo."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "Specifications"
relationships:
  - type: "related"
    target: "pico8.constraint.cpu-clock"
  - type: "related"
    target: "pico8.constraint.cpu-cycles-per-instruction"
  - type: "related"
    target: "pico8.constraint.token-limit"
claims:
  - id: "pico8.constraint.cpu-throughput.claim.1"
    statement: "La CPU virtual ofrece 4M de instrucciones de VM por segundo."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "CPU: 4M vm insts/sec"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cpu-throughput.claim.2"
    statement: "El rendimiento publicado (4M insts/s) es coherente con 8 MHz y ~2 ciclos por instrucción VM."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "8MHz with ~2 cycles per instruction is consistent with 4M insts/sec"
    classification: "derived"
    confidence: "high"
  - id: "pico8.constraint.cpu-throughput.claim.3"
    statement: "La carga de CPU se puede observar con el medidor CTRL-P o con stat(1) al final de cada frame."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "press CTRL-P to toggle a CPU meter, or print out STAT(1) at the end of each frame"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "cpu"
  property: "vm-instruction-throughput"
  operator: "max"
  value: 4000000
  unit: "vm-instructions/second"
  scope: "runtime"
  enforcement: "CPU meter (CTRL-P) / stat(1)"
---

## Consecuencia práctica

Es el presupuesto de cómputo por segundo. A 30fps hay ~133k instrucciones por frame de presupuesto; la fuente también indica que en modo 60fps se dispone de la mitad de CPU por frame antes de caer a 30fps.

## Ambigüedades

La cifra publicada es una capacidad garantizada por el sistema virtual; el manual no describe el algoritmo exacto de muestreo del medidor.
