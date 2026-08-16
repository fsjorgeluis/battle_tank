---
schema_version: "1.0"
id: "pico8.concept.memory-remapping"
kind: "concept"
title: "Remapeo de GFX, MAP y SCREEN"
summary: "Las áreas GFX, MAP y SCREEN de la base RAM pueden reasignarse escribiendo en 0x5f54..0x5f57; el mapeo es de bajo nivel y afecta también a peek/poke/memcpy, actuando como punteros a una video RAM separada."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory > Remapping Graphics and Map Data"
relationships:
  - type: "related"
    target: "pico8.concept.memory-layout"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.api.reload"
claims:
  - id: "pico8.concept.memory-remapping.claim.1"
    statement: "Las áreas de memoria GFX, MAP y SCREEN pueden reasignarse con valores en 0x5f54..0x5f57: 0x5f54 GFX (0x00 por defecto o 0x60 para usar la memoria de screen como spritesheet), 0x5f55 SCREEN (0x60 por defecto o 0x00), 0x5f56 MAP (0x20 por defecto, o 0x10..0x2f, o 0x80 en adelante) y 0x5f57 MAP SIZE (ancho del mapa; 0 = 256, por defecto 128)."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "0x5F54 GFX: can be 0x00 (default) or 0x60 (use the screen memory as the spritesheet); 0x5F55 SCREEN: can be 0x60 (default) or 0x00 (use the spritesheet as screen memory); 0x5F56 MAP: can be 0x20 (default) or 0x10..0x2f, or 0x80 and above. 0x5F57 MAP SIZE: map width. 0 means 256. Defaults to 128."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-remapping.claim.2"
    statement: "Las direcciones se expresan en incrementos de 256 bytes: 0x20 significa 0x2000, 0x21 significa 0x2100, etc. Las direcciones de mapa 0x30..0x3f se interpretan como 0x10..0x1f (área de memoria compartida)."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "Addresses can be expressed in 256 byte increments. So 0x20 means 0x2000, 0x21 means 0x2100 etc. Map addresses 0x30..0x3f are taken to mean 0x10..0x1f (shared memory area)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-remapping.claim.3"
    statement: "Los datos del mapa sólo pueden estar contenidos en las regiones 0x1000..0x2fff y 0x8000..0xffff; la altura del mapa se determina como el mayor tamaño posible que quepa en la región dada."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "Map data can only be contained inside the memory regions 0x1000..0x2fff, 0x8000..0xffff, and the map height is determined to be the largest possible size that fits in the given region."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-remapping.claim.4"
    statement: "GFX y SCREEN pueden mapearse también a las ubicaciones altas 0x80, 0xA0, 0xC0, 0xE0, con la restricción de que MAP no puede solaparse con esa dirección; en tal caso el mapeo conflictivo de GFX y/o SCREEN vuelve a su mapeo por defecto."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "GFX and SCREEN addresses can additionally be mapped to upper memory locations 0x80, 0xA0, 0xC0, 0xE0, with the constraint that MAP can not overlap with that address (in this case, the conflicting GFX and/or SCREEN mappings are kicked back to their default mapping)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.memory-remapping.claim.5"
    statement: "El mapeo de GFX y SCREEN ocurre a bajo nivel y afecta también a las funciones de acceso a memoria (peek, poke, memcpy): los bloques de 8k que empiezan en 0x0 y 0x6000 pueden pensarse como punteros a una video RAM separada, y los valores en 0x5f54 y 0x5f56 alteran esos punteros."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data > technical note"
      quote_or_paraphrase: "GFX and SCREEN memory mapping happens at a low level which also affects memory access functions (peek, poke, memcpy). The 8k memory blocks starting at 0x0 and 0x6000 can be thought of as pointers to a separate video ram, and setting the values at 0X5F54 and 0X5F56 alters those pointers."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El remapeo se configura con cuatro bytes en 0x5f54..0x5f57. GFX y SCREEN pueden intercambiarse entre los bloques 0x0 y 0x6000; MAP puede apuntar a varias regiones con un ancho configurable; hay restricciones de solapamiento. El mapeo afecta a nivel de punteros de video RAM, incluyendo el acceso con peek/poke/memcpy.

## Modelo mental

GFX y SCREEN son punteros a dos bloques de 8k; cambiar 0x5f54/0x5f55 intercambia dónde se lee la spritesheet y dónde se escribe el framebuffer. MAP es un puntero a una región mayor con ancho configurable, limitado a las regiones 0x1000..0x2fff y 0x8000..0xffff.

## Consecuencias de implementación

- Para dibujar con sprites almacenados en la región de pantalla, mapear GFX a 0x60 y SCREEN a 0x00; el resto del flujo de dibujo es transparente (`derived` desde claim 1).
- Las direcciones de mapa escritas como 0x30..0x3f apuntan al área compartida (el quirk de la spritesheet/mapa); recordarlo al remapear (`derived` desde claim 2).
- El límite de la altura del mapa se deduce de la región y del ancho (0x5f57); planificar el mapa dentro de las regiones permitidas (`derived` desde claim 3).
- No asumir que peek/poke sobre 0x0..0x1fff o 0x6000..0x7fff acceden físicamente a esos bloques: el remapeo redirige el acceso ve memoria real (`derived` desde claim 5).

## Documentos relacionados

- `pico8.concept.memory-layout` — layout por defecto de la base RAM.
- `pico8.api.poke` / `pico8.api.peek` / `pico8.api.memcpy` — acceso a memoria afectado por el remapeo.
- `pico8.api.reload` — carga desde cart ROM a base RAM.

## Ambigüedades

El manual no especifica qué ocurre con el área de GFX del cart ROM (persistencia) cuando se remapea GFX en runtime, ni detalla los valores intermedios permitidos para 0x5f56 más allá de los rangos citados.