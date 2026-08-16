---
schema_version: "1.0"
id: "pico8.api.rnd"
kind: "api"
title: "RND"
summary: "Número aleatorio n con 0 <= n < X; con una tabla de estilo array, un elemento aleatorio."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "RND"
relationships:
  - type: "related-api"
    target: "pico8.api.flr"
  - type: "related-api"
    target: "pico8.api.srand"
claims:
  - id: "pico8.api.rnd.claim.1"
    statement: "RND(X) devuelve un número aleatorio n, donde 0 <= n < x."
    evidence:
      locator: "6.8 Math > RND"
      quote_or_paraphrase: "Returns a random number n, where 0 <= n < x"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rnd.claim.2"
    statement: "Para obtener un entero, se usa flr(rnd(x))."
    evidence:
      locator: "6.8 Math > RND"
      quote_or_paraphrase: "If you want an integer, use flr(rnd(x))."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.rnd.claim.3"
    statement: "Si X es una tabla de estilo array, RND devuelve un elemento aleatorio entre table[1] y table[#table]."
    evidence:
      locator: "6.8 Math > RND"
      quote_or_paraphrase: "If x is an array-style table, return a random element between table[1] and table[#table]."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rnd(x)
```

## Semántica

Devuelve un número aleatorio `n` en `[0, x)`. Si `x` es una tabla de estilo array, devuelve un elemento aleatorio de la tabla.

## Parámetros y retorno

- `x`: límite superior exclusivo, o una tabla de estilo array.
- Retorno: número aleatorio `n` con `0 <= n < x`, o un elemento aleatorio de la tabla.

## Efectos y límites

Para enteros, combinar con `flr()`. La semilla se controla con `srand()` y se aleatoriza en el arranque del cartucho.

## Ejemplos relacionados

```lua
for i=1,100 do
  pset(rnd(128), rnd(128), 7)
end
```

## Ambigüedades

Ninguna documentada.
