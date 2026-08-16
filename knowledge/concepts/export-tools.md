---
schema_version: "1.0"
id: "pico8.concept.export-tools"
kind: "concept"
title: "Exportadores / importadores (EXPORT/IMPORT)"
summary: "El comando EXPORT genera .png, .wav y aplicaciones html/binary desde el cartucho; el formato se infiere de la extensión. IMPORT importa spritesheets y etiquetas."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "3. Exporters / Importers"
    anchor: "_Exporters_"
relationships:
  - type: "related"
    target: "pico8.api.menuitem"
  - type: "related"
    target: "pico8.concept.include-directive"
claims:
  - id: "pico8.concept.export-tools.claim.1"
    statement: "El comando EXPORT genera png, wav y aplicaciones html y binarias; el formato de salida se infiere de la extensión del nombre de archivo."
    evidence:
      locator: "3. Exporters / Importers"
      quote_or_paraphrase: "The EXPORT command can be used to generate png, wav files and stand-alone html and native binary cartridge applications. The output format is inferred from the filename extension (e.g. .png)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.export-tools.claim.2"
    statement: "Los cartuchos exportados y datos pueden distribuirse libremente siempre que se tenga permiso del autor y contribuyentes."
    evidence:
      locator: "3. Exporters / Importers"
      quote_or_paraphrase: "You are free to distribute and use exported cartridges and data as you please, provided that you have permission from the cartridge author and contributors."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.export-tools.claim.3"
    statement: "IMPORT/EXPORT de .png espera 128x128 píxeles y ajusta colores a la paleta PICO-8 actual (spritesheet o etiqueta con -l)."
    evidence:
      locator: "3. Exporters / Importers > Sprite Sheet / Label (.png)"
      quote_or_paraphrase: "IMPORT BLAH.PNG -- expects 128x128 png and colour-fits to the PICO-8 palette ... Use the -l switch with IMPORT and EXPORT to instead read and write from the cartridge's label"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.export-tools.claim.4"
    statement: "EXPORT genera .html/.js (3.1), .bin para Windows/Linux 64/Mac/Raspberry Pi (3.2), y hasta 32 cartuchos pueden empaquetarse juntos (3.4)."
    evidence:
      locator: "3. Exporters / Importers"
      quote_or_paraphrase: "To generate a stand-alone html player ... EXPORT MYGAME.HTML ... To generate stand-alone executables for Windows, Linux (64-bit), Mac and Raspberry Pi: EXPORT MYGAME.BIN ... Up to 32 cartridges can be bundled together"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.export-tools.claim.5"
    statement: "Los cartuchos exportados no pueden cargar/ejecutar cartuchos del BBS, p. ej. LOAD(\"#FOO\")."
    evidence:
      locator: "3. Exporters / Importers"
      quote_or_paraphrase: "Exported cartridges are unable to load and run BBS cartridges e.g. via LOAD(\"#FOO\")"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.export-tools.claim.6"
    statement: "Desde el host, EXPORT puede ejecutarse en modo headless con el switch -export; los parámetros pasan como un único string en minúsculas."
    evidence:
      locator: "3. Exporters / Importers > 3.5 Running EXPORT from the host operating system"
      quote_or_paraphrase: "Use the -export switch when launching PICO-8 to run the exporter in headless mode ... pico8 mygame.p8 -export \"-i 32 -s 2 -c 12 mygame.bin dat0.p8 dat1.p8\""
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

`EXPORT` es el comando de distribución: `.png` (spritesheet/etiqueta/mapa/código), `.wav` (SFX o música), `.html`/`.js` (reproductor web, con `.wasm` opcional vía `-w`), `.bin` (binarios nativos) y cartuchos `.p8/.p8.png/.p8.rom`. `IMPORT` carga imágenes. El formato se infiere de la extensión y se admiten switches como `-f`, `-p`, `-w`, `-i`, `-s`, `-c`, `-e`, `-x`, `-y`, `-l`.

## Modelo mental

`EXPORT` es una herramienta de build: un comando del prompt cuyo modo se decide por extensión. No es una API de runtime (no se llama desde `_UPDATE`), salvo por los switches que configuran icono, transparencia o empaquetado de cartuchos extra.

## Consecuencias de implementación

- Para distribuir en web conviene `EXPORT -F MYGAME.HTML` (carpeta `mygame_html` con `index.html`), y `.wasm` si el host lo sirve por webserver (`derived` desde claim 4).
- Los binarios Windows exportan zips preservando metadatos de permisos; se recomienda distribuirlos tal cual (`derived`, nota de 3.2).
- Un cartucho exportado no puede saltar al BBS; los contenidos extra se acceden como archivos locales (`derived` desde claim 5).

## Documentos relacionados

- `pico8.api.menuitem` — el menú del sistema puede disparar exportación desde la cart.
- `pico8.concept.include-directive` — los includes se aplatan al exportar.

## Ambigüedades

El manual no ofrece una tabla canónica de todos los switches de `EXPORT`; se enumeran aquí los documentados en la sección 3 (source-limitation).
