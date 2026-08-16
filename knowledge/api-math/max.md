---
schema_version: "1.0"
id: "pico8.api.max"
kind: "api"
title: "MAX"
summary: "Devuelve el valor máximo de los parámetros X e Y."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "MAX"
relationships:
  - type: "related-api"
    target: "pico8.api.min"
  - type: "related-api"
    target: "pico8.api.mid"
claims:
  - id: "pico8.api.max.claim.1"
    statement: "MAX(X, Y) devuelve el valor máximo de los parámetros."
    evidence:
      locator: "6.8 Math > MAX"
      quote_or_paraphrase: "MAX(X, Y) ... Returns the maximum, minimum, or middle value of parameters"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
max(x, y)
```

## Semántica

Devuelve el mayor de los dos parámetros.

## Parámetros y retorno

- `x`, `y`: números a comparar.
- Retorno: el valor máximo de los parámetros.

## Efectos y límites

La fuente agrupa la descripción de MAX, MIN y MID ("maximum, minimum, or middle value of parameters").

## Ejemplos relacionados

Ninguno explícito para MAX en la fuente; el manual muestra `?MID(7,5,10) -- 7` para MID.

## Ambigüedades

Ninguna documentada.
