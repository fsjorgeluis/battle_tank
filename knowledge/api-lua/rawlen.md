---
schema_version: "1.0"
id: "pico8.api.rawlen"
kind: "api"
title: "RAWLEN"
summary: "Longitud cruda de la tabla sin invocar metamétodos (__len)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "RAWLEN"
relationships:
  - type: "related"
    target: "pico8.api.rawget"
  - type: "related"
    target: "pico8.api.count"
claims:
  - id: "pico8.api.rawlen.claim.1"
    statement: "RAWLEN(TBL) obtiene la longitud de la tabla de forma cruda, como si no hubiera metamétodos definidos."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "RAWLEN(TBL) ... Raw access to the table, as if no metamethods were defined."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rawlen(tbl)
```

## Semántica

Devuelve la longitud de `tbl` sin invocar el metamétodo `__len`.

## Parámetros y retorno

- `tbl`: tabla a medir.
- Retorno: longitud cruda de la tabla.

## Efectos y límites

- Evita el comportamiento definido por la metatabla al medir la longitud.

## Ejemplos relacionados

`rawlen(t)` evita un `__len` definido en la metatabla.

## Ambigüedades

Ninguna documentada.
