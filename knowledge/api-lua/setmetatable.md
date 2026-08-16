---
schema_version: "1.0"
id: "pico8.api.setmetatable"
kind: "api"
title: "SETMETATABLE"
summary: "Fija la metatabla M de la tabla TBL, permitiendo definir el comportamiento bajo operaciones (p. ej. __add)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "SETMETATABLE"
relationships:
  - type: "related"
    target: "pico8.api.getmetatable"
  - type: "related"
    target: "pico8.api.rawget"
  - type: "related"
    target: "pico8.api.rawset"
claims:
  - id: "pico8.api.setmetatable.claim.1"
    statement: "SETMETATABLE(TBL, M) fija la metatabla de TBL a M."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "SETMETATABLE(TBL, M) -- Set table TBL metatable to M"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.setmetatable.claim.2"
    statement: "Las metatablas pueden definir el comportamiento de objetos bajo operaciones particulares; por ejemplo, definir \"__add\" en la metatabla redefine el operador '+'."
    evidence:
      locator: "6.14 Additional Lua Features > Metatables"
      quote_or_paraphrase: "Metatables can be used to define the behaviour of objects under particular operations. For example, to use tables to represent 2D vectors that can be added together, the '+' operator is redefined by defining an \"__add\" function for the metatable"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
setmetatable(tbl, m)
```

## Semántica

Asigna la metatabla `m` a la tabla `tbl`. Las metatablas son una característica de Lua 5.2 expuesta por PICO-8 para usuarios avanzados.

## Parámetros y retorno

- `tbl`: tabla sobre la que se fija la metatabla.
- `m`: metatabla (tabla de metamétodos).
- Retorno: no especificado por la fuente.

## Efectos y límites

- Define operadores y comportamiento como `__add`, que se activan al usar el operador sobre la tabla.

## Ejemplos relacionados

```lua
vec2d = {__add=function(a,b) return {x=a.x+b.x, y=a.y+b.y} end}
v1 = {x=2,y=9} setmetatable(v1, vec2d)
```

## Ambigüedades

Ninguna documentada.
