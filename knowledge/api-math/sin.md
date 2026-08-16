---
schema_version: "1.0"
id: "pico8.api.sin"
kind: "api"
title: "SIN"
summary: "Seno de X, donde 1.0 equivale a una vuelta completa; resultado invertido para el espacio de pantalla."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "SIN"
relationships:
  - type: "related-api"
    target: "pico8.api.cos"
  - type: "related-api"
    target: "pico8.api.atan2"
claims:
  - id: "pico8.api.sin.claim.1"
    statement: "SIN(X) devuelve el seno de x, donde 1.0 significa una vuelta completa."
    evidence:
      locator: "6.8 Math > SIN"
      quote_or_paraphrase: "COS(X) SIN(X) -- Returns the cosine or sine of x, where 1.0 means a full turn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sin.claim.2"
    statement: "SIN devuelve un resultado invertido para adaptarse al espacio de pantalla (Y 'hacia abajo'): SIN(0.25) devuelve -1."
    evidence:
      locator: "6.8 Math > SIN"
      quote_or_paraphrase: "PICO-8's SIN() returns an inverted result to suit screenspace (where Y means 'DOWN'...); > SIN(0.25) -- RETURNS -1"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sin.claim.3"
    statement: "El manual ofrece un fragmento para trigonometría convencional en radianes sin inversión de Y, que redefine COS y SIN."
    evidence:
      locator: "6.8 Math > SIN"
      quote_or_paraphrase: "To get conventional radian-based trig functions without the y inversion, paste the following snippet near the start of your program: P8COS = COS FUNCTION COS(ANGLE) RETURN P8COS(ANGLE/(3.1415*2)) END; P8SIN = SIN FUNCTION SIN(ANGLE) RETURN -P8SIN(ANGLE/(3.1415*2)) END"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
sin(x)
```

## Semántica

Seno del ángulo `x`, donde `1.0` representa una vuelta completa. El resultado está invertido respecto a la convención matemática para acomodar el eje Y de pantalla ("hacia abajo").

## Parámetros y retorno

- `x`: ángulo normalizado, donde 1.0 es una vuelta completa.
- Retorno: seno de `x`, invertido para espacio de pantalla.

## Efectos y límites

`sin(0.25)` devuelve `-1`. Para trigonometría convencional en radianes sin la inversión, la fuente propone redefinir `cos()` y `sin()` al inicio del programa.

## Ejemplos relacionados

```lua
?sin(0.25) -- -1
```

## Ambigüedades

Ninguna documentada.
