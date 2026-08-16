---
schema_version: "1.0"
id: "pico8.api.sub"
kind: "api"
title: "SUB"
summary: "Substring de STR desde POS0 hasta POS1 inclusive; con POS1 no numérico, un carácter."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "SUB"
relationships:
  - type: "related-api"
    target: "pico8.api.ord"
  - type: "related-api"
    target: "pico8.api.split"
  - type: "related-api"
    target: "pico8.api.tostr"
claims:
  - id: "pico8.api.sub.claim.1"
    statement: "SUB(STR, POS0, [POS1]) toma un substring de STR desde POS0 hasta POS1 inclusive."
    evidence:
      locator: "6.10 Strings and Type Conversion > SUB"
      quote_or_paraphrase: "Grab a substring from string str, from pos0 up to and including pos1."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sub.claim.2"
    statement: "Cuando POS1 no se especifica, se devuelve el resto de la cadena."
    evidence:
      locator: "6.10 Strings and Type Conversion > SUB"
      quote_or_paraphrase: "When POS1 is not specified, the remainder of the string is returned."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sub.claim.3"
    statement: "Cuando POS1 se especifica pero no es un número, se devuelve un único carácter en POS0."
    evidence:
      locator: "6.10 Strings and Type Conversion > SUB"
      quote_or_paraphrase: "When POS1 is specified, but not a number, a single character at POS0 is returned."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sub.claim.4"
    statement: "El manual muestra S='THE QUICK BROWN FOX'; SUB(S,5,9) --> 'QUICK'; SUB(S,5) --> 'QUICK BROWN FOX'; SUB(S,5,TRUE) --> 'Q'."
    evidence:
      locator: "6.10 Strings and Type Conversion > SUB"
      quote_or_paraphrase: "S = 'THE QUICK BROWN FOX'; PRINT(SUB(S,5,9)) --> 'QUICK'; PRINT(SUB(S,5)) --> 'QUICK BROWN FOX'; PRINT(SUB(S,5,TRUE)) --> 'Q'"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sub.claim.5"
    statement: "La longitud de un string (número de caracteres) se obtiene con el operador #: PRINT(#S)."
    evidence:
      locator: "6.10 Strings and Type Conversion"
      quote_or_paraphrase: "The length of a string (number of characters) can be retrieved using the # operator: >PRINT(#S)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
sub(str, pos0, [pos1])
```

## Semántica

Extrae un substring de `str` desde la posición `pos0` hasta `pos1` inclusive. Sin `pos1`, devuelve el resto de la cadena; con `pos1` no numérico, un único carácter.

## Parámetros y retorno

- `str`: string de entrada.
- `pos0`: posición inicial (basada en 1).
- `pos1` (opcional): posición final inclusive; si no es un número, se devuelve el carácter en `pos0`.
- Retorno: el substring resultante.

## Efectos y límites

Las posiciones de carácter se corresponden con el número de caracteres que devuelve el operador `#`.

## Ejemplos relacionados

```lua
s = "THE QUICK BROWN FOX"
print(sub(s,5,9))    -- "QUICK"
print(sub(s,5))      -- "QUICK BROWN FOX"
print(sub(s,5,true)) -- "Q"
```

## Ambigüedades

Ninguna documentada.
