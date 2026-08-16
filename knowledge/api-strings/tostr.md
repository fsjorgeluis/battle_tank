---
schema_version: "1.0"
id: "pico8.api.tostr"
kind: "api"
title: "TOSTR"
summary: "Convierte VAL a string; FORMAT_FLAGS controla formato hexadecimal y entero de 32 bits."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "TOSTR"
relationships:
  - type: "related-api"
    target: "pico8.api.tonum"
  - type: "related-api"
    target: "pico8.api.chr"
  - type: "related-api"
    target: "pico8.api.type"
claims:
  - id: "pico8.api.tostr.claim.1"
    statement: "TOSTR(VAL, [FORMAT_FLAGS]) convierte VAL a un string."
    evidence:
      locator: "6.10 Strings and Type Conversion > TOSTR"
      quote_or_paraphrase: "Convert VAL to a string."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tostr.claim.2"
    statement: "FORMAT_FLAGS 0x1 escribe el valor hexadecimal crudo de números, funciones o tablas."
    evidence:
      locator: "6.10 Strings and Type Conversion > TOSTR"
      quote_or_paraphrase: "0x1: Write the raw hexadecimal value of numbers, functions or tables."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tostr.claim.3"
    statement: "FORMAT_FLAGS 0x2 escribe VAL como entero con signo de 32 bits desplazado 16 bits a la izquierda."
    evidence:
      locator: "6.10 Strings and Type Conversion > TOSTR"
      quote_or_paraphrase: "0x2: Write VAL as a signed 32-bit integer by shifting it left by 16 bits."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tostr.claim.4"
    statement: "TOSTR(NIL) devuelve '[nil]' y TOSTR() devuelve ''."
    evidence:
      locator: "6.10 Strings and Type Conversion > TOSTR"
      quote_or_paraphrase: "TOSTR(NIL) returns '[nil]'; TOSTR() returns ''"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tostr.claim.5"
    statement: "Ejemplos: TOSTR(17) -- '17'; TOSTR(17,0x1) -- '0x0011.0000'; TOSTR(17,0x3) -- '0x00110000'; TOSTR(17,0x2) -- '1114112'."
    evidence:
      locator: "6.10 Strings and Type Conversion > TOSTR"
      quote_or_paraphrase: "TOSTR(17) -- '17'; TOSTR(17,0x1) -- '0x0011.0000'; TOSTR(17,0x3) -- '0x00110000'; TOSTR(17,0x2) -- '1114112'"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tostr.claim.6"
    statement: "El operador .. une strings y, al unir números, los convierte a strings: PRINT('THREE '..4) --> 'THREE 4'."
    evidence:
      locator: "6.10 Strings and Type Conversion"
      quote_or_paraphrase: "Strings can be joined using the .. operator. Joining numbers converts them to strings. >PRINT('THREE '..4) --> 'THREE 4'"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
tostr(val, [format_flags])
```

## Semántica

Convierte `val` a su representación como string. Con `format_flags`, ajusta el formato de salida mediante un bitfield.

## Parámetros y retorno

- `val`: valor a convertir (número, función, tabla o NIL).
- `format_flags` (opcional): bitfield; `0x1` = hexadecimal crudo, `0x2` = entero con signo de 32 bits desplazado 16 bits a la izquierda.
- Retorno: el string resultante; `tostr(nil)` devuelve `"[nil]"` y `tostr()` devuelve `""`.

## Efectos y límites

El operador `..` usa la misma conversión a string al concatenar números.

## Ejemplos relacionados

```lua
tostr(17)      -- "17"
tostr(17, 0x1) -- "0x0011.0000"
tostr(17, 0x3) -- "0x00110000"
tostr(17, 0x2) -- "1114112"
print("THREE "..4) -- "THREE 4"
```

## Ambigüedades

Ninguna documentada.
