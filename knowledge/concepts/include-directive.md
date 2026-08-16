---
schema_version: "1.0"
id: "pico8.concept.include-directive"
kind: "concept"
title: "Directiva #INCLUDE"
summary: "#INCLUDE FILENAME inyecta código fuente en el arranque del cartucho (no en runtime) desde un .lua, una pestaña o todas las pestañas de otro cartucho."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "5.#INCLUDE"
    anchor: "_INCLUDE"
relationships:
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.concept.include-directive.claim.1"
    statement: "El código fuente puede inyectarse en un programa en el arranque del cartucho (pero no durante el runtime) usando '#INCLUDE FILENAME'."
    evidence:
      locator: "5.#INCLUDE"
      quote_or_paraphrase: "Source code can be injected into a program at cartridge boot (but not during runtime), using \"#INCLUDE FILENAME\""
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.include-directive.claim.2"
    statement: "FILENAME puede ser un archivo de texto (con código Lua), una pestaña de otro cartucho (#INCLUDE ONETAB.P8:1) o todas las pestañas de otro cartucho (#INCLUDE ALLTABS.P8)."
    evidence:
      locator: "5.#INCLUDE"
      quote_or_paraphrase: "FILENAME is either a plaintext file (containing Lua code), a tab from another cartridge, or all tabs from another cartridge"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.include-directive.claim.3"
    statement: "Al ejecutar el cartucho, el contenido de cada archivo incluido se trata como si se hubiera pegado en el editor en lugar de esa línea."
    evidence:
      locator: "5.#INCLUDE"
      quote_or_paraphrase: "When the cartridge is run, the contents of each included file is treated as if it had been pasted into the editor in place of that line."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.include-directive.claim.4"
    statement: "Los nombres de archivo son relativos al cartucho actual (hay que guardar primero); los includes no son recursivos; los límites normales de caracteres y tokens aplican."
    evidence:
      locator: "5.#INCLUDE"
      quote_or_paraphrase: "Filenames are relative to the current cartridge (so, need to save first); Includes are not performed recursively; Normal character count and token limits apply."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.include-directive.claim.5"
    statement: "Al guardar como .P8.PNG o exportar a binario, los archivos incluidos se aplatan y se guardan con el cartucho, sin dependencias externas."
    evidence:
      locator: "5.#INCLUDE"
      quote_or_paraphrase: "When a cartridge is saved as .P8.PNG, or exported to a binary, any included files are flattened and saved with the cartridge so that there are no external dependencies."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

`#INCLUDE` se procesa en el arranque del cartucho: inyecta un archivo `.lua`, una pestaña (`ARCHIVO.P8:1`) o todas las pestañas (`ARCHIVO.P8`). El código se comporta como si estuviera pegado en esa línea. Al guardar/exportar se aplana, de modo que el artefacto final no depende de archivos externos.

## Modelo mental

Es una macro textual de ensamblado en tiempo de arranque: compartir código entre cartuchos, editar con editor externo o usar un cartucho como herramienta que modifica datos.

## Consecuencias de implementación

- Hay que guardar el cartucho antes de usar rutas relativas (`derived` desde claim 4).
- Los límites de tokens y caracteres se cuentan con el código ya inyectado (`derived` desde claim 4).
- Los `.P8.PNG` y binarios exportados ya incluyen el código aplanado; no hace falta distribuir el `.lua` (`derived` desde claim 5).

## Documentos relacionados

- `pico8.concept.game-loop` — el código inyectado participa del ciclo de juego estándar.

## Ambigüedades

Ninguna documentada.
