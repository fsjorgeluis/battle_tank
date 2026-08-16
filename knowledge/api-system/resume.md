---
schema_version: "1.0"
id: "pico8.api.resume"
kind: "api"
title: "RESUME"
summary: "Reanuda el programa detenido; un '.' avanza un frame y entra en modo frame-by-frame (stat(110))."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "RESUME"
relationships:
  - type: "related"
    target: "pico8.api.stop"
  - type: "related"
    target: "pico8.api.stat"
claims:
  - id: "pico8.api.resume.claim.1"
    statement: "RESUME reanuda el programa detenido; la abreviatura es R."
    evidence:
      locator: "6.1 System > RESUME"
      quote_or_paraphrase: "Resume the program. Use R for short."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.resume.claim.2"
    statement: "Usar un único '.' desde la línea de comandos avanza un frame e entra en modo frame-by-frame, que puede leerse con stat(110)."
    evidence:
      locator: "6.1 System > RESUME"
      quote_or_paraphrase: "Use a single \".\" from the commandline to advance a single frame. This enters frame-by-frame mode, that can be read with stat(110)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.resume.claim.3"
    statement: "Mientras el modo frame-by-frame está activo, introducir un comando vacío (pulsar enter) avanza un frame."
    evidence:
      locator: "6.1 System > RESUME"
      quote_or_paraphrase: "While frame-by-frame mode is active, entering an empty command (by pressing enter) advances one frames."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
resume()
```

## Semántica

Reanuda la ejecución de un programa detenido. La variante de consola `.` permite depuración frame a frame.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- `R` es la abreviatura de consola para reanudar.
- El modo frame-by-frame activo se detecta con `stat(110)`.

## Ejemplos relacionados

Tras `STOP()`, `RESUME` continúa el programa.

## Ambigüedades

Ninguna documentada.
