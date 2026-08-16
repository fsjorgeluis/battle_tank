---
schema_version: "1.0"
id: "pico8.api.tonum"
kind: "api"
title: "TONUM"
summary: "Convierte VAL a número; FORMAT_FLAGS controla lectura hexadecimal y entero de 32 bits."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "TONUM"
relationships:
  - type: "related-api"
    target: "pico8.api.tostr"
claims:
  - id: "pico8.api.tonum.claim.1"
    statement: "TONUM(VAL, [FORMAT_FLAGS]) convierte VAL a un número."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "Converts VAL to a number."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.2"
    statement: "TONUM('17.5') devuelve 17.5 y TONUM(17.5) devuelve 17.5."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "TONUM('17.5') -- 17.5; TONUM(17.5) -- 17.5"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.3"
    statement: "TONUM('HOGE') no devuelve valor."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "TONUM('HOGE') -- NO RETURN VALUE"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.4"
    statement: "FORMAT_FLAGS 0x1 lee el string como hexadecimal entero sin signo sin prefijo '0x'; los caracteres no hexadecimales se toman como '0'."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "0x1: Read the string as written in (unsigned, integer) hexadecimal without the '0x' prefix. Non-hexadecimal characters are taken to be '0'."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.5"
    statement: "FORMAT_FLAGS 0x2 lee el string como entero con signo de 32 bits y lo desplaza 16 bits a la derecha."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "0x2: Read the string as a signed 32-bit integer, and shift right 16 bits."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.6"
    statement: "FORMAT_FLAGS 0x4: cuando VAL no puede convertirse a número, devuelve 0."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "0x4: When VAL can not be converted to a number, return 0"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.7"
    statement: "Ejemplos: TONUM('FF',0x1) -- 255; TONUM('1114112',0x2) -- 17; TONUM('1234abcd',0x3) -- 0x1234.abcd."
    evidence:
      locator: "6.10 Strings and Type Conversion > TONUM"
      quote_or_paraphrase: "TONUM('FF', 0x1) -- 255; TONUM('1114112', 0x2) -- 17; TONUM('1234abcd', 0x3) -- 0x1234.abcd"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tonum.claim.8"
    statement: "En expresiones aritméticas, los strings se convierten a números: PRINT(2+'3') --> 5."
    evidence:
      locator: "6.10 Strings and Type Conversion"
      quote_or_paraphrase: "When used as part of an arithmetic expression, string values are converted to numbers: >PRINT(2+'3') --> 5"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
tonum(val, [format_flags])
```

## Semántica

Convierte `val` a número. Con `format_flags`, interpreta el string como hexadecimal (0x1), entero de 32 bits desplazado (0x2) o devuelve 0 si no es convertible (0x4).

## Parámetros y retorno

- `val`: valor a convertir (string o número).
- `format_flags` (opcional): bitfield de interpretación.
- Retorno: el número resultante; sin conversión posible devuelve nada (salvo con flag 0x4, que devuelve 0).

## Efectos y límites

La conversión implícita en aritmética (p. ej. `2+"3"`) sigue la misma regla.

## Ejemplos relacionados

```lua
tonum("17.5")    -- 17.5
tonum("FF", 0x1) -- 255
tonum("1114112", 0x2) -- 17
tonum("1234abcd", 0x3) -- 0x1234.abcd
```

## Ambigüedades

Ninguna documentada.
