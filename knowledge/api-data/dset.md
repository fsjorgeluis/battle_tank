---
schema_version: "1.0"
id: "pico8.api.dset"
kind: "api"
title: "DSET"
summary: "Fija el número almacenado en el índice INDEX (0..63) del slot CARTDATA."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.11 Cartridge Data"
    anchor: "DSET"
relationships:
  - type: "related-api"
    target: "pico8.api.cartdata"
  - type: "related-api"
    target: "pico8.api.dget"
  - type: "related"
    target: "pico8.constraint.cartdata-number-count"
claims:
  - id: "pico8.api.dset.claim.1"
    statement: "DSET(INDEX, VALUE) fija el número almacenado en el índice (0..63) del slot."
    evidence:
      locator: "6.11 Cartridge Data > DSET"
      quote_or_paraphrase: "Set the number stored at index (0..63)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.dset.claim.2"
    statement: "DSET sólo debe usarse después de haber llamado a CARTDATA()."
    evidence:
      locator: "6.11 Cartridge Data > DSET"
      quote_or_paraphrase: "Use this only after you have called CARTDATA()"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.dset.claim.3"
    statement: "El manual muestra CARTDATA('ZEP_DARK_FOREST'); DSET(0, SCORE) como ejemplo de guardado."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "CARTDATA('ZEP_DARK_FOREST'); DSET(0, SCORE)"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
dset(index, value)
```

## Semántica

Guarda el número `value` en el índice `index` (0..63) del slot de datos permanente abierto con `cartdata()`. No requiere flush: la escritura se persiste automáticamente.

## Parámetros y retorno

- `index`: índice 0..63 dentro del slot.
- `value`: número a guardar.
- Retorno: no especificado por la fuente.

## Efectos y límites

Requiere una llamada previa a `cartdata()`. El slot almacena exactamente 64 números (256 bytes).

## Ejemplos relacionados

```lua
cartdata("ZEP_DARK_FOREST")
dset(0, score)
```

## Ambigüedades

Ninguna documentada.
