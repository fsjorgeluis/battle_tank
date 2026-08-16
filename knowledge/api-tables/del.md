---
schema_version: "1.0"
id: "pico8.api.del"
kind: "api"
title: "DEL"
summary: "Elimina la primera instancia del valor VAL de la tabla TBL y desplaza las entradas restantes."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "DEL"
relationships:
  - type: "related-api"
    target: "pico8.api.deli"
  - type: "related-api"
    target: "pico8.api.add"
  - type: "related-api"
    target: "pico8.api.count"
claims:
  - id: "pico8.api.del.claim.1"
    statement: "DEL(TBL, VAL) elimina la primera instancia del valor VAL en la tabla TBL."
    evidence:
      locator: "6.3 Table Functions > DEL"
      quote_or_paraphrase: "Delete the first instance of value VAL in table TBL."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.del.claim.2"
    statement: "Las entradas restantes se desplazan un índice a la izquierda para evitar huecos."
    evidence:
      locator: "6.3 Table Functions > DEL"
      quote_or_paraphrase: "The remaining entries are shifted left one index to avoid holes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.del.claim.3"
    statement: "VAL es el valor del elemento a eliminar, no el índice; para eliminar por índice se usa DELI."
    evidence:
      locator: "6.3 Table Functions > DEL"
      quote_or_paraphrase: "Note that VAL is the value of the item to be deleted, not the index into the table. (To remove an item at a particular index, use DELI instead)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.del.claim.4"
    statement: "DEL devuelve el elemento eliminado, o ningún valor cuando no elimina nada."
    evidence:
      locator: "6.3 Table Functions > DEL"
      quote_or_paraphrase: "DEL returns the deleted item, or returns no value when nothing was deleted."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.del.claim.5"
    statement: "DEL, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
del(tbl, val)
```

## Semántica

Elimina la primera instancia del valor `val` en la tabla `tbl` y desplaza las entradas siguientes hacia la izquierda, evitando huecos.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- `val`: valor del elemento a eliminar (no el índice).
- Retorno: el elemento eliminado, o ningún valor si no se eliminó nada.

## Efectos y límites

Para eliminar por índice se usa `DELI`. El desplazamiento mantiene la tabla compacta.

## Ejemplos relacionados

El manual inicia `A={1,10,2,11,3,12}` y combina DEL con `ALL(A)` para iterar y eliminar elementos.

## Ambigüedades

Ninguna documentada.
