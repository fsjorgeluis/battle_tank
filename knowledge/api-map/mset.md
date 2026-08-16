---
schema_version: "1.0"
id: "pico8.api.mset"
kind: "api"
title: "MSET"
summary: "Fija el valor (VAL) del mapa en la posición X,Y de la cuadrícula."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
    anchor: "MSET"
relationships:
  - type: "related"
    target: "pico8.api.mget"
  - type: "related"
    target: "pico8.api.map"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.constraint.map-cell-width"
claims:
  - id: "pico8.api.mset.claim.1"
    statement: "MSET(X, Y, VAL) fija el valor (VAL) del mapa en la posición X,Y."
    evidence:
      locator: "6.6 Map > MSET"
      quote_or_paraphrase: "Get or set map value (VAL) at X,Y"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.mset.claim.2"
    statement: "En el editor de mapa, el significado de cada valor se toma como un índice a la hoja de sprites (0..255); el mapa también puede usarse como un bloque general de datos."
    evidence:
      locator: "6.6 Map"
      quote_or_paraphrase: "When using the map editor, the meaning of each value is taken to be an index into the sprite sheet (0..255). However, it can instead be used as a general block of data."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.mset.claim.3"
    statement: "El formato del mapa es un byte por tile, donde cada byte normalmente codifica un índice de sprite."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Map format is one byte per tile, where each byte normally encodes a sprite index."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
mset(x, y, val)
```

## Semántica

Escribe `val` en la celda (x, y) de la cuadrícula del mapa. El valor es un índice de sprite cuando el mapa se usa como tal en el editor, o un dato arbitrario cuando se usa como bloque general de datos.

## Parámetros y retorno

- `x`, `y`: coordenadas de la celda en tiles.
- `val`: valor de 8 bits a escribir (índice de sprite 0..255 o dato arbitrario).
- Retorno: no especificado por la fuente.

## Efectos y límites

Cada celda almacena un byte (8 bits). La escritura modifica la zona MAP de la RAM base (0x2000 por defecto), accesible también vía PEEK/POKE.

## Ejemplos relacionados

Ninguno adicional en el manual.

## Ambigüedades

Ninguna documentada.
