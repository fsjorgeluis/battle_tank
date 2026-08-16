---
schema_version: "1.0"
id: "pico8.api.printh"
kind: "api"
title: "PRINTH"
summary: "Imprime una string en la consola del sistema operativo host; puede escribir a un archivo o al portapapeles ('@clip')."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "PRINTH"
relationships:
  - type: "related"
    target: "pico8.api.folder"
  - type: "related"
    target: "pico8.api.stat"
  - type: "related"
    target: "pico8.api.extcmd"
claims:
  - id: "pico8.api.printh.claim.1"
    statement: "PRINTH imprime una string en la consola del sistema operativo host para depurar."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "Print a string to the host operating system's console for debugging."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.printh.claim.2"
    statement: "Con FILENAME, la string se añade a un archivo del sistema host (en el directorio actual por defecto; use FOLDER para verlo)."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "If filename is set, append the string to a file on the host operating system (in the current directory by default -- use FOLDER to view)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.printh.claim.3"
    statement: "OVERWRITE true hace que el archivo se sobrescriba en lugar de añadir."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "Setting OVERWRITE to true causes that file to be overwritten rather than appended."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.printh.claim.4"
    statement: "SAVE_TO_DESKTOP true guarda en el escritorio en lugar de la ruta actual."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "Setting SAVE_TO_DESKTOP to true saves to the desktop instead of the current path."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.printh.claim.5"
    statement: "Un nombre de archivo '@clip' escribe en el portapapeles del host."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "Use a filename of \"@clip\" to write to the host's clipboard."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.printh.claim.6"
    statement: "stat(4) lee el portapapeles, pero su contenido sólo está disponible tras pulsar CTRL-V durante la ejecución (por seguridad)."
    evidence:
      locator: "6.1 System > PRINTH"
      quote_or_paraphrase: "Use stat(4) to read the clipboard, but the contents of the clipboard are only available after pressing CTRL-V during runtime (for security)."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
printh(str, [filename], [overwrite], [save_to_desktop])
```

## Semántica

Envía texto al sistema host: a la consola, a un archivo (añadiendo o sobrescribiendo) o al portapapeles. Es la herramienta de depuración estándar cuando `PRINT` no basta.

## Parámetros y retorno

- `str`: texto a imprimir.
- `filename` (opcional): archivo destino; `"@clip"` para el portapapeles.
- `overwrite` (opcional): si es true, sobrescribe en lugar de añadir.
- `save_to_desktop` (opcional): si es true, guarda en el escritorio.
- Retorno: no especificado por la fuente.

## Efectos y límites

- La lectura del portapapeles con `stat(4)` sólo funciona tras el CTRL-V del usuario.
- `FOLDER` abre el directorio donde se escriben los archivos por defecto.

## Ejemplos relacionados

`PRINTH("T=..T())` en un bucle de depuración; `PRINTH("DATA", "LOG.TXT", TRUE)` sobrescribe `log.txt`.

## Ambigüedades

Ninguna documentada.
