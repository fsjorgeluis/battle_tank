---
schema_version: "1.0"
id: "pico8.api.costatus"
kind: "api"
title: "COSTATUS"
summary: "Devuelve el estado de una corrutina como string: 'running', 'suspended' o 'dead'."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "COSTATUS"
relationships:
  - type: "related"
    target: "pico8.api.cocreate"
  - type: "related"
    target: "pico8.api.coresume"
claims:
  - id: "pico8.api.costatus.claim.1"
    statement: "COSTATUS(C) devuelve el estado de la corrutina C como string: 'running', 'suspended' o 'dead'."
    evidence:
      locator: "6.14 Additional Lua Features > Coroutines"
      quote_or_paraphrase: "COSTATUS(C) -- Return the status of coroutine C as a string: \"running\" \"suspended\" \"dead\""
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
costatus(c)
```

## Semántica

Consulta el estado de una corrutina.

## Parámetros y retorno

- `c`: corrutina a consultar.
- Retorno: `"running"`, `"suspended"` o `"dead"`.

## Efectos y límites

- Los tres estados posibles son los enumerados por la fuente.

## Ejemplos relacionados

`costatus(c)` permite saber si una corrutina ya terminó (`"dead"`) antes de reanudarla.

## Ambigüedades

Ninguna documentada.
