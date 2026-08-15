---
schema_version: "1.0"
id: "pico8.api.sget"
kind: "api"
title: "SGET"
summary: "Devuelve el color de un píxel de la hoja de sprites; fuera de rango devuelve 0 salvo valor personalizado."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "SGET"
relationships:
  - type: "related"
    target: "pico8.api.sset"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.api.sget.claim.1"
    statement: "SGET(x, y) obtiene el color de un píxel de la hoja de sprites."
    evidence:
      locator: "6.2 Graphics > SGET"
      quote_or_paraphrase: "Get or set the colour (COL) of a sprite sheet pixel."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sget.claim.2"
    statement: "Cuando x e y están fuera de rango, SGET devuelve 0; puede especificarse un valor personalizado con POKE(0x5f36, 0x10) y POKE(0x5f59, NEWVAL)."
    evidence:
      locator: "6.2 Graphics > SGET"
      quote_or_paraphrase: "When X and Y are out of bounds, SGET returns 0. A custom value can be specified with: POKE(0x5f36, 0x10) POKE(0x5f59, NEWVAL)"
    classification: "fact"
    confidence: "medium"
---

## Contrato

```lua
sget(x, y)
```

## Semántica

Lee el índice de color de un píxel de la hoja de sprites, el área de 128x128 píxeles que contiene los 256 sprites.

## Parámetros y retorno

- `x`, `y`: coordenadas del píxel de la hoja de sprites.
- Retorno: índice de color; 0 si está fuera de rango, salvo valor personalizado.

## Efectos y límites

Las coordenadas válidas abarcan la hoja completa de 128x128 píxeles. El valor personalizado depende de POKE en 0x5f36 y 0x5f59 (dominio de memoria).

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `sget`.

## Ambigüedades

Ninguna documentada.
