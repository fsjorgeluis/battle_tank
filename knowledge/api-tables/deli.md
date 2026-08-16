---
schema_version: "1.0"
id: "pico8.api.deli"
kind: "api"
title: "DELI"
summary: "Elimina el elemento de la tabla TBL en el índice I; sin I, elimina y devuelve el último."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "DELI"
relationships:
  - type: "related-api"
    target: "pico8.api.del"
  - type: "related-api"
    target: "pico8.api.add"
  - type: "related-api"
    target: "pico8.api.all"
claims:
  - id: "pico8.api.deli.claim.1"
    statement: "DELI(TBL, [I]) elimina el elemento de la tabla TBL en el índice I."
    evidence:
      locator: "6.3 Table Functions > DELI"
      quote_or_paraphrase: "Like DEL(), but remove the item from table TBL at index I."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.deli.claim.2"
    statement: "Cuando I no se da, se elimina y devuelve el último elemento de la tabla."
    evidence:
      locator: "6.3 Table Functions > DELI"
      quote_or_paraphrase: "When I is not given, the last element of the table is removed and returned."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.deli.claim.3"
    statement: "DELI, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
deli(tbl, [i])
```

## Semántica

Elimina el elemento en el índice `i` de la tabla `tbl`. Si `i` se omite, elimina y devuelve el último elemento.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- `i` (opcional): índice del elemento a eliminar.
- Retorno: el elemento eliminado (el último cuando `i` se omite).

## Efectos y límites

Equivale a DEL pero operando por índice en lugar de por valor.

## Ejemplos relacionados

Ninguno explícito en la fuente para DELI; el manual la recomienda desde DEL para eliminar por índice.

## Ambigüedades

Ninguna documentada.
