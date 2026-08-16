---
schema_version: "1.0"
id: "pico8.api.stop"
kind: "api"
title: "STOP"
summary: "Detiene el cartucho y opcionalmente imprime un mensaje."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "STOP"
relationships:
  - type: "related"
    target: "pico8.api.resume"
  - type: "related"
    target: "pico8.api.assert"
  - type: "related"
    target: "pico8.api.run"
claims:
  - id: "pico8.api.stop.claim.1"
    statement: "STOP detiene el cartucho y opcionalmente imprime un mensaje."
    evidence:
      locator: "6.1 System > STOP"
      quote_or_paraphrase: "Stop the cart and optionally print a message."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stop.claim.2"
    statement: "La firma de STOP acepta un parámetro MESSAGE opcional."
    evidence:
      locator: "6.1 System > STOP"
      quote_or_paraphrase: "STOP([MESSAGE])"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
stop([message])
```

## Semántica

Detiene la ejecución del cartucho. Si se pasa un mensaje, lo imprime. El programa puede reanudarse con `RESUME`.

## Parámetros y retorno

- `message` (opcional): texto que se imprime al detener.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Al detener el programa se vuelve a la consola; `RESUME` continúa la ejecución.

## Ejemplos relacionados

`STOP("LEVEL COMPLETE")` detiene el cartucho mostrando el mensaje.

## Ambigüedades

Ninguna documentada.
