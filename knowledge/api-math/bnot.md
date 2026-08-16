---
schema_version: "1.0"
id: "pico8.api.bnot"
kind: "api"
title: "BNOT"
summary: "NOT a nivel de bits: invierte el estado de cada bit de X."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "BNOT"
relationships:
  - type: "related-api"
    target: "pico8.api.band"
  - type: "related-api"
    target: "pico8.api.bxor"
claims:
  - id: "pico8.api.bnot.claim.1"
    statement: "BNOT(X) invierte el estado de cada bit (cada bit no fijado pasa a estar fijado)."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "BNOT(X) -- EACH BIT IS NOT SET"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.bnot.claim.2"
    statement: "El operador ~ equivale a BNOT y es ligeramente más rápido; si el operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
bnot(x)
```

## Semántica

NOT a nivel de bits: invierte cada bit de `x`.

## Parámetros y retorno

- `x`: número entero.
- Retorno: resultado del NOT a nivel de bits.

## Efectos y límites

El operador `~x` es la versión de operador, ligeramente más rápida; con operandos no numéricos produce error de ejecución (la función devuelve 0).

## Ejemplos relacionados

Ninguno explícito en la fuente para BNOT.

## Ambigüedades

Ninguna documentada.
