---
schema_version: "1.0"
id: "pico8.api.fillp"
kind: "api"
title: "FILLP"
summary: "Configura el patrón de relleno de PICO-8, un patrón teselado 4x4 de 2 colores observado por las funciones de dibujo."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "FILLP"
relationships:
  - type: "related"
    target: "pico8.api.pal"
  - type: "related"
    target: "pico8.api.palt"
  - type: "related"
    target: "pico8.api.circfill"
  - type: "related"
    target: "pico8.api.rectfill"
  - type: "related"
    target: "pico8.api.ovalfill"
  - type: "related"
    target: "pico8.api.pset"
  - type: "related"
    target: "pico8.api.line"
claims:
  - id: "pico8.api.fillp.claim.1"
    statement: "El patrón de relleno de PICO-8 es un patrón teselado 4x4 de 2 colores observado por CIRC, CIRCFILL, RECT, RECTFILL, OVAL, OVALFILL, PSET y LINE."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "The PICO-8 fill pattern is a 4x4 2-colour tiled pattern observed by: CIRC() CIRCFILL() RECT() RECTFILL() OVAL() OVALFILL() PSET() LINE()"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fillp.claim.2"
    statement: "P es un bitfield en orden de lectura empezando por el bit más alto; el patrón por defecto es 0, un color sólido."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "P is a bitfield in reading order starting from the highest bit. ... The default fill pattern is 0, which means a single solid colour is drawn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fillp.claim.3"
    statement: "Para especificar un segundo color del patrón se usan los bits altos de cualquier parámetro de color: FILLP(0b0011010101101000) y CIRCFILL(64,64,20, 0x4E) dibujan un círculo marrón y rosa."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "To specify a second colour for the pattern, use the high bits of any colour parameter: FILLP(0b0011010101101000) CIRCFILL(64,64,20, 0x4E) -- brown and pink"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fillp.claim.4"
    statement: "Los bits 0b0.111 añaden ajustes: 0b0.100 transparencia (el segundo color no se dibuja), 0b0.010 aplicar a sprites (spr, sspr, map, tline mediante la paleta secundaria) y 0b0.001 aplicar la paleta secundaria globalmente."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "Additional settings are given in bits 0b0.111: 0b0.100 Transparency ... 0b0.010 Apply to Sprites ... 0b0.001 Apply Secondary Palette Globally"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fillp.claim.5"
    statement: "El patrón de relleno también puede fijarse con bits de cualquier parámetro de color: bit 0x1000.0000 (observar bits 0xf00.ffff), 0x0100.0000 transparencia, 0x0200.0000 aplicar a sprites, 0x0400.0000 aplicar la paleta secundaria globalmente, 0x0800.0000 invertir la operación, bits 0x00FF.0000 de color y bits 0x0000.FFFF del patrón."
    evidence:
      locator: "6.2 Graphics > FILLP"
      quote_or_paraphrase: "When using the colour parameter to set the fill pattern, the following bits are used: bit 0x1000.0000 ... bit 0x0800.0000 invert the drawing operation ... bits 0x00FF.0000 are the usual colour bits ... bits 0x0000.FFFF are interpreted as the fill pattern"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
fillp(p)
```

## Semántica

Fija el patrón de relleno usado por las funciones de dibujo rellenas y de píxeles. Cada bit del bitfield de 16 bits corresponde a una celda del mosaico 4x4, en orden de lectura empezando por el bit más alto. El segundo color del patrón se codifica en los bits altos de los parámetros de color; los ajustes adicionales (transparencia, aplicar a sprites, aplicar paleta secundaria globalmente) usan los bits 0b0.111 del patrón o los bits altos del parámetro de color.

## Parámetros y retorno

- `p`: bitfield del patrón (16 bits) con ajustes opcionales en los bits superiores.
- Retorno: no especificado por la fuente.

## Efectos y límites

Con patrón 0 (por defecto) se dibuja un color sólido. El modo "aplicar a sprites" usa la paleta secundaria de `pal` para mapear cada color de sprite a dos colores del patrón; la paleta secundaria se aplica tras la paleta de dibujo. El bit 0x0800.0000 del parámetro de color invierte la operación en las funciones que lo soportan.

## Ejemplos relacionados

El manual muestra `FILLP(0b0011001111001100)` para un damero, y la combinación con `CIRCFILL(64,64,20, 0x4E)` para un círculo marrón y rosa.

## Ambigüedades

El manual describe los ajustes en dos codificaciones distintas (bits 0b0.111 de `fillp` y bits 0x0X00.0000 del parámetro de color); ambas formas coexisten y la fuente no aclara prioridades entre ellas cuando se usan a la vez.
