---
schema_version: "1.0"
id: "pico8.api.sspr"
kind: "api"
title: "SSPR"
summary: "Estira un rectángulo de la hoja de sprites a un rectángulo destino en pantalla, con volteos opcionales."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "SSPR"
relationships:
  - type: "related"
    target: "pico8.api.spr"
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.api.fillp"
  - type: "related"
    target: "pico8.constraint.sprite-sheet-size"
claims:
  - id: "pico8.api.sspr.claim.1"
    statement: "SSPR(sx, sy, sw, sh, dx, dy, [dw, dh], [flip_x], [flip_y]) estira un rectángulo de la hoja de sprites a un rectángulo destino en pantalla."
    evidence:
      locator: "6.2 Graphics > SSPR"
      quote_or_paraphrase: "Stretch a rectangle of the sprite sheet (sx, sy, sw, sh) to a destination rectangle on the screen (dx, dy, dw, dh)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sspr.claim.2"
    statement: "En ambos casos, x e y son coordenadas (en píxeles) de la esquina superior izquierda del rectángulo, con ancho w y alto h."
    evidence:
      locator: "6.2 Graphics > SSPR"
      quote_or_paraphrase: "In both cases, the x and y values are coordinates (in pixels) of the rectangle's top left corner, with a width of w, h."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sspr.claim.3"
    statement: "El color 0 se dibuja transparente por defecto (ver PALT()); dw y dh por defecto son sw y sh."
    evidence:
      locator: "6.2 Graphics > SSPR"
      quote_or_paraphrase: "Colour 0 drawn as transparent by default (see PALT()) / dw, dh defaults to sw, sh"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sspr.claim.4"
    statement: "Cuando flip_x es TRUE, se voltea horizontalmente; cuando flip_y es TRUE, se voltea verticalmente."
    evidence:
      locator: "6.2 Graphics > SSPR"
      quote_or_paraphrase: "When FLIP_X is TRUE, flip horizontally. When FLIP_Y is TRUE, flip vertically."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
sspr(sx, sy, sw, sh, dx, dy, [dw, dh], [flip_x], [flip_y])
```

## Semántica

Copia y estira un rectángulo de la hoja de sprites hacia un rectángulo destino en pantalla. Permite recortar cualquier región de la hoja y escalarla o deformarla.

## Parámetros y retorno

- `sx`, `sy`, `sw`, `sh`: rectángulo origen en la hoja de sprites (coordenadas en píxeles).
- `dx`, `dy`, `dw`, `dh`: rectángulo destino en pantalla.
- `dw`, `dh` (opcionales, por defecto `sw`, `sh`): tamaño destino.
- `flip_x`, `flip_y` (opcionales, booleano): volteo horizontal y vertical.
- Retorno: no especificado por la fuente.

## Efectos y límites

El color 0 es transparente por defecto (configurable con `palt`). La aplicación del patrón de relleno a sprites también cubre `sspr`.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `sspr`.

## Ambigüedades

La firma en el manual cierra el corchete de parámetros opcionales dos veces: `SSPR(..., [FLIP_Y]]`. Es una errata tipográfica sin efecto sobre el contrato de la función.
