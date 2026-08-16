---
schema_version: "1.0"
id: "pico8.api.rotl"
kind: "api"
title: "ROTL"
summary: "Rota todos los bits de X a la izquierda N posiciones."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "ROTL"
relationships:
  - type: "related-api"
    target: "pico8.api.rotr"
  - type: "related-api"
    target: "pico8.api.shl"
claims:
  - id: "pico8.api.rotl.claim.1"
    statement: "ROTL(X, N) rota todos los bits de X a la izquierda N posiciones."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "ROTL(X, N) -- ROTATE ALL BITS IN X LEFT BY N PLACES"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rotl.claim.2"
    statement: "El operador <<> equivale a ROTL y es ligeramente más rápido; si cualquier operando no es un número produce un error de ejecución, mientras que la versión función devuelve 0 por defecto."
    evidence:
      locator: "6.8 Math > Bitwise Operations"
      quote_or_paraphrase: "Operator versions are also available: & | ^^ ~ << >> >>> <<> >>< ... Operators are slightly faster than their corresponding functions. They behave exactly the same, except that if any operands are not numbers the result is a runtime error (the function versions instead default to a value of 0)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rotl(x, n)
```

## Semántica

Rota los bits de `x` a la izquierda `n` posiciones; los bits que salen por la izquierda vuelven a entrar por la derecha.

## Parámetros y retorno

- `x`: número entero.
- `n`: número de posiciones a rotar.
- Retorno: resultado de la rotación.

## Efectos y límites

A diferencia de `shl()`, no se pierden bits: los bits desplazados se reinsertan por el extremo opuesto.

## Ejemplos relacionados

Ninguno explícito en la fuente para ROTL.

## Ambigüedades

Ninguna documentada.
