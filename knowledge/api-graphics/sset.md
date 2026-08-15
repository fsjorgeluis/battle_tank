---
schema_version: "1.0"
id: "pico8.api.sset"
kind: "api"
title: "SSET"
summary: "Establece el color de un píxel de la hoja de sprites."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "SSET"
relationships:
  - type: "related"
    target: "pico8.api.sget"
  - type: "related"
    target: "pico8.api.spr"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.api.sset.claim.1"
    statement: "SSET(x, y, [col]) establece el color de un píxel de la hoja de sprites."
    evidence:
      locator: "6.2 Graphics > SSET"
      quote_or_paraphrase: "Get or set the colour (COL) of a sprite sheet pixel."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sset.claim.2"
    statement: "Fuera de rango puede especificarse un valor personalizado con POKE(0x5f36, 0x10) y POKE(0x5f59, NEWVAL)."
    evidence:
      locator: "6.2 Graphics > SSET"
      quote_or_paraphrase: "When X and Y are out of bounds, SGET returns 0. A custom value can be specified with: POKE(0x5f36, 0x10) POKE(0x5f59, NEWVAL)"
    classification: "fact"
    confidence: "medium"
---

## Contrato

```lua
sset(x, y, [col])
```

## Semántica

Escribe un píxel de la hoja de sprites con el índice de color dado. Permite modificar sprites por código, incluyendo el banco compartido con el mapa.

## Parámetros y retorno

- `x`, `y`: coordenadas del píxel de la hoja de sprites.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

Al escribir en la región compartida con los datos de mapa, el contenido del mapa solapado también cambia. La nota sobre valores personalizados fuera de rango pertenece a SGET.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `sset`.

## Ambigüedades

Ninguna documentada.
