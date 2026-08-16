---
schema_version: "1.0"
id: "pico8.api.count"
kind: "api"
title: "COUNT"
summary: "Devuelve la longitud de la tabla TBL (igual que #TBL); con VAL, el número de instancias de VAL."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "COUNT"
relationships:
  - type: "related-api"
    target: "pico8.api.add"
  - type: "related-api"
    target: "pico8.api.del"
  - type: "related-api"
    target: "pico8.api.all"
claims:
  - id: "pico8.api.count.claim.1"
    statement: "COUNT(TBL) devuelve la longitud de la tabla, igual que #TBL."
    evidence:
      locator: "6.3 Table Functions > COUNT"
      quote_or_paraphrase: "Returns the length of table t (same as #TBL)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.count.claim.2"
    statement: "Cuando se da VAL, COUNT devuelve el número de instancias de VAL en la tabla."
    evidence:
      locator: "6.3 Table Functions > COUNT"
      quote_or_paraphrase: "When VAL is given, returns the number of instances of VAL in that table."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.count.claim.3"
    statement: "COUNT, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
count(tbl, [val])
```

## Semántica

Devuelve la longitud de la tabla `tbl` (igual que `#tbl`). Con `val`, devuelve cuántas instancias de `val` contiene.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- `val` (opcional): valor a contar.
- Retorno: la longitud de la tabla, o el número de instancias de `val`.

## Efectos y límites

El operador `#` sobre tablas tiene la misma semántica que `COUNT` sin `val`.

## Ejemplos relacionados

El manual usa `PRINT(#T) -- 5` tras `ADD(T,14)` y `ADD(T,"HI")` sobre `T={11,12,13}`.

## Ambigüedades

Ninguna documentada.
