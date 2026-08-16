---
schema_version: "1.0"
id: "pico8.constraint.ram-size"
kind: "constraint"
title: "Tamaño de la RAM base"
summary: "La RAM base de PICO-8 es de 64k y se accede con PEEK, POKE, MEMCPY y MEMSET."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
    anchor: "Base RAM Memory Layout"
relationships:
  - type: "related"
    target: "pico8.constraint.cart-rom-size"
  - type: "related"
    target: "pico8.constraint.lua-ram-size"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.memcpy"
  - type: "related"
    target: "pico8.constraint.screen-buffer-size"
claims:
  - id: "pico8.constraint.ram-size.claim.1"
    statement: "PICO-8 tiene 3 tipos de memoria: RAM base (64k), Cart ROM (32k) y Lua RAM (2MB); la RAM base se accede con PEEK, POKE, MEMCPY y MEMSET."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "PICO-8 has 3 types of memory: 1. Base RAM (64k): see layout below. Access with PEEK() POKE() MEMCPY() MEMSET() 2. Cart ROM (32k) ... 3. Lua RAM (2MB)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.ram-size.claim.2"
    statement: "El layout de la RAM base incluye: GFX (0x0), GFX2/MAP2 compartido (0x1000), MAP (0x2000), GFX FLAGS (0x3000), SONG (0x3100), SFX (0x3200), USER DATA (0x4300), CUSTOM FONT (0x5600 si existe), PERSISTENT CART DATA (0x5e00), DRAW STATE (0x5f00), HARDWARE STATE (0x5f40), GPIO PINS (0x5f80), SCREEN (0x6000) y USER DATA (0x8000)."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "0X0 GFX 0X1000 GFX2/MAP2 (SHARED) 0X2000 MAP 0X3000 GFX FLAGS 0X3100 SONG 0X3200 SFX 0X4300 USER DATA 0X5600 CUSTOM FONT 0X5E00 PERSISTENT CART DATA (256 BYTES) 0X5F00 DRAW STATE 0X5F40 HARDWARE STATE 0X5F80 GPIO PINS (128 BYTES) 0X6000 SCREEN (8K) 0x8000 USER DATA"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.ram-size.claim.3"
    statement: "Los datos de usuario no tienen un significado particular y pueden usarse para cualquier cosa vía MEMCPY, PEEK y POKE."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "User data has no particular meaning and can be used for anything via MEMCPY(), PEEK() & POKE()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.ram-size.claim.4"
    statement: "64k se interpreta como 65536 bytes (rango de direcciones 0x0..0xffff)."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "Base RAM (64k)"
    classification: "derived"
    confidence: "medium"
constraint:
  subject: "base ram"
  property: "size"
  operator: "fixed"
  value: "64"
  unit: "kibibytes"
  scope: "runtime memory system"
  enforcement: "base ram address space"
---

## Consecuencia práctica

La RAM base es el espacio de direcciones de `peek`, `poke`, `memcpy` y `memset`. El mapa ocupa la región 0x2000 por defecto y el framebuffer la 0x6000. Los datos de usuario (0x4300 y 0x8000) son libremente utilizables.

## Ambigüedades

Ninguna documentada.
