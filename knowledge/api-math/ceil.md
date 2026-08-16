---
schema_version: "1.0"
id: "pico8.api.ceil"
kind: "api"
title: "CEIL"
summary: "Devuelve el entero más cercano a X igual o por encima de X (techo)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "CEIL"
relationships:
  - type: "related-api"
    target: "pico8.api.flr"
claims:
  - id: "pico8.api.ceil.claim.1"
    statement: "CEIL(X) devuelve el entero más cercano igual o por encima de X: ?CEIL(4.1) --> 5."
    evidence:
      locator: "6.8 Math > CEIL"
      quote_or_paraphrase: "> ?CEIL( 4.1) -->  5"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ceil.claim.2"
    statement: "CEIL(-2.3) devuelve -2, coherente con el comportamiento de techo."
    evidence:
      locator: "6.8 Math > CEIL"
      quote_or_paraphrase: "> ?CEIL(-2.3) --> -2"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
ceil(x)
```

## Semántica

Devuelve el menor entero mayor o igual a `x` (techo). La descripción de la fuente ("equal to or below x") contradice sus propios ejemplos y coincide con el texto esperable de FLR; se toma como errata y el comportamiento normalizado es el techo.

## Parámetros y retorno

- `x`: número.
- Retorno: el entero techo de `x`.

## Efectos y límites

Es la operación complementaria de `flr()`.

## Ejemplos relacionados

```lua
?ceil(4.1)  -- 5
?ceil(-2.3) -- -2
```

## Ambigüedades

- Errata de fuente: el texto describe CEIL como "closest integer that is equal to or below x" (comportamiento de suelo) mientras los ejemplos muestran techo (`?CEIL(4.1) --> 5`, `?CEIL(-2.3) --> -2`). Se documenta el comportamiento de los ejemplos.
