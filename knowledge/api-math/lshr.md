---
schema_version: "1.0"
id: "pico8.api.lshr"
kind: "api"
title: "LSHR"
summary: "Desplazamiento lógico a la derecha: entran ceros por la izquierda."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "LSHR"
relationships:
  - type: "related-api"
    target: "pico8.api.shl"
  - type: "related-api"
    target: "pico8.api.shr"
claims:
  - id: "pico8.api.lshr.claim.1"
    statement: "LSHR(X, N) es un desplazamiento lógico a la derecha: entran ceros por la izquierda."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "LSHR(X, N) -- LOGICAL RIGHT SHIFT (ZEROS COMES IN FROM THE LEFT)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.lshr.claim.2"
    statement: "El operador >>> equivale a LSHR y es ligeramente más rápido; si cualquier operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
lshr(x, n)
```

## Semántica

Desplazamiento lógico a la derecha: mueve los bits de `x` a la derecha `n` posiciones introduciendo ceros por la izquierda.

## Parámetros y retorno

- `x`: número entero.
- `n`: número de posiciones a desplazar.
- Retorno: resultado del desplazamiento lógico.

## Efectos y límites

Se distingue de `shr()` en que éste duplica el bit más a la izquierda.

## Ejemplos relacionados

Ninguno explícito en la fuente para LSHR.

## Ambigüedades

Ninguna documentada.
