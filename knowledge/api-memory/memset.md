---
schema_version: "1.0"
id: "pico8.api.memset"
kind: "api"
title: "MEMSET"
summary: "Escribe el valor de 8 bits VAL en memoria a partir de DEST_ADDR durante LEN bytes."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "MEMSET"
relationships:
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.constraint.screen-buffer-size"
claims:
  - id: "pico8.api.memset.claim.1"
    statement: "MEMSET(DEST_ADDR, VAL, LEN) escribe el valor de 8 bits VAL en memoria a partir de DEST_ADDR, durante LEN bytes."
    evidence:
      locator: "6.7 Memory > MEMSET"
      quote_or_paraphrase: "Write the 8-bit value VAL into memory starting at DEST_ADDR, for LEN bytes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.memset.claim.2"
    statement: "El manual muestra MEMSET(0x6000, 0xC8, 0x1000) para rellenar la mitad de la video memory con 0xC8."
    evidence:
      locator: "6.7 Memory > MEMSET"
      quote_or_paraphrase: "For example, to fill half of video memory with 0xC8: MEMSET(0x6000, 0xC8, 0x1000)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
memset(dest_addr, val, len)
```

## Semántica

Rellena `len` bytes consecutivos de la RAM base a partir de `dest_addr` con el mismo valor de 8 bits `val`.

## Parámetros y retorno

- `dest_addr`: dirección inicial de la RAM base.
- `val`: valor de 8 bits a escribir.
- `len`: número de bytes.
- Retorno: no especificado por la fuente.

## Efectos y límites

Útil para limpiar o prellenar regiones como el framebuffer (0x6000). El ejemplo del manual rellena la mitad de la video memory.

## Ejemplos relacionados

`MEMSET(0x6000, 0xC8, 0x1000)` rellena la mitad de la video memory con el valor 0xC8.

## Ambigüedades

Ninguna documentada.
