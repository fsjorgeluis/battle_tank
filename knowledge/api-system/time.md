---
schema_version: "1.0"
id: "pico8.api.time"
kind: "api"
title: "TIME"
summary: "Segundos transcurridos desde que se ejecutó el cartucho; se calcula contando llamadas a _update/_update60, no con tiempo real."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "TIME"
relationships:
  - type: "related"
    target: "pico8.concept.game-loop"
  - type: "related"
    target: "pico8.api.stat"
claims:
  - id: "pico8.api.time.claim.1"
    statement: "TIME() y T() devuelven el número de segundos transcurridos desde que se ejecutó el cartucho."
    evidence:
      locator: "6.1 System > TIME/T"
      quote_or_paraphrase: "TIME() -- T() -- Returns the number of seconds elapsed since the cartridge was run."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.time.claim.2"
    statement: "T() es una abreviatura de TIME() en la firma de la fuente."
    evidence:
      locator: "6.1 System > TIME/T"
      quote_or_paraphrase: "TIME()\nT()"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.time.claim.3"
    statement: "El valor no es tiempo real: se calcula contando el número de veces que se llama a _update o _update60."
    evidence:
      locator: "6.1 System > TIME/T"
      quote_or_paraphrase: "This is not the real-world time, but is calculated by counting the number of times _UPDATE or @_UPDATE60 is called."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.time.claim.4"
    statement: "Múltiples llamadas a TIME() dentro del mismo frame devuelven el mismo resultado."
    evidence:
      locator: "6.1 System > TIME/T"
      quote_or_paraphrase: "Multiple calls of TIME() from the same frame return the same result."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
time()  -- alias: t()
```

## Semántica

Devuelve los segundos desde el arranque del cartucho. Como se deriva de contar llamadas de actualización, es determinista dentro de un frame y dependiente del modo de ejecución (30/60/15 fps).

## Parámetros y retorno

- Retorno: número de segundos transcurridos desde que se ejecutó el cartucho.

## Efectos y límites

- No es tiempo real: al correr a menos fps el tiempo avanza más lento en tiempo de pared.
- Todas las llamadas del mismo frame devuelven el mismo valor.

## Ejemplos relacionados

`PRINT(T())` muestra el tiempo del cartucho; `FLIP()GOTO _` en un bucle manual puede usarse con `T()` para animar.

## Ambigüedades

Ninguna documentada.
