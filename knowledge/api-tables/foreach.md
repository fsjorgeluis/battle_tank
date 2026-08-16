---
schema_version: "1.0"
id: "pico8.api.foreach"
kind: "api"
title: "FOREACH"
summary: "Llama a FUNC con cada elemento de la tabla TBL como único parámetro."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "FOREACH"
relationships:
  - type: "related-api"
    target: "pico8.api.all"
  - type: "related-api"
    target: "pico8.api.print"
  - type: "related-api"
    target: "pico8.api.add"
claims:
  - id: "pico8.api.foreach.claim.1"
    statement: "FOREACH(TBL, FUNC) llama a la función FUNC con cada elemento de la tabla TBL como único parámetro."
    evidence:
      locator: "6.3 Table Functions > FOREACH"
      quote_or_paraphrase: "For each item in table TBL, call function FUNC with the item as a single parameter."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.foreach.claim.2"
    statement: "El manual muestra FOREACH({1,2,3}, PRINT) como ejemplo."
    evidence:
      locator: "6.3 Table Functions > FOREACH"
      quote_or_paraphrase: "> FOREACH({1,2,3}, PRINT)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.foreach.claim.3"
    statement: "FOREACH, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
foreach(tbl, func)
```

## Semántica

Invoca `func(item)` por cada elemento de la tabla `tbl`, en el orden en que los produce el esquema de array.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- `func`: función que recibe un único parámetro (el elemento).
- Retorno: no especificado por la fuente.

## Efectos y límites

Requiere tablas de estilo array; para tablas con cualquier esquema de indexación se usa `pairs()`.

## Ejemplos relacionados

`foreach({1,2,3}, print)` imprime 1, 2 y 3.

## Ambigüedades

Ninguna documentada.
