---
schema_version: "1.0"
id: "pico8.api.add"
kind: "api"
title: "ADD"
summary: "Añade VAL al final de la tabla TBL; con INDEX, inserta en esa posición."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "ADD"
relationships:
  - type: "related-api"
    target: "pico8.api.del"
  - type: "related-api"
    target: "pico8.api.deli"
  - type: "related-api"
    target: "pico8.api.count"
  - type: "related-api"
    target: "pico8.api.all"
claims:
  - id: "pico8.api.add.claim.1"
    statement: "ADD(TBL, VAL) añade el valor VAL al final de la tabla TBL, y equivale a TBL[#TBL + 1] = VAL."
    evidence:
      locator: "6.3 Table Functions > ADD"
      quote_or_paraphrase: "Add value VAL to the end of table TBL. Equivalent to: TBL[#TBL + 1] = VAL"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.add.claim.2"
    statement: "Si se da INDEX, ADD inserta el elemento en esa posición de la tabla."
    evidence:
      locator: "6.3 Table Functions > ADD"
      quote_or_paraphrase: "If index is given then the element is inserted at that position"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.add.claim.3"
    statement: "ADD, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.add.claim.4"
    statement: "El manual muestra FOO={}, ADD(FOO,11), ADD(FOO,22); PRINT(FOO[2]) devuelve 22."
    evidence:
      locator: "6.3 Table Functions > ADD"
      quote_or_paraphrase: "FOO={} -- CREATE EMPTY TABLE; ADD(FOO, 11); ADD(FOO, 22); PRINT(FOO[2]) -- 22"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
add(tbl, val, [index])
```

## Semántica

Añade el valor `val` al final de la tabla `tbl`; equivale a `tbl[#tbl + 1] = val`. Si se da `index`, inserta el valor en esa posición.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- `val`: valor a añadir.
- `index` (opcional): posición en la que se inserta el valor.
- Retorno: no especificado por la fuente.

## Efectos y límites

Opera sobre tablas de estilo array; otras tablas (hash maps o conjuntos) no tienen longitud según la fuente. Al insertar con `index`, los elementos siguientes se desplazan.

## Ejemplos relacionados

```lua
foo = {}
add(foo, 11)
add(foo, 22)
print(foo[2]) -- 22
```

## Ambigüedades

Ninguna documentada.
