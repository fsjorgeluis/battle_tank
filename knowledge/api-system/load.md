---
schema_version: "1.0"
id: "pico8.api.load"
kind: "api"
title: "LOAD"
summary: "Carga un cartucho (o cart BBS por id '#'), con breadcrumb y string de parámetros accesible por stat(6)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "LOAD"
relationships:
  - type: "related"
    target: "pico8.api.save"
  - type: "related"
    target: "pico8.api.run"
  - type: "related"
    target: "pico8.api.stat"
  - type: "related"
    target: "pico8.api.ls"
claims:
  - id: "pico8.api.load.claim.1"
    statement: "LOAD carga o guarda un cartucho; junto con SAVE permite la persistencia en disco."
    evidence:
      locator: "6.1 System > LOAD/SAVE"
      quote_or_paraphrase: "Load or save a cartridge"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.load.claim.2"
    statement: "Al cargar desde un cartucho en ejecución, el cargado se ejecuta inmediatamente con la string de parámetros PARAM_STR (accesible con stat(6)) y se inserta un ítem de menú llamado BREADCRUMB que devuelve al cartucho anterior."
    evidence:
      locator: "6.1 System > LOAD"
      quote_or_paraphrase: "When loading from a running cartridge, the loaded cartridge is immediately run with parameter string PARAM_STR (accessible with STAT(6)), and a menu item is inserted and named BREADCRUMB, that returns the user to the previous cartridge."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.load.claim.3"
    statement: "Los nombres de archivo que empiezan por '#' se toman como id de cart BBS que se descarga y ejecuta inmediatamente."
    evidence:
      locator: "6.1 System > LOAD"
      quote_or_paraphrase: "Filenames that start with '#' are taken to be a BBS cart id, that is immediately downloaded and run"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.load.claim.4"
    statement: "Si el id es el post padre del cartucho o no se especifica un número de revisión, se obtiene la última versión."
    evidence:
      locator: "6.1 System > LOAD"
      quote_or_paraphrase: "If the id is the cart's parent post, or a revision number is not specified, then the latest version is fetched."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.load.claim.5"
    statement: "Los carts BBS pueden cargarse desde otros carts BBS o locales, pero no desde carts exportados."
    evidence:
      locator: "6.1 System > LOAD"
      quote_or_paraphrase: "BBS carts can be loaded from other BBS carts or local carts, but not from exported carts."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
load(filename, [breadcrumb], [param_str])
```

## Semántica

Carga un cartucho en memoria. Cuando se invoca desde un cartucho en ejecución, el cartucho cargado corre de inmediato con la string de parámetros opcional y se añade un ítem de menú (breadcrumb) que permite volver al cartucho anterior.

## Parámetros y retorno

- `filename`: nombre de archivo, o id BBS con prefijo `#`.
- `breadcrumb` (opcional): etiqueta del ítem de menú para volver al cartucho anterior.
- `param_str` (opcional): string de parámetros accesible en tiempo de ejecución con `stat(6)`.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Cargar con `#` inicia una descarga BBS; no disponible desde carts exportados.
- El breadcrumb actual se puede leer con `stat(100)`.
- Las funciones del sistema pueden omitir paréntesis y comillas desde la línea de comandos: `LOAD BLAH.P8`.

## Ejemplos relacionados

`LOAD("#MYGAME_LEVEL2", "BACK TO MAP", "LIVES="..LIVES)` carga un cart BBS, inserta el breadcrumb "BACK TO MAP" y pasa el string `LIVES=<n>`.

## Ambigüedades

Ninguna documentada.
