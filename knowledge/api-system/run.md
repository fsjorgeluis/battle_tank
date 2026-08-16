---
schema_version: "1.0"
id: "pico8.api.run"
kind: "api"
title: "RUN"
summary: "Ejecuta el programa desde el inicio; puede reiniciarse desde dentro y recibe una string de parámetros accesible con stat(6)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "RUN"
relationships:
  - type: "related"
    target: "pico8.api.load"
  - type: "related"
    target: "pico8.api.stat"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.api.run.claim.1"
    statement: "RUN ejecuta el programa desde el inicio."
    evidence:
      locator: "6.1 System > RUN"
      quote_or_paraphrase: "Run from the start of the program."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.run.claim.2"
    statement: "RUN() puede llamarse desde un programa en ejecución para reiniciar."
    evidence:
      locator: "6.1 System > RUN"
      quote_or_paraphrase: "RUN() Can be called from inside a running program to reset."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.run.claim.3"
    statement: "Cuando se suministra PARAM_STR, puede leerse en tiempo de ejecución con stat(6)."
    evidence:
      locator: "6.1 System > RUN"
      quote_or_paraphrase: "When PARAM_STR is supplied, it can be accessed during runtime with STAT(6)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
run([param_str])
```

## Semántica

Ejecuta el programa desde su inicio. Llamado sin argumentos desde la consola arranca el cartucho; llamado desde dentro del programa lo reinicia.

## Parámetros y retorno

- `param_str` (opcional): string de parámetros disponible en tiempo de ejecución vía `stat(6)`.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Reiniciar con `RUN()` re-ejecuta el código de inicialización (incluida `_init()` si está definida).
- `CTRL-R` desde el editor equivale a recargar y ejecutar.

## Ejemplos relacionados

`RUN` desde la consola arranca el cartucho recién cargado; `RUN("LEVEL=2")` pasa parámetros accesibles con `stat(6)`.

## Ambigüedades

Ninguna documentada.
