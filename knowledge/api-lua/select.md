---
schema_version: "1.0"
id: "pico8.api.select"
kind: "api"
title: "SELECT"
summary: "Función Lua para argumentos variables: select(index, ...) devuelve todos los argumentos después de index; select('#', ...) cuenta los argumentos."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.14 Additional Lua Features"
    anchor: "Function Arguments"
relationships: []
claims:
  - id: "pico8.api.select.claim.1"
    statement: "La lista de argumentos de una función puede especificarse con '...'."
    evidence:
      locator: "6.14 Additional Lua Features > Function Arguments"
      quote_or_paraphrase: "The list of function arguments can be specifed with ..."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.select.claim.2"
    statement: "select(index, ...) devuelve todos los argumentos después de index."
    evidence:
      locator: "6.14 Additional Lua Features > Function Arguments"
      quote_or_paraphrase: "select(index, ...) returns all of the arguments after index."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.select.claim.3"
    statement: "select('#', ...) es una forma alternativa de contar el número de argumentos."
    evidence:
      locator: "6.14 Additional Lua Features > Function Arguments"
      quote_or_paraphrase: "?SELECT(\"#\",...)  -- ALTERNATIVE WAY TO COUNT THE NUMBER OF ARGUMENTS"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
select(index, ...)
```

## Semántica

Trabaja con la lista de argumentos variables de una función. Devuelve los argumentos desde `index` en adelante, o el número de argumentos cuando `index` es `"#"`.

## Parámetros y retorno

- `index`: posición de inicio, o `"#"` para contar.
- `...`: lista de argumentos variables.
- Retorno: todos los argumentos después de `index`, o el número de argumentos con `"#"`.

## Efectos y límites

- Es una característica de Lua 5.2; el manual remite al manual de Lua 5.2 para más información.

## Ejemplos relacionados

```lua
function foo(...)
  local args = {...}
  foreach(args, print)
  ?select("#", ...)
  foo2(select(3, ...))
end
```

## Ambigüedades

Ninguna documentada.
