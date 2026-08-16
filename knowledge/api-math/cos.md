---
schema_version: "1.0"
id: "pico8.api.cos"
kind: "api"
title: "COS"
summary: "Coseno de X, donde 1.0 equivale a una vuelta completa."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "COS"
relationships:
  - type: "related-api"
    target: "pico8.api.sin"
  - type: "related-api"
    target: "pico8.api.atan2"
claims:
  - id: "pico8.api.cos.claim.1"
    statement: "COS(X) devuelve el coseno de x, donde 1.0 significa una vuelta completa."
    evidence:
      locator: "6.8 Math > COS"
      quote_or_paraphrase: "COS(X) SIN(X) -- Returns the cosine or sine of x, where 1.0 means a full turn."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cos.claim.2"
    statement: "El manual anima un dial que gira una vez por segundo con X = 64 + COS(T()) * 20 dentro de _DRAW."
    evidence:
      locator: "6.8 Math > COS"
      quote_or_paraphrase: "For example, to animate a dial that turns once every second: FUNCTION _DRAW() ... X = 64 + COS(T()) * 20"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cos(x)
```

## Semántica

Coseno del ángulo `x`, donde `1.0` representa una vuelta completa (en lugar de 2π radianes). Comparte el espacio de ángulo en sentido antihorario de pantalla con `sin()` y `atan2()`.

## Parámetros y retorno

- `x`: ángulo normalizado, donde 1.0 es una vuelta completa.
- Retorno: coseno de `x`.

## Efectos y límites

La fuente ofrece un fragmento alternativo para trigonometría convencional en radianes (ver SIN), que reemplaza COS y SIN.

## Ejemplos relacionados

```lua
-- dial que gira una vez por segundo
function _draw()
  cls()
  circ(64, 64, 20, 7)
  x = 64 + cos(t()) * 20
  y = 64 + sin(t()) * 20
  line(64, 64, x, y)
end
```

## Ambigüedades

Ninguna documentada.
