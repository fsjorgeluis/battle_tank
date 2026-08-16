---
schema_version: "1.0"
id: "pico8.api.tline"
kind: "api"
title: "TLINE"
summary: "Dibuja una línea texturizada muestreando colores del mapa, con enmascarado y precisión ajustable."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
    anchor: "TLINE"
relationships:
  - type: "related"
    target: "pico8.api.map"
  - type: "related"
    target: "pico8.api.mget"
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.constraint.sprite-size"
  - type: "related"
    target: "pico8.constraint.tline-fraction-bits"
claims:
  - id: "pico8.api.tline.claim.1"
    statement: "TLINE(X0, Y0, X1, Y1, MX, MY, [MDX, MDY], [LAYERS]) dibuja una línea texturizada de (X0,Y0) a (X1,Y1) muestreando valores de color del mapa."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "Draw a textured line from (X0,Y0) to (X1,Y1), sampling colour values from the map."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.2"
    statement: "MX y MY son coordenadas del mapa en tiles; los colores se muestrean del sprite 8x8 presente en cada tile. Por ejemplo, 2.0,1.0 es la esquina superior izquierda del sprite en 2,1 y 2.5,1.5 es el píxel (4,4) del mismo sprite."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "MX, MY are map coordinates to sample from, given in tiles. Colour values are sampled from the 8x8 sprite present at each map tile. 2.0, 1.0 means the top left corner of the sprite at position 2,1 on the map; 2.5, 1.5 means pixel (4,4) of the same sprite."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.3"
    statement: "MDX y MDY son deltas que se suman a mx,my después de cada píxel dibujado; por defecto son 0.125, 0."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "MDX, MDY are deltas added to mx, my after each pixel is drawn. (Defaults to 0.125, 0)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.4"
    statement: "Las coordenadas (MX, MY) se enmascaran con valores calculados restando 0x0.0001 de los valores en las direcciones 0x5F38 y 0x5F39; esto permite hacer bucle de una sección del mapa mientras el ancho y el alto sean potencias de 2 (2,4,8,16...)."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "The map coordinates (MX, MY) are masked by values calculated by subtracting 0x0.0001 from the values at address 0x5F38 and 0x5F39. ... you can loop a section of the map by poking the width and height you want to loop within, as long as they are powers of 2 (2,4,8,16..)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.5"
    statement: "Los valores por defecto (0,0) dan máscaras de 0xff.ffff, por lo que las muestras se repiten cada 256 tiles."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "The default values (0,0) gives a masks of 0xff.ffff, which means that the samples will loop every 256 tiles."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.6"
    statement: "Un offset de muestreo (también en tiles) puede especificarse en las direcciones 0x5f3a y 0x5f3b."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "An offset to sample from (also in tiles) can also be specified at addresses 0x5f3a, 0x5f3b: POKE(0x5F3A, OFFSET_X) POKE(0x5F3B, OFFSET_Y)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.7"
    statement: "El sprite 0 se considera 'vacío' y no se dibuja; el comportamiento se desactiva con POKE(0x5F36, 0x8)."
    evidence:
      locator: "6.6 Map > TLINE"
      quote_or_paraphrase: "Sprite 0 is taken to mean \"empty\" and not drawn. To disable this behaviour, use: POKE(0x5F36, 0x8)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.8"
    statement: "Por defecto las coordenadas tline (mx,my,mdx,mdy) se expresan en tiles: 1 píxel es 0.125 y sólo 13 bits se usan para la parte fraccionaria."
    evidence:
      locator: "6.6 Map > Setting TLINE Precision"
      quote_or_paraphrase: "By default, tline coordinates (mx,my,mdx,mdy) are expressed in tiles. This means that 1 pixel is 0.125, and only 13 bits are used for the fractional part."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.tline.claim.9"
    statement: "El número de bits de la parte fraccionaria se almacena en un registro especial que puede ajustarse llamando TLINE una vez con un único argumento: TLINE(16) expresa MX,MY,MDX,MDY en píxeles."
    evidence:
      locator: "6.6 Map > Setting TLINE Precision"
      quote_or_paraphrase: "The number of bits used for the fractional part of each pixel is stored in a special register that can be adjusted by calling TLINE once with a single argument: TLINE(16) -- MX,MY,MDX,MDY expressed in pixels"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
tline(x0, y0, x1, y1, mx, my, [mdx, mdy], [layers])
```

## Semántica

Dibuja una línea desde `(x0,y0)` hasta `(x1,y1)` muestreando el color de cada píxel desde el mapa según la posición de muestreo `(mx,my)`. Con `layers`, filtra los sprites por flags de forma similar a `MAP()`.

## Parámetros y retorno

- `x0`, `y0`, `x1`, `y1`: extremos de la línea en pantalla (píxeles).
- `mx`, `my`: coordenadas de muestreo iniciales en tiles (espacio de tiles por defecto, 13 bits fraccionarios).
- `mdx`, `mdy` (opcionales, por defecto 0.125, 0): deltas sumados a `mx`,`my` tras cada píxel.
- `layers` (opcional): bitfield de flags de sprite.
- Retorno: no especificado por la fuente.

## Efectos y límites

Las coordenadas se enmascaran según los valores de `0x5F38`/`0x5F39` (potencias de 2 para hacer bucle). El offset de muestreo se configura en `0x5f3a`/`0x5f3b`. El sprite 0 no se dibuja salvo `POKE(0x5F36, 0x8)`. La precisión por defecto es de 13 bits fraccionarios; una llamada `TLINE` con un único argumento (p.ej. `TLINE(16)`, coordenadas en píxeles) ajusta el espacio de coordenadas.

## Ejemplos relacionados

El manual muestra `POKE(0x5F38, 8)` y `POKE(0x5F39, 4)` seguidos de `TLINE(...)` para repetir la muestra cada 8 tiles en horizontal y cada 4 en vertical.

## Ambigüedades

- Limitación de fuente: el manual indica que los bits fraccionarios se almacenan en un "registro especial" ajustable mediante una llamada `TLINE` de un solo argumento, pero no especifica la dirección del registro ni la relación entre el argumento y el número de bits. Se documenta el comportamiento sin inventar la dirección ni la fórmula.
