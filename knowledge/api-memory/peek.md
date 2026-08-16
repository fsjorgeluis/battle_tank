---
schema_version: "1.0"
id: "pico8.api.peek"
kind: "api"
title: "PEEK"
summary: "Lee un byte de una dirección de la RAM base; con N devuelve N resultados (máx 8192)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "PEEK"
relationships:
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.peek2"
  - type: "related"
    target: "pico8.api.peek4"
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.constraint.peek-result-max"
  - type: "related"
    target: "pico8.constraint.ram-size"
claims:
  - id: "pico8.api.peek.claim.1"
    statement: "PEEK(ADDR, [N]) lee un byte de una dirección de la RAM base."
    evidence:
      locator: "6.7 Memory > PEEK"
      quote_or_paraphrase: "Read a byte from an address in base ram."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.peek.claim.2"
    statement: "Si N se especifica, PEEK() devuelve ese número de resultados (máx: 8192)."
    evidence:
      locator: "6.7 Memory > PEEK"
      quote_or_paraphrase: "If N is specified, PEEK() returns that number of results (max: 8192)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.peek.claim.3"
    statement: "El manual muestra A, B = PEEK(0x6000, 2) para leer los 2 primeros bytes de la video memory."
    evidence:
      locator: "6.7 Memory > PEEK"
      quote_or_paraphrase: "For example, to read the first 2 bytes of video memory: A, B = PEEK(0x6000, 2)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.peek.claim.4"
    statement: "El operador @ADDR equivale a PEEK(ADDR) y es algo más rápido; sólo permite lectura."
    evidence:
      locator: "6.7 Memory > PEEK2"
      quote_or_paraphrase: "Alternatively, the following operators can be used to peek (but not poke), and are slightly faster: @ADDR -- PEEK(ADDR)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
peek(addr, [n])
```

## Semántica

Lee un byte de la dirección `addr` de la RAM base. Con `n` especificado, devuelve `n` bytes consecutivos.

## Parámetros y retorno

- `addr`: dirección en RAM base.
- `n` (opcional): número de resultados; máximo 8192.
- Retorno: el byte leído en `addr`, o `n` bytes consecutivos cuando se especifica `n`.

## Efectos y límites

El re-mapeo de GFX/SCREEN (`0x5f54`/`0x5f56`) afecta al acceso a memoria, incluido PEEK. Los bloques de 8k de las direcciones `0x0` y `0x6000` se comportan como punteros a una RAM de video separada.

## Ejemplos relacionados

`A, B = PEEK(0x6000, 2)` lee los dos primeros bytes de la video memory.

## Ambigüedades

Ninguna documentada.
