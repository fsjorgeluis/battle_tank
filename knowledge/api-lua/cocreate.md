---
schema_version: "1.0"
id: "pico8.api.cocreate"
kind: "api"
title: "COCREATE"
summary: "Crea una corrutina para una función; permite ejecución semi-concurrente con yield/coresume."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "COCREATE"
relationships:
  - type: "related"
    target: "pico8.api.coresume"
  - type: "related"
    target: "pico8.api.costatus"
  - type: "related"
    target: "pico8.api.yield"
claims:
  - id: "pico8.api.cocreate.claim.1"
    statement: "Las corrutinas permiten ejecutar distintas partes de un programa de forma semi-concurrente, similar a los hilos."
    evidence:
      locator: "6.14 Additional Lua Features > Coroutines"
      quote_or_paraphrase: "Coroutines offer a way to run different parts of a program in a somewhat concurrent way, similar to threads."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cocreate.claim.2"
    statement: "COCREATE(F) crea una corrutina para la función f."
    evidence:
      locator: "6.14 Additional Lua Features > Coroutines"
      quote_or_paraphrase: "COCREATE(F) -- Create a coroutine for function f."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cocreate(f)
```

## Semántica

Crea una corrutina a partir de la función `f`. La corrutina puede suspenderse con `yield` y reanudarse con `coresume`.

## Parámetros y retorno

- `f`: función que se ejecutará como corrutina.
- Retorno: la corrutina creada.

## Efectos y límites

- La función puede suspenderse con `YIELD()` cualquier número de veces y reanudarse en el mismo punto.

## Ejemplos relacionados

`c = cocreate(hey)` seguido de `for i=1,3 do coresume(c) end` en el ejemplo del manual.

## Ambigüedades

Ninguna documentada.
