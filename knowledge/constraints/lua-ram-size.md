---
schema_version: "1.0"
id: "pico8.constraint.lua-ram-size"
kind: "constraint"
title: "Tamaño de la Lua RAM"
summary: "La Lua RAM de PICO-8 es de 2MB y contiene el programa compilado y las variables."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
relationships:
  - type: "related"
    target: "pico8.constraint.ram-size"
  - type: "related"
    target: "pico8.constraint.cart-rom-size"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.constraint.lua-ram-size.claim.1"
    statement: "La Lua RAM (2MB) contiene el programa compilado y las variables."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "3. Lua RAM (2MB): compiled program + variables"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.lua-ram-size.claim.2"
    statement: "2MB se interpreta como 2 mebibytes (2097152 bytes)."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "Lua RAM (2MB)"
    classification: "derived"
    confidence: "medium"
constraint:
  subject: "lua ram"
  property: "size"
  operator: "fixed"
  value: "2"
  unit: "mebibytes"
  scope: "lua runtime"
  enforcement: "lua VM memory"
---

## Consecuencia práctica

La memoria del intérprete (código compilado y variables) es independiente de la RAM base y de la cart ROM: las APIs de memoria (`peek`, `poke`, etc.) no acceden a ella.

## Ambigüedades

Ninguna documentada.
