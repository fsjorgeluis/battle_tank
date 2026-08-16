---
schema_version: "1.0"
id: "pico8.concept.file-system"
kind: "concept"
title: "Sistema de archivos de PICO-8"
summary: "PICO-8 mantiene un drive virtual accesible por comandos de consola (LS, CD, MKDIR, FOLDER) y por funciones como LOAD/SAVE; se almacena en un directorio del sistema operativo que puede cambiarse en config.txt o reasignarse con -root_path y -home, y puede mapearse a un cloud drive."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "1.4 File System"
relationships:
  - type: "related"
    target: "pico8.api.load"
  - type: "related"
    target: "pico8.api.save"
  - type: "related"
    target: "pico8.concept.commandline-parameters"
  - type: "related"
    target: "pico8.api.extcmd"
claims:
  - id: "pico8.concept.file-system.claim.1"
    statement: "Los comandos de consola LS, CD BLAH, CD .., CD / y MKDIR BLAH gestionan archivos y directorios; FOLDER abre el directorio actual en el explorador del sistema operativo."
    evidence:
      locator: "1.4 File System"
      quote_or_paraphrase: "LS list the current directory; CD BLAH change directory; CD .. go up a directory; CD / change back to top directory (on PICO-8's virtual drive); MKDIR BLAH make a directory; FOLDER open the current directory in the host operating system's file browser"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.file-system.claim.2"
    statement: "LOAD y SAVE cargan/guardan un cartucho desde el directorio actual."
    evidence:
      locator: "1.4 File System"
      quote_or_paraphrase: "LOAD BLAH load a cart from the current directory; SAVE BLAH save a cart to the current directory"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.file-system.claim.3"
    statement: "Para mover, duplicar o borrar archivos hay que usar FOLDER y hacerlo en el sistema operativo."
    evidence:
      locator: "1.4 File System"
      quote_or_paraphrase: "If you want to move files around, duplicate them or delete them, use the FOLDER command and do it in the host operating system."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.file-system.claim.4"
    statement: "La ubicación por defecto del drive de PICO-8 es: Windows C:/Users/Yourname/AppData/Roaming/pico-8/carts, OSX /Users/Yourname/Library/Application Support/pico-8/carts, Linux ~/.lexaloffle/pico-8/carts."
    evidence:
      locator: "1.4 File System"
      quote_or_paraphrase: "The default location for PICO-8's drive is: Windows: C:/Users/Yourname/AppData/Roaming/pico-8/carts; OSX: /Users/Yourname/Library/Application Support/pico-8/carts; Linux: ~/.lexaloffle/pico-8/carts"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.file-system.claim.5"
    statement: "La ubicación puede cambiarse en pico-8/config.txt."
    evidence:
      locator: "1.4 File System"
      quote_or_paraphrase: "You can change this and other settings in pico-8/config.txt"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.file-system.claim.6"
    statement: "El directorio del drive puede mapearse a un cloud drive (Dropbox, Google Drive o similar) para crear un único disco compartido entre máquinas PICO-8 en distintos hosts."
    evidence:
      locator: "1.4 File System > Tip"
      quote_or_paraphrase: "The drive directory can be mapped to a cloud drive (provided by Dropbox, Google Drive or similar) in order to create a single disk shared between PICO-8 machines spread across different host machines."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El sistema de archivos es un drive virtual con comandos de consola para listar, navegar y crear directorios; los cartuchos se cargan y guardan desde el directorio actual con LOAD/SAVE. En disco se materializa en un directorio del SO, configurable en config.txt.

## Modelo mental

El "drive" de PICO-8 es conceptual: en realidad es un directorio real del SO. CD/..,/ actúan sobre esa jerarquía; FOLDER lo expone al explorador nativo para operaciones avanzadas. El almacenamiento puede ser volátil o sincronizado según dónde apunte.

## Consecuencias de implementación

- Para rutas de cartuchos en entornos multiusuario o CI, pasar `-home`/`-root_path` en lugar de asumir la ubicación por defecto (`derived` desde claim 4 y `pico8.concept.commandline-parameters`).
- Utilizar FOLDER como puente para gestionar archivos fuera del editor (`derived` desde claim 3).
- Para guardar mientras la app está en ejecución con cloud drive, tener en cuenta la sincronización del host (`derived` desde claim 6).

## Documentos relacionados

- `pico8.api.load` / `pico8.api.save` — contrapartes de runtime de LOAD/SAVE.
- `pico8.concept.commandline-parameters` — switches `-home` y `-root_path` para reasignar rutas.
- `pico8.api.extcmd` — `EXTCMD` para ejecutar comandos del sistema.

## Ambigüedades

El manual no detalla la semántica de las rutas relativas dentro del drive más allá de los comandos básicos; el comportamiento de `CD` con rutas largas o nombres con espacios no se especifica.