---
schema_version: "1.0"
id: "pico8.api.map"
kind: "api"
title: "MAP"
summary: "Dibuja una sección del mapa en pantalla, con tamaño de sección, capas y soporte de cámara."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
    anchor: "MAP"
relationships:
  - type: "related"
    target: "pico8.api.camera"
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.api.tline"
  - type: "related"
    target: "pico8.api.mget"
  - type: "related"
    target: "pico8.api.mset"
  - type: "related"
    target: "pico8.api.fget"
  - type: "related"
    target: "pico8.constraint.map-size"
  - type: "related"
    target: "pico8.constraint.map-shared-size"
claims:
  - id: "pico8.api.map.claim.1"
    statement: "MAP(TILE_X, TILE_Y, [SX, SY], [TILE_W, TILE_H], [LAYERS]) dibuja la sección del mapa (desde TILE_X, TILE_Y) en la posición de pantalla SX, SY (en píxeles)."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "Draw section of map (starting from TILE_X, TILE_Y) at screen position SX, SY (pixels)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.map.claim.2"
    statement: "TILE_W y TILE_H por defecto cubren todo el mapa, incluido el espacio compartido cuando aplica."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "TILE_W and TILE_H default to the entire map (including shared space when applicable)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.map.claim.3"
    statement: "LAYERS es un bitfield: cuando se da, sólo se dibujan los sprites con flags coincidentes. Por ejemplo, LAYERS 0x5 dibuja sólo los sprites con flag 0 y 2."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "LAYERS is a bitfield. When given, only sprites with matching sprite flags are drawn. For example, when LAYERS is 0x5, only sprites with flag 0 and 2 are drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.map.claim.4"
    statement: "El sprite 0 se considera 'vacío' y no se dibuja; el comportamiento se desactiva con POKE(0x5F36, 0x8)."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "Sprite 0 is taken to mean \"empty\" and is not drawn. To disable this behaviour, use: POKE(0x5F36, 0x8)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.map.claim.5"
    statement: "MAP() suele usarse con CAMERA(); el manual muestra CAMERA(PL.X - 64, PL.Y - 64) seguido de MAP() para centrar un objeto del jugador."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "MAP() is often used in conjunction with CAMERA(). To draw the map so that a player object (at PL.X in PL.Y in pixels) is centered: CAMERA(PL.X - 64, PL.Y - 64); MAP()"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.map.claim.6"
    statement: "El manual muestra MAP(0, 0, 20, 20, 4, 2) para dibujar 4x2 bloques de tiles desde 0,0 del mapa a la pantalla en 20,20."
    evidence:
      locator: "6.6 Map > MAP"
      quote_or_paraphrase: "To draw a 4x2 blocks of tiles starting from 0,0 in the map, to the screen at 20,20: MAP(0, 0, 20, 20, 4, 2)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
map(tile_x, tile_y, [sx, sy], [tile_w, tile_h], [layers])
```

## Semántica

Dibuja en pantalla una sección rectangular de la cuadrícula del mapa a partir de `(tile_x, tile_y)`, colocada en `(sx, sy)` en píxeles. Sin argumentos, dibuja el mapa completo, normalmente en combinación con `camera`.

## Parámetros y retorno

- `tile_x`, `tile_y`: esquina inicial de la sección en tiles.
- `sx`, `sy` (opcionales): posición en pantalla en píxeles.
- `tile_w`, `tile_h` (opcionales): ancho y alto de la sección en tiles; por defecto todo el mapa (incluido el espacio compartido).
- `layers` (opcional): bitfield de flags de sprite que filtra qué sprites se dibujan.
- Retorno: no especificado por la fuente.

## Efectos y límites

La transparencia por índice de color se observa según `palt` (fase gráficos). El sprite 0 se trata como vacío salvo `POKE(0x5F36, 0x8)`. El tamaño por defecto del mapa es de 128x32 tiles (128x64 con memoria compartida). Los flags de sprite se usan también con `fget`/`fset`.

## Ejemplos relacionados

- `CAMERA(PL.X - 64, PL.Y - 64)` seguido de `MAP()` centra el objeto del jugador.
- `MAP(0, 0, 20, 20, 4, 2)` dibuja un bloque de 4x2 tiles desde (0,0) del mapa en la posición (20,20) de pantalla.

## Ambigüedades

Ninguna documentada.
