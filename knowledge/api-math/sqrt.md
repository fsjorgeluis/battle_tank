---
schema_version: "1.0"
id: "pico8.api.sqrt"
kind: "api"
title: "SQRT"
summary: "Devuelve la raíz cuadrada de X."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "SQRT"
relationships: []
claims:
  - id: "pico8.api.sqrt.claim.1"
    statement: "SQRT(X) devuelve la raíz cuadrada de x."
    evidence:
      locator: "6.8 Math > SQRT"
      quote_or_paraphrase: "Return the square root of x"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
sqrt(x)
```

## Semántica

Devuelve la raíz cuadrada de `x`.

## Parámetros y retorno

- `x`: número.
- Retorno: la raíz cuadrada de `x`.

## Efectos y límites

Sin restricciones adicionales documentadas en la fuente.

## Ejemplos relacionados

Ninguno explícito en la fuente.

## Ambigüedades

Ninguna documentada.
