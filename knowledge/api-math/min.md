---
schema_version: "1.0"
id: "pico8.api.min"
kind: "api"
title: "MIN"
summary: "Devuelve el valor mínimo de los parámetros X e Y."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "MIN"
relationships:
  - type: "related-api"
    target: "pico8.api.max"
  - type: "related-api"
    target: "pico8.api.mid"
claims:
  - id: "pico8.api.min.claim.1"
    statement: "MIN(X, Y) devuelve el valor mínimo de los parámetros."
    evidence:
      locator: "6.8 Math > MIN"
      quote_or_paraphrase: "MIN(X, Y) ... Returns the maximum, minimum, or middle value of parameters"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
min(x, y)
```

## Semántica

Devuelve el menor de los dos parámetros.

## Parámetros y retorno

- `x`, `y`: números a comparar.
- Retorno: el valor mínimo de los parámetros.

## Efectos y límites

La fuente agrupa la descripción de MAX, MIN y MID ("maximum, minimum, or middle value of parameters").

## Ejemplos relacionados

Ninguno explícito para MIN en la fuente; el manual muestra `?MID(7,5,10) -- 7` para MID.

## Ambigüedades

Ninguna documentada.
