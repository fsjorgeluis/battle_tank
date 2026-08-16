---
schema_version: "1.0"
id: "pico8.api.abs"
kind: "api"
title: "ABS"
summary: "Devuelve el valor absoluto (positivo) de X."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "ABS"
relationships: []
claims:
  - id: "pico8.api.abs.claim.1"
    statement: "ABS(X) devuelve el valor absoluto (positivo) de x."
    evidence:
      locator: "6.8 Math > ABS"
      quote_or_paraphrase: "Returns the absolute (positive) value of x"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
abs(x)
```

## Semántica

Devuelve el valor absoluto (magnitud positiva) de `x`.

## Parámetros y retorno

- `x`: número.
- Retorno: el valor absoluto de `x`.

## Efectos y límites

Sin restricciones adicionales documentadas en la fuente.

## Ejemplos relacionados

Ninguno explícito en la fuente.

## Ambigüedades

Ninguna documentada.
