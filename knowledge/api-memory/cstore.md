---
schema_version: "1.0"
id: "pico8.api.cstore"
kind: "api"
title: "CSTORE"
summary: "Como MEMCPY pero copia de RAM base a cart ROM; hasta 64 cartuchos por sesión."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "CSTORE"
relationships:
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.api.reload"
  - type: "related"
    target: "pico8.constraint.cart-write-session-limit"
claims:
  - id: "pico8.api.cstore.claim.1"
    statement: "CSTORE(DEST_ADDR, SOURCE_ADDR, LEN, [FILENAME]) es como MEMCPY pero copia de la RAM base a la cart ROM."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "Same as memcpy, but copies from base ram to cart rom."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cstore.claim.2"
    statement: "CSTORE() es equivalente a CSTORE(0, 0, 0x4300)."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "CSTORE() is equivalent to CSTORE(0, 0, 0x4300)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cstore.claim.3"
    statement: "La sección de código (>= 0x4300) está protegida y no puede escribirse."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "The code section ( >= 0x4300) is protected and can not be written to."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cstore.claim.4"
    statement: "Si se especifica FILENAME, los datos se escriben directamente en ese cartucho en disco."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "If FILENAME is specified, the data is written directly to that cartridge on disk."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cstore.claim.5"
    statement: "Hasta 64 cartuchos pueden escribirse en una sesión."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "Up to 64 cartridges can be written in one session."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cstore.claim.6"
    statement: "El manual remite a la sección 'Cartridge Data' para más información sobre la escritura de cartuchos."
    evidence:
      locator: "6.7 Memory > CSTORE"
      quote_or_paraphrase: "See Cartridge Data for more information."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cstore(dest_addr, source_addr, len, [filename])
```

## Semántica

Copia `len` bytes desde la RAM base hacia la cart ROM, con el mismo comportamiento de copia que MEMCPY. Sin argumentos equivale a `cstore(0, 0, 0x4300)`.

## Parámetros y retorno

- `dest_addr`: dirección de destino en la cart ROM.
- `source_addr`: dirección de origen en la RAM base.
- `len`: número de bytes.
- `filename` (opcional): si se da, los datos se escriben directamente en ese cartucho en disco.
- Retorno: no especificado por la fuente.

## Efectos y límites

La sección de código (`>= 0x4300`) está protegida y no puede escribirse. Con `filename` se pueden escribir hasta 64 cartuchos en una sesión. El contrato de datos del cartucho se detalla en 'Cartridge Data'.

## Ejemplos relacionados

`CSTORE()` sin argumentos guarda el contenido por defecto de la cart ROM (equivalente a `CSTORE(0, 0, 0x4300)`).

## Ambigüedades

- Nota de dominio cruzado: el contrato completo de escritura de cartuchos ('Cartridge Data', sección 6.11) pertenece a la fase data-math; se registra pendiente en el índice.
