---
schema_version: "1.0"
id: "pico8.api.split"
kind: "api"
title: "SPLIT"
summary: "Divide STR en una tabla de elementos delimitados por SEPARATOR (por defecto ',')."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.10 Strings and Type Conversion"
    anchor: "SPLIT"
relationships:
  - type: "related-api"
    target: "pico8.api.sub"
  - type: "related-api"
    target: "pico8.api.tonum"
  - type: "related-api"
    target: "pico8.api.add"
claims:
  - id: "pico8.api.split.claim.1"
    statement: "SPLIT(STR, [SEPARATOR], [CONVERT_NUMBERS]) divide un string en una tabla de elementos delimitados por el separador dado (por defecto ',')."
    evidence:
      locator: "6.10 Strings and Type Conversion > SPLIT"
      quote_or_paraphrase: "Split a string into a table of elements delimited by the given separator (defaults to ',')."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.split.claim.2"
    statement: "Cuando el separador es un número n, el string se divide en grupos de n caracteres."
    evidence:
      locator: "6.10 Strings and Type Conversion > SPLIT"
      quote_or_paraphrase: "When separator is a number n, the string is split into n-character groups."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.split.claim.3"
    statement: "Con convert_numbers true (por defecto), los tokens numéricos se almacenan como números."
    evidence:
      locator: "6.10 Strings and Type Conversion > SPLIT"
      quote_or_paraphrase: "When convert_numbers is true, numerical tokens are stored as numbers (defaults to true)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.split.claim.4"
    statement: "Los elementos vacíos se almacenan como strings vacíos."
    evidence:
      locator: "6.10 Strings and Type Conversion > SPLIT"
      quote_or_paraphrase: "Empty elements are stored as empty strings."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.split.claim.5"
    statement: "Ejemplos: SPLIT('1,2,3') -- {1,2,3}; SPLIT('ONE:TWO:3',':',FALSE) -- {'ONE','TWO','3'}; SPLIT('1,,2,') -- {1,'',2,''}."
    evidence:
      locator: "6.10 Strings and Type Conversion > SPLIT"
      quote_or_paraphrase: "SPLIT('1,2,3') -- {1,2,3}; SPLIT('ONE:TWO:3',':',FALSE) -- {'ONE','TWO','3'}; SPLIT('1,,2,') -- {1,'',2,''}"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
split(str, [separator], [convert_numbers])
```

## Semántica

Divide `str` en una tabla de elementos usando `separator` como delimitador. Con separador numérico, divide en grupos de caracteres de ese tamaño.

## Parámetros y retorno

- `str`: string de entrada.
- `separator` (opcional): delimitador (string, por defecto `","`) o número de caracteres por grupo.
- `convert_numbers` (opcional): si es true (por defecto), los tokens numéricos se convierten a números.
- Retorno: tabla de elementos; los vacíos se conservan como strings vacíos.

## Efectos y límites

Los elementos vacíos no se descartan.

## Ejemplos relacionados

```lua
split("1,2,3")               -- {1,2,3}
split("ONE:TWO:3",":",false) -- {"ONE","TWO","3"}
split("1,,2,")               -- {1,"",2,""}
```

## Ambigüedades

Ninguna documentada.
