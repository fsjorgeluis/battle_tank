---
schema_version: "1.0"
id: "pico8.api.spr"
kind: "api"
title: "SPR"
summary: "Dibuja el sprite N (0..255) en (x, y), con ancho/alto opcionales en sprites y volteos."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "SPR"
relationships:
  - type: "related"
    target: "pico8.api.sspr"
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.api.pal"
  - type: "related"
    target: "pico8.api.fillp"
  - type: "related"
    target: "pico8.constraint.sprite-count"
claims:
  - id: "pico8.api.spr.claim.1"
    statement: "SPR(n, x, y, [w, h], [flip_x], [flip_y]) dibuja el sprite n (0..255) en la posición x, y."
    evidence:
      locator: "6.2 Graphics > SPR"
      quote_or_paraphrase: "Draw sprite N (0..255) at position X,Y"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.spr.claim.2"
    statement: "w (ancho) y h (alto) son 1, 1 por defecto y especifican cuántos sprites de ancho se copian."
    evidence:
      locator: "6.2 Graphics > SPR"
      quote_or_paraphrase: "W (width) and H (height) are 1, 1 by default and specify how many sprites wide to blit."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.spr.claim.3"
    statement: "El color 0 se dibuja transparente por defecto (ver PALT())."
    evidence:
      locator: "6.2 Graphics > SPR"
      quote_or_paraphrase: "Colour 0 drawn as transparent by default (see PALT())"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.spr.claim.4"
    statement: "Cuando flip_x es TRUE, se voltea horizontalmente; cuando flip_y es TRUE, se voltea verticalmente."
    evidence:
      locator: "6.2 Graphics > SPR"
      quote_or_paraphrase: "When FLIP_X is TRUE, flip horizontally. When FLIP_Y is TRUE, flip vertically."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
spr(n, x, y, [w, h], [flip_x], [flip_y])
```

## Semántica

Copia el sprite `n` de la hoja de sprites a la pantalla en (x, y). Con `w` y `h` mayores que 1, copia un mosaico de sprites contiguos.

## Parámetros y retorno

- `n`: índice de sprite 0..255 (los 128 primeros del banco dedicado y 128 del compartido).
- `x`, `y`: posición en pantalla.
- `w`, `h` (opcionales, por defecto 1): número de sprites de ancho y alto a copiar.
- `flip_x`, `flip_y` (opcionales, booleano): volteo horizontal y vertical.
- Retorno: no especificado por la fuente.

## Efectos y límites

El color 0 es transparente por defecto; la transparencia se configura con `palt`. La paleta de dibujo se aplica al dibujar el sprite. El patrón de relleno se aplica a sprites cuando `fillp` tiene activo el ajuste `0b0.010`.

## Ejemplos relacionados

El manual combina `PAL(9,8)` con `SPR(1,70,60)` para dibujar un sprite con sus píxeles naranjas en rojo.

## Ambigüedades

Ninguna documentada.
