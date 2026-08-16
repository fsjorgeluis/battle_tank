---
schema_version: "1.0"
id: "pico8.api.reload"
kind: "api"
title: "RELOAD"
summary: "Como MEMCPY pero copia desde la cart ROM; la sección de código (>= 0x4300) está protegida."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "RELOAD"
relationships:
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.api.cstore"
  - type: "related"
    target: "pico8.constraint.cart-rom-size"
claims:
  - id: "pico8.api.reload.claim.1"
    statement: "RELOAD(DEST_ADDR, SOURCE_ADDR, LEN, [FILENAME]) es como MEMCPY pero copia desde la cart ROM."
    evidence:
      locator: "6.7 Memory > RELOAD"
      quote_or_paraphrase: "Same as MEMCPY, but copies from cart rom."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reload.claim.2"
    statement: "La sección de código (>= 0x4300) está protegida y no puede leerse."
    evidence:
      locator: "6.7 Memory > RELOAD"
      quote_or_paraphrase: "The code section ( >= 0x4300) is protected and can not be read."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reload.claim.3"
    statement: "Si se especifica FILENAME, se cargan datos de un cartucho separado; el cartucho debe ser local, ya que los carts BBS no pueden leerse de este modo."
    evidence:
      locator: "6.7 Memory > RELOAD"
      quote_or_paraphrase: "If filename specified, load data from a separate cartridge. In this case, the cartridge must be local (BBS carts can not be read in this way)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reload.claim.4"
    statement: "PICO-8 copia automáticamente la cart ROM a la RAM base (es decir, llama RELOAD()) al cargar un cartucho, al ejecutarlo y al salir de cualquier modo editor; puede desactivarse con poke(0x5f37, 1)."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "PICO-8 automatically copies cart rom to base ram (i.e. calls RELOAD()) in 3 cases: 1. When a cartridge is loaded 2. When a cartridge is run 3. When exiting any of the editor modes // can turn off with: poke(0x5f37,1)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.reload.claim.5"
    statement: "La firma de RELOAD en el manual omite la coma entre SOURCE_ADDR y LEN (errata de fuente que no cambia el contrato)."
    evidence:
      locator: "6.7 Memory > RELOAD"
      quote_or_paraphrase: "RELOAD(DEST_ADDR, SOURCE_ADDR LEN, [FILENAME])"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
reload(dest_addr, source_addr, len, [filename])
```

## Semántica

Copia `len` bytes desde la cart ROM hacia la RAM base, con el mismo comportamiento de copia que MEMCPY. La cart ROM tiene el mismo layout que la RAM base hasta 0x4300.

## Parámetros y retorno

- `dest_addr`: dirección de destino en la RAM base.
- `source_addr`: dirección de origen en la cart ROM.
- `len`: número de bytes.
- `filename` (opcional): si se da, carga datos desde un cartucho separado (debe ser local; los carts BBS no pueden leerse así).
- Retorno: no especificado por la fuente.

## Efectos y límites

La sección de código (`>= 0x4300`) está protegida y no puede leerse. PICO-8 invoca este mecanismo automáticamente en tres casos (carga, ejecución y salida de editores) salvo que se desactive con `poke(0x5f37, 1)`.

## Ejemplos relacionados

El manual describe la copia automática cart ROM -> RAM base como una llamada a RELOAD() en tres casos, desactivable con `poke(0x5f37, 1)`.

## Ambigüedades

- Nota de fuente (errata tipográfica): la firma del manual aparece como `RELOAD(DEST_ADDR, SOURCE_ADDR LEN, [FILENAME])`, sin coma entre `SOURCE_ADDR` y `LEN`. No cambia el contrato: `RELOAD(DEST_ADDR, SOURCE_ADDR, LEN, [FILENAME])`.
