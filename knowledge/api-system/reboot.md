---
schema_version: "1.0"
id: "pico8.api.reboot"
kind: "api"
title: "REBOOT"
summary: "Reinicia la máquina; útil para empezar un proyecto nuevo."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "REBOOT"
relationships:
  - type: "related"
    target: "pico8.api.reset"
  - type: "related"
    target: "pico8.api.load"
claims:
  - id: "pico8.api.reboot.claim.1"
    statement: "REBOOT reinicia la máquina y es útil para empezar un proyecto nuevo."
    evidence:
      locator: "6.1 System > REBOOT"
      quote_or_paraphrase: "Reboot the machine Useful for starting a new project"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reboot.claim.2"
    statement: "REBOOT no recibe parámetros en la firma de la fuente."
    evidence:
      locator: "6.1 System > REBOOT"
      quote_or_paraphrase: "REBOOT"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
reboot()
```

## Semántica

Reinicia la máquina PICO-8, dejándola lista para un proyecto nuevo.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- `REBOOT` es más drástico que `RESET()`: reinicia la máquina completa; `RESET()` sólo restaura los valores de RAM de 0x5f00..0x5f7f.

## Ejemplos relacionados

`REBOOT` desde la consola inicia un proyecto desde cero.

## Ambigüedades

Ninguna documentada.
