---
schema_version: "1.0"
id: "pico8.api.rawset"
kind: "api"
title: "RAWSET"
summary: "Acceso crudo a la tabla: escribe sin invocar metamétodos."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "RAWSET"
relationships:
  - type: "related"
    target: "pico8.api.rawget"
  - type: "related"
    target: "pico8.api.setmetatable"
  - type: "related"
    target: "pico8.api.rawlen"
claims:
  - id: "pico8.api.rawset.claim.1"
    statement: "RAWSET(TBL, KEY, VALUE) accede a la tabla de forma cruda, como si no hubiera metamétodos definidos."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "RAWSET(TBL, KEY, VALUE) ... Raw access to the table, as if no metamethods were defined."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rawset(tbl, key, value)
```

## Semántica

Escribe `key`/`value` en `tbl` saltándose los metamétodos (por ejemplo, un `__newindex`).

## Parámetros y retorno

- `tbl`: tabla destino.
- `key`: clave a escribir.
- `value`: valor a asignar.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Evita el comportamiento definido por la metatabla al escribir.

## Ejemplos relacionados

`rawset(t, "x", 1)` escribe la clave sin disparar metamétodos.

## Ambigüedades

Ninguna documentada.
