---
schema_version: "1.0"
id: "pico8.constraint.tline-fraction-bits"
kind: "constraint"
title: "Precisión fraccionaria por defecto de TLINE"
summary: "El espacio de coordenadas de TLINE usa por defecto 13 bits para la parte fraccionaria."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.6 Map"
    anchor: "Setting TLINE Precision"
relationships:
  - type: "related"
    target: "pico8.api.tline"
  - type: "related"
    target: "pico8.constraint.sprite-size"
claims:
  - id: "pico8.constraint.tline-fraction-bits.claim.1"
    statement: "Por defecto, las coordenadas tline (mx,my,mdx,mdy) se expresan en tiles: 1 píxel es 0.125 y sólo 13 bits se usan para la parte fraccionaria."
    evidence:
      locator: "6.6 Map > Setting TLINE Precision"
      quote_or_paraphrase: "By default, tline coordinates (mx,my,mdx,mdy) are expressed in tiles. This means that 1 pixel is 0.125, and only 13 bits are used for the fractional part."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.tline-fraction-bits.claim.2"
    statement: "El espacio de coordenadas puede ajustarse para permitir más bits fraccionarios llamando TLINE una vez con un único argumento: TLINE(16) expresa las coordenadas en píxeles."
    evidence:
      locator: "6.6 Map > Setting TLINE Precision"
      quote_or_paraphrase: "the coordinate space can be adjusted to allow more bits for the fractional part ... TLINE(16) -- MX,MY,MDX,MDY expressed in pixels"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "tline coordinates"
  property: "fractional-bits"
  operator: "fixed"
  value: "13"
  unit: "bits"
  scope: "pico8.api.tline"
  enforcement: "default tline coordinate space"
---

## Consecuencia práctica

Con 13 bits fraccionarios, un tile se divide en 8192 pasos (2^13), es decir 1 píxel = 0.125 tiles (8 píxeles por tile). El error acumulado de `mdx`,`mdy` por redondeo puede hacerse visible en superficies cercanas (derived desde claim 1); aumentar la precisión reduce ese error.

## Ambigüedades

- Limitación de fuente: el manual no especifica la dirección del "registro especial" que guarda el número de bits fraccionarios ni la relación entre el argumento de la llamada de un solo argumento y dicho número.
