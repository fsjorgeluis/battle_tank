---
schema_version: "1.0"
id: "pico8.api.ls"
kind: "api"
title: "LS"
summary: "Lista archivos .p8 y .p8.png de un directorio; desde un cartucho en ejecución devuelve una tabla (o nil desde BBS)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "LS"
relationships:
  - type: "related"
    target: "pico8.api.folder"
  - type: "related"
    target: "pico8.api.load"
claims:
  - id: "pico8.api.ls.claim.1"
    statement: "LS lista los archivos .p8 y .p8.png del directorio dado, relativo al directorio actual."
    evidence:
      locator: "6.1 System > LS"
      quote_or_paraphrase: "List .p8 and .p8.png files in given directory (folder), relative to the current directory."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ls.claim.2"
    statement: "Los directorios terminan en barra ('foo/') en el resultado."
    evidence:
      locator: "6.1 System > LS"
      quote_or_paraphrase: "Items that are directories end in a slash (e.g. \"foo/\")."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ls.claim.3"
    statement: "Desde un cartucho en ejecución, LS sólo puede usarse localmente y devuelve una tabla de resultados; desde un cart BBS devuelve nil."
    evidence:
      locator: "6.1 System > LS"
      quote_or_paraphrase: "When called from a running cartridge, LS can only be used locally and returns a table of the results. When called from a BBS cart, LS returns nil."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.ls.claim.4"
    statement: "Los directorios sólo pueden resolverse dentro del disco virtual de PICO-8; LS(\"..\") desde la raíz resuelve a la raíz."
    evidence:
      locator: "6.1 System > LS"
      quote_or_paraphrase: "Directories can only resolve inside of PICO-8's virtual drive; LS(\"..\") from the root directory will resolve to the root directory."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
ls([directory])
```

## Semántica

Lista el contenido de un directorio dentro del disco virtual de PICO-8. Su comportamiento y tipo de retorno dependen del contexto de llamada (consola, cartucho local o cart BBS).

## Parámetros y retorno

- `directory` (opcional): directorio relativo al actual.
- Retorno: tabla de resultados cuando se llama desde un cartucho en ejecución local; `nil` desde un cart BBS; listado en consola cuando se invoca desde la línea de comandos.

## Efectos y límites

- El recorrido no escapa del disco virtual: `LS("..")` desde la raíz queda en la raíz.
- Desde cartuchos BBS no hay acceso al sistema de archivos local.

## Ejemplos relacionados

`LS` tras `CD DEMOS` lista los carts de ejemplo incluidos.

## Ambigüedades

Ninguna documentada.
