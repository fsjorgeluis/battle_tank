---
schema_version: "1.0"
id: "pico8.api.poke2"
kind: "api"
title: "POKE2"
summary: "Versión de 16 bits de POKE: escribe un número en formato little-endian sin requisito de alineación."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "POKE2"
relationships:
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.peek2"
  - type: "related"
    target: "pico8.api.poke4"
claims:
  - id: "pico8.api.poke2.claim.1"
    statement: "POKE2(ADDR, VAL) es la versión de 16 bits de POKE: escribe un número (VAL) en formato little-endian."
    evidence:
      locator: "6.7 Memory > POKE2"
      quote_or_paraphrase: "16-bit and 32-bit versions of PEEK and POKE. Read and write one number (VAL) in little-endian format"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.poke2.claim.2"
    statement: "El formato de 16 bits es 0xffff.0000."
    evidence:
      locator: "6.7 Memory > POKE2"
      quote_or_paraphrase: "16 bit: 0xffff.0000"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.poke2.claim.3"
    statement: "ADDR no necesita estar alineado a límites de 2 bytes."
    evidence:
      locator: "6.7 Memory > POKE2"
      quote_or_paraphrase: "ADDR does not need to be aligned to 2 or 4-byte boundaries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
poke2(addr, val)
```

## Semántica

Escribe un número de 16 bits `val` en la dirección `addr` de la RAM base, en formato little-endian.

## Parámetros y retorno

- `addr`: dirección en RAM base.
- `val`: número (VAL) de 16 bits a escribir.
- Retorno: no especificado por la fuente.

## Efectos y límites

`addr` no necesita estar alineada a 2 bytes. El formato 16 bits es `0xffff.0000`.

## Ejemplos relacionados

Ninguno adicional en el manual.

## Ambigüedades

Ninguna documentada.
