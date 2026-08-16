---
schema_version: "1.0"
id: "pico8.api.getmetatable"
kind: "api"
title: "GETMETATABLE"
summary: "Devuelve la metatabla actual de una tabla, o nil si no tiene ninguna."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "GETMETATABLE"
relationships:
  - type: "related"
    target: "pico8.api.setmetatable"
  - type: "related"
    target: "pico8.api.rawequal"
claims:
  - id: "pico8.api.getmetatable.claim.1"
    statement: "GETMETATABLE(TBL) devuelve la metatabla actual de la tabla t, o nil si no hay ninguna."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "GETMETATABLE(TBL) -- return the current metatable for table t, or nil if none is set"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
getmetatable(tbl)
```

## Semántica

Consulta la metatabla asociada a `tbl`.

## Parámetros y retorno

- `tbl`: tabla a consultar.
- Retorno: metatabla actual, o `nil` si no hay ninguna.

## Efectos y límites

- Es la operación inversa de `SETMETATABLE`.

## Ejemplos relacionados

`getmetatable(v1)` devuelve `vec2d` tras `setmetatable(v1, vec2d)`.

## Ambigüedades

Ninguna documentada.
