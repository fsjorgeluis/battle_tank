---
schema_version: "1.0"
id: "pico8.api.camera"
kind: "api"
title: "CAMERA"
summary: "Aplica un desplazamiento de pantalla de -x, -y a todas las operaciones de dibujo; CAMERA() lo restablece."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CAMERA"
relationships:
  - type: "related"
    target: "pico8.api.clip"
  - type: "related"
    target: "pico8.api.cls"
claims:
  - id: "pico8.api.camera.claim.1"
    statement: "CAMERA([x, y]) fija un desplazamiento de pantalla de -x, -y para todas las operaciones de dibujo."
    evidence:
      locator: "6.2 Graphics > CAMERA"
      quote_or_paraphrase: "Set a screen offset of -x, -y for all drawing operations"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.camera.claim.2"
    statement: "CAMERA() restablece el desplazamiento."
    evidence:
      locator: "6.2 Graphics > CAMERA"
      quote_or_paraphrase: "CAMERA() to reset"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
camera([x, y])
```

## Semántica

Desplaza el origen de coordenadas de todas las operaciones de dibujo en -x, -y, lo que permite implementar una cámara para el mundo del juego.

## Parámetros y retorno

- `x`, `y` (opcionales): desplazamiento; la cámara resta estos valores a las coordenadas de dibujo.
- Retorno: no especificado por la fuente.

## Efectos y límites

La posición de cámara es parte del estado de dibujo, que se restablece al ejecutar el programa o con `RESET()`. Afecta a todas las operaciones de dibujo posteriores.

## Ejemplos relacionados

El manual no muestra un ejemplo directo de `camera`.

## Ambigüedades

Ninguna documentada.
