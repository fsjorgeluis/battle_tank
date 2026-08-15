---
schema_version: "1.0"
id: "pico8.api.color"
kind: "api"
title: "COLOR"
summary: "Fija el color de dibujo actual usado por las funciones de dibujo; sin col restablece el color a 6."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "COLOR"
relationships:
  - type: "related"
    target: "pico8.api.pset"
  - type: "related"
    target: "pico8.api.print"
  - type: "related"
    target: "pico8.api.fillp"
  - type: "related"
    target: "pico8.constraint.palette-color-count"
claims:
  - id: "pico8.api.color.claim.1"
    statement: "COLOR([col]) fija el color actual que usarán las funciones de dibujo."
    evidence:
      locator: "6.2 Graphics > COLOR"
      quote_or_paraphrase: "Set the current colour to be used by drawing functions."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.color.claim.2"
    statement: "Si col no se especifica, el color actual se fija a 6."
    evidence:
      locator: "6.2 Graphics > COLOR"
      quote_or_paraphrase: "If COL is not specified, the current colour is set to 6"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
color([col])
```

## Semántica

Fija el color de dibujo actual que usan las funciones que aceptan un color opcional.

## Parámetros y retorno

- `col` (opcional): índice de color 0..15.
- Retorno: no especificado por la fuente.

## Efectos y límites

`color()` sin argumentos restablece el color a 6 (light gray). El color de dibujo forma parte del estado de dibujo, restablecido al ejecutar el programa o con `RESET()`. Los bits altos de `col` pueden codificar un patrón de relleno (ver `pico8.api.fillp`).

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `color`.

## Ambigüedades

Ninguna documentada.
