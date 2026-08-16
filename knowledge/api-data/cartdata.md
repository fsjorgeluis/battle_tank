---
schema_version: "1.0"
id: "pico8.api.cartdata"
kind: "api"
title: "CARTDATA"
summary: "Abre un slot de almacenamiento permanente de hasta 256 bytes (64 números) identificado por ID."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.11 Cartridge Data"
    anchor: "CARTDATA"
relationships:
  - type: "related-api"
    target: "pico8.api.dget"
  - type: "related-api"
    target: "pico8.api.dset"
  - type: "related-api"
    target: "pico8.api.peek"
  - type: "related-api"
    target: "pico8.api.poke"
  - type: "related-api"
    target: "pico8.api.cstore"
  - type: "related-api"
    target: "pico8.api.reload"
  - type: "related"
    target: "pico8.constraint.persistent-cart-data-size"
  - type: "related"
    target: "pico8.constraint.cartdata-number-count"
  - type: "related"
    target: "pico8.constraint.cartdata-id-length"
claims:
  - id: "pico8.api.cartdata.claim.1"
    statement: "CARTDATA(ID) abre un slot de almacenamiento permanente indexado por ID, capaz de almacenar y recuperar hasta 256 bytes (64 números) con DSET() y DGET()."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "Opens a permanent data storage slot indexed by ID that can be used to store and retrieve up to 256 bytes (64 numbers) worth of data using DSET() and DGET()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.2"
    statement: "ID es un string de hasta 64 caracteres, con caracteres legales a..z, 0..9 y subrayado (_)."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "ID is a string up to 64 characters long ... Legal characters are a..z, 0..9 and underscore (_)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.3"
    statement: "CARTDATA devuelve true si los datos se cargaron, y false en caso contrario."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "Returns true if data was loaded, otherwise false."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.4"
    statement: "CARTDATA sólo puede llamarse una vez por ejecución del cartucho; por tanto sólo puede usarse un único slot de datos."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "CARTDATA can be called once per cartridge execution, and so only a single data slot can be used."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.5"
    statement: "Una vez fijado el ID, el área de memoria 0x5e00..0x5eff queda mapeada a almacenamiento permanente, accesible directamente o vía DGET()/DSET()."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "Once a cartdata ID has been set, the area of memory 0X5E00..0X5EFF is mapped to permanent storage, and can either be accessed directly or via DGET()/@DSET()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.6"
    statement: "No hace falta hacer flush de los datos escritos: se guardan automáticamente incluso si se modifican con POKE() en 0x5e00..0x5eff."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "There is no need to flush written data -- it is automatically saved to permanent storage even if modified by directly POKE()'ing 0X5E00..0X5EFF."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.7"
    statement: "CARTDATA permite guardar datos como puntuaciones o progreso y compartir datos entre cartuchos o versiones del cartucho."
    evidence:
      locator: "6.11 Cartridge Data"
      quote_or_paraphrase: "This can be used as a lightweight way to store things like high scores or to save player progress. It can also be used to share data across cartridges / cartridge versions."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.8"
    statement: "El manual muestra CARTDATA('ZEP_DARK_FOREST'); DSET(0, SCORE) como ejemplo."
    evidence:
      locator: "6.11 Cartridge Data > CARTDATA"
      quote_or_paraphrase: "CARTDATA('ZEP_DARK_FOREST'); DSET(0, SCORE)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.cartdata.claim.9"
    statement: "Para más de 256 bytes, la fuente remite a escribir directamente en el cartucho con CSTORE(), con la limitación de que los datos quedan ligados a esa versión del cartucho."
    evidence:
      locator: "6.11 Cartridge Data"
      quote_or_paraphrase: "If more than 256 bytes is needed, it is also possible to write directly to the cartridge using CSTORE(). The disadvantage is that the data is tied to that particular version of the cartridge."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
cartdata(id)
```

## Semántica

Abre un slot de almacenamiento permanente identificado por `id` para guardar hasta 256 bytes (64 números) con `dget()`/`dset()`. El área 0x5e00..0x5eff queda mapeada a almacenamiento permanente.

## Parámetros y retorno

- `id`: string de hasta 64 caracteres (a..z, 0..9, `_`), debe ser suficientemente único para no chocar con otros cartuchos.
- Retorno: `true` si los datos se cargaron, `false` en caso contrario.

## Efectos y límites

Sólo puede llamarse una vez por ejecución del cartucho (un único slot). Los datos se guardan automáticamente; también se conservan si se escriben directamente con `poke()` en 0x5e00..0x5eff.

## Ejemplos relacionados

```lua
cartdata("ZEP_DARK_FOREST")
dset(0, score)
```

## Ambigüedades

Ninguna documentada.
