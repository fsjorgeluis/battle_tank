---
schema_version: "1.0"
id: "pico8.api.atan2"
kind: "api"
title: "ATAN2"
summary: "Convierte DX, DY en un ángulo de 0..1, en sentido antihorario en el espacio de pantalla."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "ATAN2"
relationships:
  - type: "related-api"
    target: "pico8.api.cos"
  - type: "related-api"
    target: "pico8.api.sin"
claims:
  - id: "pico8.api.atan2.claim.1"
    statement: "ATAN2(DX, DY) convierte DX, DY en un ángulo de 0..1."
    evidence:
      locator: "6.8 Math > ATAN2"
      quote_or_paraphrase: "Converts DX, DY into an angle from 0..1"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.atan2.claim.2"
    statement: "Como con cos/sin, el ángulo corre en sentido antihorario en el espacio de pantalla."
    evidence:
      locator: "6.8 Math > ATAN2"
      quote_or_paraphrase: "As with cos/sin, angle is taken to run anticlockwise in screenspace."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.atan2.claim.3"
    statement: "El manual muestra ?ATAN(0, -1) -- RETURNS 0.25 como ejemplo del resultado de la función."
    evidence:
      locator: "6.8 Math > ATAN2"
      quote_or_paraphrase: "> ?ATAN(0, -1) -- RETURNS 0.25"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.atan2.claim.4"
    statement: "ATAN2 se usa para hallar la dirección entre dos puntos; el manual muestra A=ATAN2(X-64, Y-64) y LINE(64,64, 64+COS(A)*10, 64+SIN(A)*10,7)."
    evidence:
      locator: "6.8 Math > ATAN2"
      quote_or_paraphrase: "ATAN2 can be used to find the direction between two points: ... A=ATAN2(X-64, Y-64) ... LINE(64,64, 64+COS(A)*10, 64+SIN(A)*10,7)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
atan2(dx, dy)
```

## Semántica

Convierte un vector (dx, dy) en un ángulo normalizado de 0..1, en sentido antihorario en el espacio de pantalla. Útil para orientar hacia un punto.

## Parámetros y retorno

- `dx`, `dy`: componentes del vector.
- Retorno: ángulo de 0..1.

## Efectos y límites

El ángulo devuelto es compatible con `cos()`/`sin()` (una vuelta completa = 1.0).

## Ejemplos relacionados

```lua
x=20 y=30
function _update()
  if (btn(0)) x-=2
  if (btn(1)) x+=2
  if (btn(2)) y-=2
  if (btn(3)) y+=2
end
function _draw()
  cls()
  circfill(x,y,2,14)
  circfill(64,64,2,7)
  a=atan2(x-64, y-64)
  print("ANGLE: "..a)
  line(64,64, 64+cos(a)*10, 64+sin(a)*10,7)
end
```

## Ambigüedades

- Errata de fuente: el ejemplo escribe `?ATAN(0, -1) -- RETURNS 0.25`, pero la única función documentada en la sección es ATAN2. Se trata de una errata del ejemplo; el contrato normalizado es `atan2(dx, dy)`.
