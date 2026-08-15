---
schema_version: "1.0"
id: "pico8.api.pal"
kind: "api"
title: "PAL"
summary: "Intercambia el color c0 por c1 en uno de los tres re-mapeos de paleta (dibujo, pantalla o secundaria); también acepta una tabla."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "PAL"
relationships:
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.api.fillp"
  - type: "related"
    target: "pico8.api.spr"
  - type: "related"
    target: "pico8.api.color"
claims:
  - id: "pico8.api.pal.claim.1"
    statement: "PAL(c0, c1, [p]) intercambia el color c0 por c1 para uno de los tres re-mapeos de paleta (p por defecto 0)."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "PAL() swaps colour c0 for c1 for one of three palette re-mappings (p defaults to 0)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.2"
    statement: "La paleta 0 (dibujo) re-mapea los colores al dibujarse y no afecta a lo que ya está en pantalla."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "0: Draw Palette ... Changing the draw palette does not affect anything that was already drawn to the screen."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.3"
    statement: "La paleta 1 (pantalla) re-mapea toda la pantalla cuando se muestra al final del frame; útil para efectos de pantalla completa como fundidos."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "1: Display Palette ... re-maps the whole screen when it is displayed at the end of a frame. ... useful for screen-wide effects such as fading in/out."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.4"
    statement: "La paleta 2 (secundaria), usada por FILLP() para dibujar sprites, mapea un único índice de color de 4 bits a dos índices de color de 4 bits."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "2: Secondary Palette ... This provides a mapping from a single 4-bit colour index to two 4-bit colour indexes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.5"
    statement: "PAL() restablece todas las paletas a los valores por defecto del sistema, incluyendo valores de transparencia; PAL(p) restablece una paleta concreta (0..2)."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "PAL() resets all palettes to system defaults (including transparency values) / PAL(P) resets a particular palette (0..2) to system defaults"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.6"
    statement: "PAL(tbl, [p]) asigna colores según cada entrada de la tabla."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "When the first parameter of pal is a table, colours are assigned for each entry."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pal.claim.7"
    statement: "Como los índices de tabla empiezan en 1, en ese caso el color 0 se da al final."
    evidence:
      locator: "6.2 Graphics > PAL"
      quote_or_paraphrase: "Because table indexes start at 1, colour 0 is given at the end in this case."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
pal(c0, c1, [p])
pal(tbl, [p])
pal()
pal(p)
```

## Semántica

Re-mapea colores en una de las tres paletas: dibujo (0), pantalla (1) o secundaria (2). Con tabla, asigna colores por entrada; sin argumentos restablece todas las paletas.

## Parámetros y retorno

- `c0`, `c1`: índice de color origen y destino del intercambio.
- `p` (opcional, por defecto 0): paleta a re-mapear (0..2).
- `tbl`: tabla que asigna índices de color (clave) a colores (valor); los valores pueden empaquetar dos colores de 4 bits.
- Retorno: no especificado por la fuente.

## Efectos y límites

La paleta de dibujo no afecta a lo ya dibujado; la de pantalla sí. La paleta secundaria alimenta el patrón de relleno aplicado a sprites (ver `pico8.api.fillp`). `pal()` restablece también la transparencia.

## Ejemplos relacionados

El manual muestra `PAL(9,8)` seguido de `SPR(1,70,60)` para dibujar un sprite con naranjas como rojas, y `PAL({[12]=9, [14]=8})` para re-mapear dos colores a rojo.

## Ambigüedades

Ninguna documentada.
