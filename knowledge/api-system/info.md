---
schema_version: "1.0"
id: "pico8.api.info"
kind: "api"
title: "INFO"
summary: "Imprime información del cartucho: tamaño de código, tokens y tamaño comprimido, además de indicadores de cambios sin guardar."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "INFO"
relationships:
  - type: "related"
    target: "pico8.constraint.token-limit"
  - type: "related"
    target: "pico8.api.save"
claims:
  - id: "pico8.api.info.claim.1"
    statement: "INFO() imprime información del cartucho: tamaño de código, tokens y tamaño comprimido."
    evidence:
      locator: "6.1 System > INFO"
      quote_or_paraphrase: "Print out some information about the cartridge: Code size, tokens, compressed size"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.info.claim.2"
    statement: "INFO() muestra también 'UNSAVED CHANGES' cuando el cartucho en memoria difiere del de disco."
    evidence:
      locator: "6.1 System > INFO"
      quote_or_paraphrase: "UNSAVED CHANGES  When the cartridge in memory differs to the one on disk"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.info.claim.3"
    statement: "INFO() muestra 'EXTERNAL CHANGES' cuando el cartucho en disco cambió desde que se cargó, por ejemplo al editarlo con un editor de texto externo."
    evidence:
      locator: "6.1 System > INFO"
      quote_or_paraphrase: "EXTERNAL CHANGES When the cartridge on disk has changed since it was loaded (e.g. by editing the program using a separate text editor)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
info()
```

## Semántica

Muestra métricas del cartucho actual y avisos sobre su estado respecto al archivo en disco.

## Parámetros y retorno

- Retorno: no especificado por la fuente; el resultado se imprime.

## Efectos y límites

- Los tokens informados por `INFO()` se relacionan con el límite de 8192 tokens (`pico8.constraint.token-limit`).

## Ejemplos relacionados

`INFO` desde la consola tras editar permite comprobar el tamaño de código y si hay cambios sin guardar.

## Ambigüedades

Ninguna documentada.
