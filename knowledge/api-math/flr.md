---
schema_version: "1.0"
id: "pico8.api.flr"
kind: "api"
title: "FLR"
summary: "Devuelve el entero más cercano a X igual o por debajo de X (suelo)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "FLR"
relationships:
  - type: "related-api"
    target: "pico8.api.ceil"
  - type: "related-api"
    target: "pico8.api.rnd"
claims:
  - id: "pico8.api.flr.claim.1"
    statement: "FLR(X) devuelve el entero más cercano igual o por debajo de X; con valores positivos trunca: ?FLR(4.1) --> 4."
    evidence:
      locator: "6.8 Math > FLR"
      quote_or_paraphrase: "> ?FLR ( 4.1) -->  4"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flr.claim.2"
    statement: "Con valores negativos, FLR redondea hacia menos infinito: ?FLR(-2.3) --> -3."
    evidence:
      locator: "6.8 Math > FLR"
      quote_or_paraphrase: "> ?FLR (-2.3) --> -3"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.flr.claim.3"
    statement: "El operador de división entera \ equivale a FLR(9/2): PRINT(9\\2) devuelve 4."
    evidence:
      locator: "6.8 Math > Integer Division"
      quote_or_paraphrase: "Integer division can be performed with a \\; > PRINT(9\\2) -- RESULT:4 EQUIVALENT TO FLR(9/2)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
flr(x)
```

## Semántica

Devuelve el mayor entero menor o igual a `x` (suelo). La fuente de esta versión no incluye texto descriptivo para FLR: el comportamiento se deduce de los ejemplos `?FLR(4.1) --> 4` y `?FLR(-2.3) --> -3`.

## Parámetros y retorno

- `x`: número.
- Retorno: el entero suelo de `x`.

## Efectos y límites

El operador `\` realiza división entera equivalente a `flr(a / b)`.

## Ejemplos relacionados

```lua
?flr(4.1)  -- 4
?flr(-2.3) -- -3
print(9\2) -- 4, equivalente a flr(9/2)
```

## Ambigüedades

- Limitación de fuente: la sección FLR no describe su semántica con texto, sólo con ejemplos. No se infiere más allá del comportamiento de suelo mostrado.
