---
schema_version: "1.0"
id: "pico8.api.rawequal"
kind: "api"
title: "RAWEQUAL"
summary: "Comparación cruda de tablas sin invocar metamétodos (__eq)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "RAWEQUAL"
relationships:
  - type: "related"
    target: "pico8.api.getmetatable"
  - type: "related"
    target: "pico8.api.rawget"
claims:
  - id: "pico8.api.rawequal.claim.1"
    statement: "RAWEQUAL(TBL1, TBL2) compara las tablas de forma cruda, como si no hubiera metamétodos definidos."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "RAWEQUAL(TBL1,TBL2) ... Raw access to the table, as if no metamethods were defined."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
rawequal(tbl1, tbl2)
```

## Semántica

Compara `tbl1` y `tbl2` sin invocar el metamétodo `__eq`.

## Parámetros y retorno

- `tbl1`, `tbl2`: tablas a comparar.
- Retorno: booleano; la fuente no detalla el valor exacto para tablas distintas más allá de la comparación cruda.

## Efectos y límites

- Evita el comportamiento definido por la metatabla al comparar.

## Ejemplos relacionados

`rawequal(t, t)` y el uso de `__eq` se evitan con esta llamada cruda.

## Ambigüedades

La firma de la fuente aparece como `RAWEQUAL(TBL1,TBL2` sin paréntesis de cierre (errata de ancla HTML); se normaliza como `rawequal(tbl1, tbl2)` sin cambio de contrato.
