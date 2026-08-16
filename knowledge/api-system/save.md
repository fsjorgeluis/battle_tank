---
schema_version: "1.0"
id: "pico8.api.save"
kind: "api"
title: "SAVE"
summary: "Guarda el cartucho de trabajo en disco con un nombre de archivo."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "SAVE"
relationships:
  - type: "related"
    target: "pico8.api.load"
  - type: "related"
    target: "pico8.concept.export-tools"
  - type: "related"
    target: "pico8.api.info"
claims:
  - id: "pico8.api.save.claim.1"
    statement: "SAVE guarda el cartucho de trabajo en disco con el nombre dado."
    evidence:
      locator: "6.1 System > LOAD/SAVE"
      quote_or_paraphrase: "Load or save a cartridge"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.save.claim.2"
    statement: "SAVE usa un único parámetro FILENAME."
    evidence:
      locator: "6.1 System > SAVE"
      quote_or_paraphrase: "SAVE(FILENAME)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.save.claim.3"
    statement: "Las funciones del sistema pueden omitir paréntesis y comillas desde la línea de comandos: 'SAVE PINKCIRC' guarda el cartucho con ese nombre."
    evidence:
      locator: "1.2 Hello World"
      quote_or_paraphrase: "If you want to store your program for later, use the SAVE command: > SAVE PINKCIRC"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
save(filename)
```

## Semántica

Guarda el cartucho actual en disco. `EXPORT` a formato cartucho equivale a `SAVE` sin alterar el cartucho de trabajo.

## Parámetros y retorno

- `filename`: nombre del archivo `.p8`.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Desde la consola se escribe sin paréntesis ni comillas: `SAVE PINKCIRC`.
- Guardar como cartucho puede combinarse con `INFO()` para conocer tamaño y tokens.

## Ejemplos relacionados

`SAVE PINKCIRC` guarda el programa actual como `pinkcirc.p8`.

## Ambigüedades

Ninguna documentada.
