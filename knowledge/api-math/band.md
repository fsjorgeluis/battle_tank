---
schema_version: "1.0"
id: "pico8.api.band"
kind: "api"
title: "BAND"
summary: "AND a nivel de bits: bits fijados cuando están fijados en X e Y."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "BAND"
relationships:
  - type: "related-api"
    target: "pico8.api.bor"
  - type: "related-api"
    target: "pico8.api.bxor"
  - type: "related-api"
    target: "pico8.api.bnot"
claims:
  - id: "pico8.api.band.claim.1"
    statement: "BAND(X, Y) fija los bits que están fijados en X y en Y (ambos bits fijados)."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "BAND(X, Y) -- BOTH BITS ARE SET"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.band.claim.2"
    statement: "El operador & equivale a BAND y es ligeramente más rápido; si cualquier operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.band.claim.3"
    statement: "El manual muestra PRINT(BAND(X,Y)) con X=0b1010 e Y=0b0110, resultado 0b0010 (2 en decimal)."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "X = 0b1010; Y = 0b0110; > PRINT(BAND(X,Y)) -- RESULT:0B0010 (2 IN DECIMAL)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
band(x, y)
```

## Semántica

AND a nivel de bits: cada bit del resultado está fijado si está fijado en `x` y en `y`.

## Parámetros y retorno

- `x`, `y`: números enteros.
- Retorno: resultado del AND a nivel de bits.

## Efectos y límites

El operador `x & y` es la versión de operador, ligeramente más rápida; con operandos no numéricos produce error de ejecución (la función devuelve 0).

## Ejemplos relacionados

```lua
print(67 & 63) -- 3, equivalente a band(67,63)
```

## Ambigüedades

Ninguna documentada.
