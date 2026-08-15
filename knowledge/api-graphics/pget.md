---
schema_version: "1.0"
id: "pico8.api.pget"
kind: "api"
title: "PGET"
summary: "Devuelve el color del píxel de la pantalla en (x, y); fuera de rango devuelve 0 salvo valor personalizado."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "PGET"
relationships:
  - type: "related"
    target: "pico8.api.pset"
claims:
  - id: "pico8.api.pget.claim.1"
    statement: "PGET(x, y) devuelve el color de un píxel de la pantalla en (x, y)."
    evidence:
      locator: "6.2 Graphics > PGET"
      quote_or_paraphrase: "Returns the colour of a pixel on the screen at (X, Y)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pget.claim.2"
    statement: "Cuando x e y están fuera de rango, PGET devuelve 0."
    evidence:
      locator: "6.2 Graphics > PGET"
      quote_or_paraphrase: "When X and Y are out of bounds, PGET returns 0."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pget.claim.3"
    statement: "Se puede especificar un valor de retorno personalizado fuera de rango con POKE(0x5f36, 0x10) y POKE(0x5f5B, NEWVAL)."
    evidence:
      locator: "6.2 Graphics > PGET"
      quote_or_paraphrase: "A custom return value can be specified with: POKE(0x5f36, 0x10) POKE(0x5f5B, NEWVAL)"
    classification: "fact"
    confidence: "medium"
---

## Contrato

```lua
pget(x, y)
```

## Semántica

Lee el índice de color del píxel de la pantalla en las coordenadas dadas.

## Parámetros y retorno

- `x`, `y`: coordenadas del píxel.
- Retorno: índice de color (0..15); 0 si está fuera de rango, salvo que se fije un valor personalizado.

## Efectos y límites

El valor personalizado fuera de rango depende de POKE en direcciones de memoria (0x5f36 y 0x5f5b), cuyo contrato completo pertenece al dominio de memoria.

## Ejemplos relacionados

El manual muestra un bucle que copia píxeles con PSET y PGET: `X, Y = RND(128), RND(128)` y `PSET(X, Y, PGET(DX+X, DY+Y))`.

## Ambigüedades

Ninguna documentada.
