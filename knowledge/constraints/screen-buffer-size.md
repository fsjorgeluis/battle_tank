---
schema_version: "1.0"
id: "pico8.constraint.screen-buffer-size"
kind: "constraint"
title: "Tamaño del buffer de pantalla"
summary: "La RAM base reserva 8k para el framebuffer de pantalla en 0x6000."
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
    target: "pico8.constraint.ram-size"
  - type: "related"
    target: "pico8.constraint.display-resolution"
  - type: "related"
    target: "pico8.api.memset"
  - type: "related"
    target: "pico8.api.peek"
claims:
  - id: "pico8.constraint.screen-buffer-size.claim.1"
    statement: "La RAM base incluye SCREEN (8K) en la dirección 0x6000."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "0X6000 SCREEN (8K)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.screen-buffer-size.claim.2"
    statement: "El formato de color (gfx/screen) es de 2 píxeles por byte: los bits bajos codifican el píxel izquierdo de cada par."
    evidence:
      locator: "6.7 Memory > Base RAM Memory Layout"
      quote_or_paraphrase: "Colour format (gfx/screen) is 2 pixels per byte: low bits encode the left pixel of each pair."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.screen-buffer-size.claim.3"
    statement: "Los bloques de memoria de 8k que empiezan en 0x0 y 0x6000 pueden pensarse como punteros a una RAM de video separada; los valores en 0x5f54 y 0x5f56 alteran esos punteros."
    evidence:
      locator: "6.7 Memory > Remapping Graphics and Map Data"
      quote_or_paraphrase: "The 8k memory blocks starting at 0x0 and 0x6000 can be thought of as pointers to a separate video ram, and setting the values at 0X5F54 and 0X5F56 alters those pointers."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "screen buffer"
  property: "size"
  operator: "fixed"
  value: "8"
  unit: "kibibytes"
  scope: "screen framebuffer"
  enforcement: "0x6000 screen region"
---

## Consecuencia práctica

El framebuffer de 0x6000..0x7fff almacena la pantalla de 128x128 píxeles a 2 píxeles por byte, es decir 8192 bytes (derived desde claims 1 y 2). El bloque de 0x0 (hoja de sprites) es otro buffer de 8k; ambos pueden intercambiarse con los punteros 0x5f54/0x5f56.

## Ambigüedades

Ninguna documentada.
