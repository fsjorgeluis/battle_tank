---
schema_version: "1.0"
id: "pico8.api.mid"
kind: "api"
title: "MID"
summary: "Devuelve el valor del medio de los parámetros X, Y y Z."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "MID"
relationships:
  - type: "related-api"
    target: "pico8.api.max"
  - type: "related-api"
    target: "pico8.api.min"
claims:
  - id: "pico8.api.mid.claim.1"
    statement: "MID(X, Y, Z) devuelve el valor del medio de los parámetros."
    evidence:
      locator: "6.8 Math > MID"
      quote_or_paraphrase: "MID(X, Y, Z) ... Returns the maximum, minimum, or middle value of parameters"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.mid.claim.2"
    statement: "El manual muestra ?MID(7,5,10) -- 7."
    evidence:
      locator: "6.8 Math > MID"
      quote_or_paraphrase: "> ?MID(7,5,10) -- 7"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
mid(x, y, z)
```

## Semántica

Devuelve el valor intermedio de los tres parámetros.

## Parámetros y retorno

- `x`, `y`, `z`: números a comparar.
- Retorno: el valor del medio de los parámetros.

## Efectos y límites

La fuente agrupa la descripción de MAX, MIN y MID ("maximum, minimum, or middle value of parameters").

## Ejemplos relacionados

`?mid(7,5,10) -- 7`

## Ambigüedades

Ninguna documentada.
