---
schema_version: "1.0"
id: "pico8.api.poke"
kind: "api"
title: "POKE"
summary: "Escribe uno o más bytes en una dirección de la RAM base (máx 8192 valores)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "POKE"
relationships:
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke2"
  - type: "related"
    target: "pico8.api.poke4"
  - type: "related"
    target: "pico8.api.memset"
  - type: "related"
    target: "pico8.constraint.poke-values-max"
  - type: "related"
    target: "pico8.constraint.ram-size"
claims:
  - id: "pico8.api.poke.claim.1"
    statement: "POKE(ADDR, VAL1, VAL2, ...) escribe uno o más bytes en una dirección de la RAM base."
    evidence:
      locator: "6.7 Memory > POKE"
      quote_or_paraphrase: "Write one or more bytes to an address in base ram."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.poke.claim.2"
    statement: "Si se proporciona más de un parámetro, se escriben secuencialmente (máx: 8192)."
    evidence:
      locator: "6.7 Memory > POKE"
      quote_or_paraphrase: "If more than one parameter is provided, they are written sequentially (max: 8192)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.poke.claim.3"
    statement: "El manual usa POKE para configurar registros de estado y re-mapeo de memoria, por ejemplo POKE(0x5f36, 0x10) y los valores de 0x5f54..0x5f57."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "The GFX, MAP and SCREEN memory areas can be reassigned by setting values at the following addresses: 0X5F54 ... 0X5F57"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
poke(addr, val1, val2, ...)
```

## Semántica

Escribe uno o más bytes en la dirección `addr` de la RAM base. Con varios parámetros, los escribe de forma secuencial en direcciones consecutivas.

## Parámetros y retorno

- `addr`: dirección en RAM base.
- `val1`, `val2`, ...: bytes a escribir; máximo 8192 valores.
- Retorno: no especificado por la fuente.

## Efectos y límites

POKE se usa para configurar registros del estado de dibujo (por ejemplo `0x5f36`) y el re-mapeo de GFX/MAP/SCREEN (`0x5f54`..`0x5f57`). El re-mapeo afecta a las funciones de acceso a memoria, incluido POKE.

## Ejemplos relacionados

El manual combina `POKE(0x5f36, 0x10)` con `POKE(0x5f5a, NEWVAL)` para configurar el valor fuera de rango de `mget`, y `POKE(0x5F38, 8)` para el enmascarado de `tline`.

## Ambigüedades

Ninguna documentada.
