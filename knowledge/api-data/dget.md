---
schema_version: "1.0"
id: "pico8.api.dget"
kind: "api"
title: "DGET"
summary: "Obtiene el número almacenado en el índice INDEX (0..63) del slot CARTDATA."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.11 Cartridge Data"
    anchor: "DGET"
relationships:
  - type: "related-api"
    target: "pico8.api.cartdata"
  - type: "related-api"
    target: "pico8.api.dset"
  - type: "related"
    target: "pico8.constraint.cartdata-number-count"
claims:
  - id: "pico8.api.dget.claim.1"
    statement: "DGET(INDEX) obtiene el número almacenado en el índice INDEX (0..63)."
    evidence:
      locator: "6.11 Cartridge Data > DGET"
      quote_or_paraphrase: "Get the number stored at INDEX (0..63)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.dget.claim.2"
    statement: "DGET sólo debe usarse después de haber llamado a CARTDATA()."
    evidence:
      locator: "6.11 Cartridge Data > DGET"
      quote_or_paraphrase: "Use this only after you have called CARTDATA()"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
dget(index)
```

## Semántica

Lee el número almacenado en el índice `index` (0..63) del slot de datos permanente abierto con `cartdata()`.

## Parámetros y retorno

- `index`: índice 0..63 dentro del slot.
- Retorno: el número almacenado en `index`.

## Efectos y límites

Requiere una llamada previa a `cartdata()`. El slot almacena exactamente 64 números (256 bytes).

## Ejemplos relacionados

Ninguno explícito en la fuente para DGET; el manual la usa junto a DSET tras `cartdata()`.

## Ambigüedades

Ninguna documentada.
