---
schema_version: "1.0"
id: "pico8.constraint.token-limit"
kind: "constraint"
title: "Límite de tokens de código"
summary: "El código de un programa PICO-8 está limitado a un máximo de 8192 tokens."
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
    target: "pico8.constraint.cpu-throughput"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.constraint.token-limit.claim.1"
    statement: "El código del cartucho está limitado a un máximo de 8192 tokens de código P8 Lua."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Code: P8 Lua (max 8192 tokens of code)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.token-limit.claim.2"
    statement: "El código inyectado con #INCLUDE está sujeto a los límites normales de tokens y caracteres."
    evidence:
      locator: "5 PICO-8 Program Structure > #INCLUDE"
      quote_or_paraphrase: "Normal character count and token limits apply."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "code"
  property: "token-limit"
  operator: "max"
  value: 8192
  unit: "tokens"
  scope: "one program"
  enforcement: "editor warning"
---

## Consecuencia práctica

El contador del editor avisa cuando el programa se acerca o supera el límite. Como los archivos `#INCLUDE` se tratan como si estuvieran pegados en el editor, el límite se aplica al resultado de concatenar todos los tabs e includes del programa.

## Ambigüedades

Ninguna documentada.
