---
schema_version: "1.0"
id: "pico8.api.memcpy"
kind: "api"
title: "MEMCPY"
summary: "Copia LEN bytes de RAM base de source a dest, permitiendo secciones solapadas."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "MEMCPY"
relationships:
  - type: "related"
    target: "pico8.api.memset"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.reload"
  - type: "related"
    target: "pico8.api.cstore"
claims:
  - id: "pico8.api.memcpy.claim.1"
    statement: "MEMCPY(DEST_ADDR, SOURCE_ADDR, LEN) copia LEN bytes de RAM base de source a dest."
    evidence:
      locator: "6.7 Memory > MEMCPY"
      quote_or_paraphrase: "Copy LEN bytes of base ram from source to dest."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.memcpy.claim.2"
    statement: "Las secciones pueden solaparse."
    evidence:
      locator: "6.7 Memory > MEMCPY"
      quote_or_paraphrase: "Sections can be overlapping"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
memcpy(dest_addr, source_addr, len)
```

## Semántica

Copia `len` bytes dentro de la RAM base desde `source_addr` hacia `dest_addr`. Las regiones origen y destino pueden solaparse.

## Parámetros y retorno

- `dest_addr`: dirección de destino.
- `source_addr`: dirección de origen.
- `len`: número de bytes a copiar.
- Retorno: no especificado por la fuente.

## Efectos y límites

El re-mapeo de GFX/SCREEN afecta al acceso a memoria, incluido MEMCPY. Los datos de usuario (por ejemplo el área a partir de 0x4300) pueden usarse libremente con MEMCPY.

## Ejemplos relacionados

El manual menciona MEMCPY como uno de los accesos a RAM base junto a PEEK y POKE para los datos de usuario.

## Ambigüedades

Ninguna documentada.
