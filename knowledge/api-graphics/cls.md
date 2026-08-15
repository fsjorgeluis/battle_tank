---
schema_version: "1.0"
id: "pico8.api.cls"
kind: "api"
title: "CLS"
summary: "Limpia la pantalla y restablece el rectángulo de recorte; el color por defecto es 0 (negro)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "CLS"
relationships:
  - type: "related"
    target: "pico8.api.clip"
  - type: "related"
    target: "pico8.api.camera"
claims:
  - id: "pico8.api.cls.claim.1"
    statement: "CLS([col]) limpia la pantalla y restablece el rectángulo de recorte."
    evidence:
      locator: "6.2 Graphics > CLS"
      quote_or_paraphrase: "Clear the screen and reset the clipping rectangle."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cls.claim.2"
    statement: "COL por defecto es 0 (negro)."
    evidence:
      locator: "6.2 Graphics > CLS"
      quote_or_paraphrase: "COL defaults to 0 (black)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cls([col])
```

## Semántica

Limpia toda la pantalla con el color dado y restablece el rectángulo de recorte a su valor por defecto.

## Parámetros y retorno

- `col` (opcional): color de limpieza; por defecto 0 (negro).
- Retorno: no especificado por la fuente.

## Efectos y límites

Al restablecer el rectángulo de recorte, una llamada a `cls` anula cualquier `clip` anterior.

## Ejemplos relacionados

El manual usa `CLS()` antes de dibujar la figura de ejemplo de `line`.

## Ambigüedades

Ninguna documentada.
