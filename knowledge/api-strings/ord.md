---
schema_version: "1.0"
id: "pico8.api.ord"
kind: "api"
title: "ORD"
summary: "Convierte caracteres de STR a sus códigos ordinales (0..255)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "ORD"
relationships:
  - type: "related-api"
    target: "pico8.api.chr"
  - type: "related-api"
    target: "pico8.api.sub"
claims:
  - id: "pico8.api.ord.claim.1"
    statement: "ORD(STR, [INDEX], [NUM_RESULTS]) convierte uno o más caracteres de STR a sus códigos ordinales (0..255)."
    evidence:
      locator: "6.10 Strings and Type Conversion > ORD"
      quote_or_paraphrase: "Convert one or more characters from string STR to their ordinal (0..255) character codes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ord.claim.2"
    statement: "El parámetro INDEX especifica qué carácter del string usar."
    evidence:
      locator: "6.10 Strings and Type Conversion > ORD"
      quote_or_paraphrase: "Use the INDEX parameter to specify which character in the string to use."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ord.claim.3"
    statement: "Cuando INDEX está fuera de rango o STR no es un string, ORD devuelve nil."
    evidence:
      locator: "6.10 Strings and Type Conversion > ORD"
      quote_or_paraphrase: "When INDEX is out of range or str is not a string, ORD returns nil."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ord.claim.4"
    statement: "Cuando se da NUM_RESULTS, ORD devuelve múltiples valores a partir de INDEX."
    evidence:
      locator: "6.10 Strings and Type Conversion > ORD"
      quote_or_paraphrase: "When NUM_RESULTS is given, ORD returns multiple values starting from INDEX."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ord.claim.5"
    statement: "Ejemplos: ORD('@') -- 64; ORD('123',2) -- 50; ORD('123',2,3) -- 50,51,52."
    evidence:
      locator: "6.10 Strings and Type Conversion > ORD"
      quote_or_paraphrase: "ORD('@') -- 64; ORD('123',2) -- 50 (THE SECOND CHARACTER: '2'); ORD('123',2,3) -- 50,51,52"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
ord(str, [index], [num_results])
```

## Semántica

Convierte caracteres del string `str` a sus códigos ordinales. Opcionalmente selecciona posición y número de resultados.

## Parámetros y retorno

- `str`: string de entrada.
- `index` (opcional): posición del carácter a convertir.
- `num_results` (opcional): número de valores a devolver a partir de `index`.
- Retorno: código ordinal (0..255), o varios, o `nil` cuando `index` está fuera de rango o `str` no es un string.

## Efectos y límites

Es la operación inversa de `chr()`.

## Ejemplos relacionados

```lua
ord("@")       -- 64
ord("123",2)   -- 50
ord("123",2,3) -- 50,51,52
```

## Ambigüedades

Ninguna documentada.
