---
schema_version: "1.0"
id: "pico8.concept.devkit-input"
kind: "concept"
title: "Modo de entrada devkit (ratón y teclado)"
summary: "Ratón y teclado se habilitan con poke(0x5f2d, flags) y se leen con stat(30..39), de forma experimental."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.13 Mouse and Keyboard Input"
relationships:
  - type: "related"
    target: "pico8.api.btn"
claims:
  - id: "pico8.concept.devkit-input.claim.1"
    statement: "La entrada de ratón y teclado es experimental, aunque mayormente funciona en todas las plataformas."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "// EXPERIMENTAL -- but mostly working on all platforms"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.devkit-input.claim.2"
    statement: "El modo devkit se activa con poke(0x5f2d, flags): 0x1 habilita, 0x2 hace que los botones de ratón disparen btn(4)..btn(6), 0x4 bloquea el puntero para leer movimiento con stat(38) y stat(39)."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "POKE(0x5F2D, flags) -- 0x1 Enable, 0x2 Mouse buttons trigger btn(4)..btn(6), 0x4 Pointer lock (use stat 38..39 to read movements)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.devkit-input.claim.3"
    statement: "stat(30) es booleano: true cuando hay una pulsación de tecla disponible; stat(31) devuelve el carácter del teclado."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "STAT(30) -- (Boolean) True when a keypress is available. STAT(31) -- (String) character returned by keyboard."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.devkit-input.claim.4"
    statement: "stat(32) y stat(33) devuelven las coordenadas X e Y del ratón; stat(34) es un bitfield de botones del ratón; stat(36) es un evento de rueda."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "STAT(32) -- Mouse X. STAT(33) -- Mouse Y. STAT(34) -- Mouse buttons (bitfield). STAT(36) -- Mouse wheel event."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.devkit-input.claim.5"
    statement: "stat(38) y stat(39) devuelven movimiento relativo en píxeles del host y requieren el flag 0x4."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "STAT(38) -- Relative x movement (in host desktop pixels) -- requires flag 0x4. STAT(39) -- Relative y movement (in host desktop pixels) -- requires flag 0x4."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.devkit-input.claim.6"
    statement: "No todos los PICO-8 tienen ratón o teclado; en el BBS se recomienda que el control sea opcional y desactivado por defecto, y se muestra un aviso a los usuarios cuando el modo está habilitado."
    evidence:
      locator: "6.13 Mouse and Keyboard Input"
      quote_or_paraphrase: "not every PICO-8 will have a keyboard or mouse attached ... encouraged to make keyboard and/or mouse control optional and off by default ... a message is displayed to BBS users warning them"
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El modo devkit extiende la entrada más allá de los 6 botones del controlador mediante `poke(0x5f2d, flags)` y lecturas con `stat(30..39)`. Los contratos completos de `poke` y `stat` pertenecen a los dominios de memoria y sistema y quedan pendientes en el índice; aquí sólo se citan los hechos de la sección 6.13.

## Modelo mental

El control estándar son los 6 botones. Ratón y teclado son un modo opt-in experimental, pensado para herramientas y casos concretos, con advertencias explícitas para los usuarios del BBS.

## Consecuencias de implementación

- Si se usa este modo, conviene mantener el control estándar como opción por defecto (`derived` desde claim 6).
- El flag 0x2 conecta los botones de ratón con `btn(4)`..`btn(6)`, así que el código que lee botones con `btn` puede reutilizarse (`derived` desde claim 2).
- Los flags se combinan como suma/bitfield; el manual no detalla la sintaxis de combinación.

## Documentos relacionados

- `pico8.api.btn` — botones del controlador y bitfield; los botones de ratón pueden mapearse a `btn(4..6)`.
- Pendientes: contrato completo de `stat()` (dominio system) y de `poke()` (dominio memory).

## Ambigüedades

El manual marca el modo como "EXPERIMENTAL"; el comportamiento en hosts sin ratón/teclado depende del dispositivo y no está especificado por la fuente.
