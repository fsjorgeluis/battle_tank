---
schema_version: "1.0"
id: "pico8.api.palt"
kind: "api"
title: "PALT"
summary: "Establece la transparencia del índice de color C a T (booleano); la observan SPR, SSPR, MAP y TLINE."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "PALT"
relationships:
  - type: "related"
    target: "pico8.api.spr"
  - type: "related"
    target: "pico8.api.sspr"
  - type: "related"
    target: "pico8.api.pal"
claims:
  - id: "pico8.api.palt.claim.1"
    statement: "PALT(c, [t]) fija la transparencia del índice de color a t (booleano)."
    evidence:
      locator: "6.2 Graphics > PALT"
      quote_or_paraphrase: "Set transparency for colour index to T (boolean)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.palt.claim.2"
    statement: "La transparencia es observada por SPR(), SSPR(), MAP() y TLINE()."
    evidence:
      locator: "6.2 Graphics > PALT"
      quote_or_paraphrase: "Transparency is observed by SPR(), SSPR(), MAP() AND TLINE()"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.palt.claim.3"
    statement: "PALT() restablece el valor por defecto: todos los colores opacos excepto el 0."
    evidence:
      locator: "6.2 Graphics > PALT"
      quote_or_paraphrase: "PALT() resets to default: all colours opaque except colour 0"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.palt.claim.4"
    statement: "Cuando C es el único parámetro, se trata como bitfield para fijar los 16 valores; PALT(0b1100000000000000) hace transparentes los colores 0 y 1."
    evidence:
      locator: "6.2 Graphics > PALT"
      quote_or_paraphrase: "When C is the only parameter, it is treated as a bitfield used to set all 16 values. For example: to set colours 0 and 1 as transparent: PALT(0B1100000000000000)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
palt(c, [t])
```

## Semántica

Marca un índice de color como transparente u opaco para el dibujo de sprites y mapas. Por defecto, el color 0 es transparente y el resto opaco.

## Parámetros y retorno

- `c`: índice de color 0..15.
- `t` (opcional, booleano): si es transparente o no; sin él, `c` se interpreta como bitfield de los 16 colores.
- Retorno: no especificado por la fuente.

## Efectos y límites

La transparencia afecta a SPR, SSPR, MAP y TLINE. `palt()` sin argumentos restablece el valor por defecto. `PAL()` también restablece los valores de transparencia.

## Ejemplos relacionados

El manual muestra `PALT(8, TRUE)` para no dibujar los píxeles rojos en llamadas posteriores de sprite.

## Ambigüedades

Ninguna documentada.
