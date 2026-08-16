---
schema_version: "1.0"
id: "pico8.api.folder"
kind: "api"
title: "FOLDER"
summary: "Abre la carpeta de carts en el sistema operativo host."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "FOLDER"
relationships:
  - type: "related"
    target: "pico8.api.ls"
  - type: "related"
    target: "pico8.api.printh"
  - type: "related"
    target: "pico8.api.extcmd"
claims:
  - id: "pico8.api.folder.claim.1"
    statement: "FOLDER abre la carpeta de carts en el sistema operativo host."
    evidence:
      locator: "6.1 System > FOLDER"
      quote_or_paraphrase: "Open the carts folder in the host operating system."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.folder.claim.2"
    statement: "FOLDER no recibe parámetros en la firma de la fuente."
    evidence:
      locator: "6.1 System > FOLDER"
      quote_or_paraphrase: "FOLDER"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.folder.claim.3"
    statement: "La carpeta de datos de usuario se abre con EXTCMD(\"FOLDER\") y por defecto coincide con la ruta del cartucho, o {pico-8 appdata}/appdata/appname para binarios exportados."
    evidence:
      locator: "6.1 System > Recording GIFs"
      quote_or_paraphrase: "The user data folder can be opened with EXTCMD(\"FOLDER\") and defaults to the same path as the cartridge, or {pico-8 appdata}/appdata/appname for exported binaries."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
folder()
```

## Semántica

Abre la carpeta de cartuchos de PICO-8 en el sistema operativo host, útil para localizar archivos escritos por herramientas como `PRINTH`.

## Parámetros y retorno

- Retorno: no especificado por la fuente.

## Efectos y límites

- Es la forma recomendada por el manual para localizar ficheros generados (por ejemplo, el PNG exportado por `EXPORT`).
- `EXTCMD("FOLDER")` abre la misma carpeta desde un cartucho en ejecución.

## Ejemplos relacionados

Tras `EXPORT BLAH.PNG`, el manual indica: "use the FOLDER command to locate the exported PNG".

## Ambigüedades

Ninguna documentada.
