---
schema_version: "1.0"
id: "pico8.api.chr"
kind: "api"
title: "CHR"
summary: "Convierte uno o más códigos de carácter ordinal a un string."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "CHR"
relationships:
  - type: "related-api"
    target: "pico8.api.ord"
  - type: "related-api"
    target: "pico8.api.tostr"
claims:
  - id: "pico8.api.chr.claim.1"
    statement: "CHR(VAL0, VAL1, ...) convierte uno o más códigos de carácter ordinal a un string."
    evidence:
      locator: "6.10 Strings and Type Conversion > CHR"
      quote_or_paraphrase: "Convert one or more ordinal character codes to a string."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.chr.claim.2"
    statement: "CHR(64) devuelve '@' y CHR(104,101,108,108,111) devuelve 'hello'."
    evidence:
      locator: "6.10 Strings and Type Conversion > CHR"
      quote_or_paraphrase: "CHR(64) -- '@'; CHR(104,101,108,108,111) -- 'hello'"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
chr(val0, val1, ...)
```

## Semántica

Convierte uno o más códigos ordinales de carácter a su representación como string, concatenados.

## Parámetros y retorno

- `val0, val1, ...`: códigos ordinales de carácter.
- Retorno: el string formado por los caracteres correspondientes.

## Efectos y límites

Es la operación inversa de `ord()`.

## Ejemplos relacionados

```lua
chr(64)                -- "@"
chr(104,101,108,108,111) -- "hello"
```

## Ambigüedades

Ninguna documentada.
