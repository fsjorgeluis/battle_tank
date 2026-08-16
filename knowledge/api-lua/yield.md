---
schema_version: "1.0"
id: "pico8.api.yield"
kind: "api"
title: "YIELD"
summary: "Suspende la ejecución de una corrutina y devuelve el control al llamador."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "YIELD"
relationships:
  - type: "related"
    target: "pico8.api.cocreate"
  - type: "related"
    target: "pico8.api.coresume"
claims:
  - id: "pico8.api.yield.claim.1"
    statement: "Una función puede llamarse como corrutina, suspenderse con YIELD() cualquier número de veces y reanudarse en el mismo punto."
    evidence:
      locator: "6.14 Additional Lua Features > Coroutines"
      quote_or_paraphrase: "A function can be called as a coroutine, suspended with YIELD() any number of times, and then resumed again at the same points."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.yield.claim.2"
    statement: "YIELD suspende la ejecución y devuelve el control al llamador."
    evidence:
      locator: "6.14 Additional Lua Features > Coroutines"
      quote_or_paraphrase: "YIELD -- Suspend execution and return to the caller."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
yield()
```

## Semántica

Suspende la corrutina actual y devuelve el control al llamador, que podrá reanudarla con `coresume` en el mismo punto.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- Sólo tiene sentido dentro de una corrutina creada con `cocreate` y ejecutada con `coresume`.

## Ejemplos relacionados

En el ejemplo del manual, `hey()` imprime, hace `yield()`, imprime de nuevo y vuelve a hacer `yield()`.

## Ambigüedades

Ninguna documentada.
