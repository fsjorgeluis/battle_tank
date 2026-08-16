---
schema_version: "1.0"
id: "pico8.api.bor"
kind: "api"
title: "BOR"
summary: "OR a nivel de bits: bits fijados cuando cualquiera de X o Y los tiene."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "BOR"
relationships:
  - type: "related-api"
    target: "pico8.api.band"
  - type: "related-api"
    target: "pico8.api.bxor"
claims:
  - id: "pico8.api.bor.claim.1"
    statement: "BOR(X, Y) fija los bits cuando cualquiera de los dos operandos los tiene fijados."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "BOR(X, Y) -- EITHER BIT IS SET"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.bor.claim.2"
    statement: "El operador | equivale a BOR y es ligeramente más rápido; si cualquier operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
bor(x, y)
```

## Semántica

OR a nivel de bits: cada bit del resultado está fijado si está fijado en `x` o en `y`.

## Parámetros y retorno

- `x`, `y`: números enteros.
- Retorno: resultado del OR a nivel de bits.

## Efectos y límites

El operador `x | y` es la versión de operador, ligeramente más rápida; con operandos no numéricos produce error de ejecución (la función devuelve 0).

## Ejemplos relacionados

Ninguno explícito en la fuente para BOR.

## Ambigüedades

Ninguna documentada.
