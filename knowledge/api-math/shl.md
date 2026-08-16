---
schema_version: "1.0"
id: "pico8.api.shl"
kind: "api"
title: "SHL"
summary: "Desplaza los bits de X a la izquierda N posiciones (entran ceros por la derecha)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "SHL"
relationships:
  - type: "related-api"
    target: "pico8.api.shr"
  - type: "related-api"
    target: "pico8.api.lshr"
claims:
  - id: "pico8.api.shl.claim.1"
    statement: "SHL(X, N) desplaza los bits de X a la izquierda N posiciones; entran ceros por la derecha."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "SHL(X, N) -- SHIFT LEFT N BITS (ZEROS COME IN FROM THE RIGHT)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.shl.claim.2"
    statement: "El operador << equivale a SHL y es ligeramente más rápido; si cualquier operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
shl(x, n)
```

## Semántica

Desplaza los bits de `x` a la izquierda `n` posiciones; entran ceros por la derecha.

## Parámetros y retorno

- `x`: número entero.
- `n`: número de posiciones a desplazar.
- Retorno: resultado del desplazamiento.

## Efectos y límites

El operador `x << n` es la versión de operador, ligeramente más rápida; con operandos no numéricos produce error de ejecución (la función devuelve 0).

## Ejemplos relacionados

Ninguno explícito en la fuente para SHL.

## Ambigüedades

Ninguna documentada.
