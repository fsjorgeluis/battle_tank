---
schema_version: "1.0"
id: "pico8.api.type"
kind: "api"
title: "TYPE"
summary: "Devuelve el tipo de VAL como string."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "TYPE"
relationships:
  - type: "related-api"
    target: "pico8.api.tostr"
  - type: "related-api"
    target: "pico8.api.tonum"
claims:
  - id: "pico8.api.type.claim.1"
    statement: "TYPE(VAL) devuelve el tipo de VAL como string."
    evidence:
      locator: "6.10 Strings and Type Conversion > TYPE"
      quote_or_paraphrase: "Returns the type of val as a string."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.type.claim.2"
    statement: "Ejemplos: TYPE(3) imprime NUMBER y TYPE('3') imprime STRING."
    evidence:
      locator: "6.10 Strings and Type Conversion > TYPE"
      quote_or_paraphrase: "> PRINT(TYPE(3)) NUMBER; > PRINT(TYPE('3')) STRING"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.type.claim.3"
    statement: "Los literales string se escriben con comillas simples, dobles o corchetes [[ ]] (que permiten múltiples líneas)."
    evidence:
      locator: "6.10 Strings and Type Conversion"
      quote_or_paraphrase: "Strings in Lua are written either in single or double quotes or with matching [[ ]] brackets: S = 'THE QUICK'; S = 'BROWN FOX'; S = [[ JUMPS OVER MULTIPLE LINES ]]"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
type(val)
```

## Semántica

Devuelve una cadena con el tipo de `val` (p. ej. `"NUMBER"`, `"STRING"`).

## Parámetros y retorno

- `val`: valor a inspeccionar.
- Retorno: el tipo de `val` como string.

## Efectos y límites

Los literales de string aceptan comillas simples, dobles o corchetes `[[ ]]` (que permiten saltos de línea).

## Ejemplos relacionados

```lua
print(type(3))  -- NUMBER
print(type("3")) -- STRING
```

## Ambigüedades

Ninguna documentada.
