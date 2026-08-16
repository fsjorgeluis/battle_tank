---
schema_version: "1.0"
id: "pico8.api.all"
kind: "api"
title: "ALL"
summary: "Itera en FOR sobre todos los elementos de la tabla en el orden en que se añadieron."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "ALL"
relationships:
  - type: "related-api"
    target: "pico8.api.pairs"
  - type: "related-api"
    target: "pico8.api.add"
  - type: "related-api"
    target: "pico8.api.count"
  - type: "related-api"
    target: "pico8.api.foreach"
claims:
  - id: "pico8.api.all.claim.1"
    statement: "ALL(TBL) se usa en bucles FOR para iterar sobre todos los elementos de una tabla con índice entero 1-based, en el orden en que se añadieron."
    evidence:
      locator: "6.3 Table Functions > ALL"
      quote_or_paraphrase: "Used in FOR loops to iterate over all items in a table (that have a 1-based integer index), in the order they were added."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.all.claim.2"
    statement: "El manual muestra T={11,12,13}, ADD(T,14), ADD(T,'HI'); FOR V IN ALL(T) DO PRINT(V) END imprime 11 12 13 14 HI y PRINT(#T) devuelve 5."
    evidence:
      locator: "6.3 Table Functions > ALL"
      quote_or_paraphrase: "T = {11,12,13}; ADD(T,14); ADD(T,'HI'); FOR V IN ALL(T) DO PRINT(V) END -- 11 12 13 14 HI; PRINT(#T) -- 5"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.all.claim.3"
    statement: "ALL, como el resto de funciones de tabla salvo PAIRS(), sólo se aplica a tablas indexadas desde 1 y sin entradas NIL."
    evidence:
      locator: "6.3 Table Functions"
      quote_or_paraphrase: "With the exception of PAIRS(), the following functions and the # operator apply only to tables that are indexed starting from 1 and do not have NIL entries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
all(tbl)
```

## Semántica

Iterador de tabla usado en `for ... in all(tbl) do` que recorre los elementos con índice entero desde 1, en el orden de inserción.

## Parámetros y retorno

- `tbl`: tabla de estilo array (índices enteros desde 1, sin entradas NIL).
- Retorno: iterador que produce los elementos en orden de inserción.

## Efectos y límites

A diferencia de `pairs()`, el orden está garantizado (orden de adición) pero sólo cubre índices 1-based. NO debe usarse con tablas hash o con entradas NIL.

## Ejemplos relacionados

```lua
t = {11,12,13}
add(t,14)
add(t,"HI")
for v in all(t) do print(v) end -- 11 12 13 14 HI
print(#t) -- 5
```

## Ambigüedades

Ninguna documentada.
