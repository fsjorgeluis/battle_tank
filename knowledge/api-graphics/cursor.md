---
schema_version: "1.0"
id: "pico8.api.cursor"
kind: "api"
title: "CURSOR"
summary: "Fija la posición del cursor de texto; con col también fija el color actual."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CURSOR"
relationships:
  - type: "related"
    target: "pico8.api.print"
  - type: "related"
    target: "pico8.api.color"
claims:
  - id: "pico8.api.cursor.claim.1"
    statement: "CURSOR(x, y, [col]) fija la posición del cursor."
    evidence:
      locator: "6.2 Graphics > CURSOR"
      quote_or_paraphrase: "Set the cursor position."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cursor.claim.2"
    statement: "Si se especifica col, también se fija el color actual."
    evidence:
      locator: "6.2 Graphics > CURSOR"
      quote_or_paraphrase: "If COL is specified, also set the current colour."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cursor(x, y, [col])
```

## Semántica

Fija la posición donde se escribirá el siguiente texto, y opcionalmente el color de dibujo.

## Parámetros y retorno

- `x`, `y`: nueva posición del cursor.
- `col` (opcional): si se da, fija también el color actual.
- Retorno: no especificado por la fuente.

## Efectos y límites

Relacionado con `print`, que consume el cursor cuando se llama sin coordenadas.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `cursor`.

## Ambigüedades

Ninguna documentada.
