---
schema_version: "1.0"
id: "pico8.api.fset"
kind: "api"
title: "FSET"
summary: "Establece el valor (val) del flag F del sprite N; sin F fija todos los flags como un bitfield."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "FSET"
relationships:
  - type: "related"
    target: "pico8.api.fget"
claims:
  - id: "pico8.api.fset.claim.1"
    statement: "FSET(n, [f], val) establece el valor del flag f del sprite n."
    evidence:
      locator: "6.2 Graphics > FSET"
      quote_or_paraphrase: "Get or set the value (VAL) of sprite N's flag F."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fset.claim.2"
    statement: "Cuando F se omite, todos los flags se recuperan o fijan como un único bitfield."
    evidence:
      locator: "6.2 Graphics > FSET"
      quote_or_paraphrase: "When F is omitted, all flags are retrieved/set as a single bitfield."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fset.claim.3"
    statement: "El manual muestra FSET(2, 1|2|8) que fija los bits 0, 1 y 3; FSET(2, 4, TRUE) fija el bit 4; y PRINT(FGET(2)) imprime 27 (1|2|8|16)."
    evidence:
      locator: "6.2 Graphics > FSET"
      quote_or_paraphrase: "FSET(2, 1 | 2 | 8) -- SETS BITS 0,1 AND 3 FSET(2, 4, TRUE) -- SETS BIT 4 PRINT(FGET(2)) -- 27 (1 | 2 | 8 | 16)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
fset(n, [f], val)
```

## Semántica

Escribe el valor de un flag de sprite. El valor es booleano (TRUE o FALSE); sin `f`, `val` se interpreta como bitfield que fija los 8 flags.

## Parámetros y retorno

- `n`: índice de sprite.
- `f` (opcional): índice de flag 0..7.
- `val`: TRUE, FALSE o un bitfield cuando se omite `f`.
- Retorno: no especificado por la fuente.

## Efectos y límites

El estado inicial de los flags se define en el editor de sprites; `fset` permite cambiarlo en tiempo de ejecución, por ejemplo para atributos o máscaras de mapa.

## Ejemplos relacionados

Ejemplo del manual: fijar bits con un bitfield o un flag concreto y leerlos con `fget`.

## Ambigüedades

Ninguna documentada.
