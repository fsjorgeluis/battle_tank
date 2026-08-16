---
schema_version: "1.0"
id: "pico8.concept.memory-layout"
kind: "concept"
title: "Mapeo de memoria base (Base RAM)"
summary: "PICO-8 tiene 3 memorias (Base RAM 64k, Cart ROM 32k y Lua RAM 2MB); la Base RAM tiene un layout fijo que va de GFX en 0x0 hasta SCREEN en 0x6000 y USER DATA en 0x8000, con solapamientos intencionados (GFX2/MAP2, custom font, persistent cart data)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory > Base RAM Memory Layout"
relationships:
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.constraint.ram-size"
  - type: "related"
    target: "pico8.constraint.persistent-cart-data-size"
  - type: "related"
    target: "pico8.concept.p8-quirks"
  - type: "related"
    target: "pico8.concept.memory-remapping"
claims:
  - id: "pico8.concept.memory-layout.claim.1"
    statement: "PICO-8 tiene 3 tipos de memoria: Base RAM de 64k (accesible con PEEK/POKE/MEMCPY/MEMSET), Cart ROM de 32k (mismo layout que base ram hasta 0x4300) y Lua RAM de 2MB (programa compilado y variables)."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "1. Base RAM (64k): see layout below. Access with PEEK() POKE() MEMCPY() MEMSET(); 2. Cart ROM (32k): same layout as base ram until 0x4300; 3. Lua RAM (2MB): compiled program + variables"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-layout.claim.2"
    statement: "El layout de la Base RAM es: 0x0 GFX, 0x1000 GFX2/MAP2 (compartido), 0x2000 MAP, 0x3000 GFX FLAGS, 0x3100 SONG, 0x3200 SFX, 0x4300 USER DATA, 0x5600 CUSTOM FONT (si se define), 0x5E00 PERSISTENT CART DATA (256 bytes), 0x5F00 DRAW STATE, 0x5F40 HARDWARE STATE, 0x5F80 GPIO PINS (128 bytes), 0x6000 SCREEN (8K) y 0x8000 USER DATA."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "0x0 GFX; 0x1000 GFX2/MAP2 (SHARED); 0x2000 MAP; 0x3000 GFX FLAGS; 0x3100 SONG; 0x3200 SFX; 0x4300 USER DATA; 0x5600 CUSTOM FONT (IF ONE IS DEFINED); 0x5E00 PERSISTENT CART DATA (256 BYTES); 0x5F00 DRAW STATE; 0x5F40 HARDWARE STATE; 0x5F80 GPIO PINS (128 BYTES); 0x6000 SCREEN (8K); 0x8000 USER DATA"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-layout.claim.3"
    statement: "Los datos de usuario no tienen significado particular y pueden usarse para cualquier cosa vía MEMCPY, PEEK y POKE."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "User data has no particular meaning and can be used for anything via MEMCPY(), PEEK() & POKE()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-layout.claim.4"
    statement: "Los persistent cart data están mapeados a 0x5e00..0x5eff pero sólo se almacenan si se ha llamado a CARTDATA()."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Persistent cart data is mapped to 0x5e00..0x5eff but only stored if CARTDATA() has been called."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-layout.claim.5"
    statement: "El formato de color (gfx/screen) es 2 píxeles por byte: los bits bajos codifican el píxel izquierdo de cada par. El formato del mapa es un byte por tile, donde cada byte normalmente codifica un índice de sprite."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Colour format (gfx/screen) is 2 pixels per byte: low bits encode the left pixel of each pair. Map format is one byte per tile, where each byte normally encodes a sprite index."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-layout.claim.6"
    statement: "El editor modifica el cart ROM, pero las funciones del API (SPR, SFX, etc.) operan sobre base RAM; PICO-8 copia automáticamente cart ROM a base RAM (RELOAD) al cargar un cartucho, al ejecutarlo o al salir de cualquier modo de edición, y puede desactivarse con poke(0x5f37,1)."
    evidence:
      locator: "6.7 Memory > Technical note"
      quote_or_paraphrase: "While using the editor, the data being modified is in cart rom, but api functions such as SPR() and SFX() only operate on base ram. PICO-8 automatically copies cart rom to base ram ... in 3 cases: 1. When a cartridge is loaded; 2. When a cartridge is run; 3. When exiting any of the editor modes // can turn off with: poke(0x5f37,1)"
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El layout completo de la Base RAM está documentado en 6.7 Memory > Base RAM Memory Layout. Hay tres memorias con propósitos distintos. La Base RAM tiene zonas especiales: el área GFX2/MAP2 compartida (origen del quirk de la spritesheet), el custom font opcional en 0x5600, los persistent cart data en 0x5e00 y el buffer de SCREEN en 0x6000.

## Modelo mental

Pensar la Base RAM como una ventana de 64k sobre el estado del cartucho: arriba los datos del juego (gfx, mapa, sprites, sfx), abajo el estado de dibujo y de hardware, el GPIO y el framebuffer. La Cart ROM es la copia persistente del cartridge; el runtime trabaja sobre una copia en base RAM que se recarga desde ROM en los momentos indicados.

## Consecuencias de implementación

- Para escribir datos de guardado persistentes, llamar a `CARTDATA()` primero; la zona 0x5e00..0x5eff sólo se conserva si se ha llamado (`derived` desde claim 4).
- El área GFX2/MAP2 compartida es la causa del quirk de la spritesheet; modelar los datos para no depender de ambas mitades simultáneamente (`derived` desde claim 2 y `pico8.concept.p8-quirks`).
- Las funciones de dibujo operan sobre base RAM; modificar datos para un frame requiere pokeear la base RAM, no el cart ROM (`derived` desde claim 6).
- El formato de 2 píxeles por byte en gfx/screen afecta a `peek`/`poke` sobre el framebuffer (`derived` desde claim 5).

## Documentos relacionados

- `pico8.api.peek` / `pico8.api.poke` / `pico8.api.memcpy` — acceso a base RAM.
- `pico8.constraint.ram-size` — tamaño de la base RAM.
- `pico8.constraint.persistent-cart-data-size` — tamaño de la zona persistente.
- `pico8.concept.p8-quirks` — consecuencias del solapamiento GFX2/MAP2.
- `pico8.concept.memory-remapping` — cómo reasignar las áreas GFX/MAP/SCREEN.

## Ambigüedades

El manual indica que el cart ROM comparte "el mismo layout que base ram hasta 0x4300"; el comportamiento de las zonas más allá de 0x4300 en el cart ROM (datos de usuario del cartucho guardado) no se detalla en esta sección.