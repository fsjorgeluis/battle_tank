---
schema_version: "1.0"
id: "pico8.api.mget"
kind: "api"
title: "MGET"
summary: "Obtiene el valor del mapa (VAL) en la posición X,Y de la cuadrícula."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
    anchor: "MGET"
relationships:
  - type: "related"
    target: "pico8.api.mset"
  - type: "related"
    target: "pico8.api.map"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.constraint.map-cell-width"
claims:
  - id: "pico8.api.mget.claim.1"
    statement: "MGET(X, Y) obtiene el valor (VAL) del mapa en la posición X,Y."
    evidence:
      locator: "6.6 Map > MGET"
      quote_or_paraphrase: "Get or set map value (VAL) at X,Y"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.mget.claim.2"
    statement: "Cuando X e Y están fuera de rango, MGET devuelve 0, o un valor personalizado especificado con POKE(0x5f36, 0x10) y POKE(0x5f5a, NEWVAL)."
    evidence:
      locator: "6.6 Map > MGET"
      quote_or_paraphrase: "When X and Y are out of bounds, MGET returns 0, or a custom return value that can be specified with POKE(0x5f36, 0x10) POKE(0x5f5a, NEWVAL)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.mget.claim.3"
    statement: "En el editor de mapa, el significado de cada valor se toma como un índice a la hoja de sprites (0..255); el mapa también puede usarse como un bloque general de datos."
    evidence:
      locator: "6.6 Map"
      quote_or_paraphrase: "When using the map editor, the meaning of each value is taken to be an index into the sprite sheet (0..255). However, it can instead be used as a general block of data."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
mget(x, y)
```

## Semántica

Lee el valor de 8 bits almacenado en la celda (x, y) de la cuadrícula del mapa. La cuadrícula por defecto es de 128x32 tiles (128x64 con memoria compartida); fuera de rango devuelve 0 salvo configuración contraria.

## Parámetros y retorno

- `x`, `y`: coordenadas de la celda en tiles.
- Retorno: valor de la celda; en el editor, un índice de sprite 0..255, pero puede ser un dato arbitrario.

## Efectos y límites

El valor devuelto fuera de rango se configura con dos POKE: `POKE(0x5f36, 0x10)` habilita el valor personalizado y `POKE(0x5f5a, NEWVAL)` lo fija. El registro `0x5f36` es un bitfield de estado de dibujo compartido con otras APIs (ver Ambigüedades).

## Ejemplos relacionados

El manual usa el patrón `POKE(0x5f36, 0x10)` junto con `POKE(0x5f5a, NEWVAL)` para que MGET devuelva un valor personalizado en fuera de rango.

## Ambigüedades

- Nota de dominio cruzado: el registro `0x5f36` también configura el valor fuera de rango de PGET (`0x5f5b`, sección 6.2) y SGET (`0x5f59`, sección 6.2) y el scroll del texto de PRINT (`0x40`, sección 6.14); cada dominio documenta sus propios bits y se registra el cruce en el índice.
