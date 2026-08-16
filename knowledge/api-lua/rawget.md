---
schema_version: "1.0"
id: "pico8.api.rawget"
kind: "api"
title: "RAWGET"
summary: "Acceso crudo a la tabla: lee sin invocar metamétodos."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "RAWGET"
relationships:
  - type: "related"
    target: "pico8.api.rawset"
  - type: "related"
    target: "pico8.api.rawlen"
claims:
  - id: "pico8.api.rawget.claim.1"
    statement: "RAWGET(TBL, KEY) accede a la tabla de forma cruda, como si no hubiera metamétodos definidos."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "RAWGET(TBL, KEY) ... Raw access to the table, as if no metamethods were defined."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rawget(tbl, key)
```

## Semántica

Lee el valor de `key` en `tbl` sin invocar metamétodos (por ejemplo, un `__index`).

## Parámetros y retorno

- `tbl`: tabla origen.
- `key`: clave a leer.
- Retorno: el valor de la clave, sin aplicar metamétodos.

## Efectos y límites

- Evita el comportamiento definido por la metatabla al leer.

## Ejemplos relacionados

`rawget(t, "x")` lee la clave sin disparar metamétodos.

## Ambigüedades

Ninguna documentada.
