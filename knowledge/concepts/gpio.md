---
schema_version: "1.0"
id: "pico8.concept.gpio"
kind: "concept"
title: "GPIO (pines de propósito general)"
summary: "Los bytes 0x5f80..0x5fff se mapean a pines GPIO según la plataforma host; permiten a la máquina comunicarse con otras máquinas."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.12 GPIO"
relationships:
  - type: "related"
    target: "pico8.api.serial"
  - type: "related"
    target: "pico8.api.poke"
claims:
  - id: "pico8.concept.gpio.claim.1"
    statement: "GPIO significa 'General Purpose Input Output' y permite a las máquinas comunicarse entre sí; PICO-8 mapea los bytes 0x5f80..0x5fff a pines gpio."
    evidence:
      locator: "6.12 GPIO"
      quote_or_paraphrase: "GPIO stands for \"General Purpose Input Output\", and allows machines to communicate with each other. PICO-8 maps bytes in the range 0x5f80..0x5fff to gpio pins"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.gpio.claim.2"
    statement: "El significado de los pines depende del host: en CHIP 0x5f80..0x5f87 mapean xio-p0..xio-p7; en Pocket CHIP 0x5f82..0x5f87 mapean GPIO1..GPIO6; en Raspberry Pi 0x5f80..0x5f9f mapean wiringPi pins 0..31."
    evidence:
      locator: "6.12 GPIO"
      quote_or_paraphrase: "CHIP: 0x5f80..0x5f87 mapped to xio-p0..xio-p7; Pocket CHIP: 0x5f82..0x5f87 mapped to GPIO1..GPIO6; Raspberry Pi: 0x5f80..0x5f9f mapped to wiringPi pins 0..31"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.gpio.claim.3"
    statement: "Los valores CHIP y Raspberry Pi son digitales: 0 (LOW) y 255 (HIGH)."
    evidence:
      locator: "6.12 GPIO"
      quote_or_paraphrase: "CHIP and Raspberry Pi values are all digital: 0 (LOW) and 255 (HIGH)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.gpio.claim.4"
    statement: "Las escrituras GPIO se almacenan en buffer y se envían al final de cada frame; SERIAL() permite temporización más precisa."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "GPIO writes are buffered and dispatched at the end of each frame ... For more precise timing, the SERIAL() command can be used"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.gpio.claim.5"
    statement: "Los cartuchos exportados como HTML/.js representan los pines gpio mediante una array global de enteros pico8_gpio que el shell HTML debe definir."
    evidence:
      locator: "6.12 GPIO > HTML"
      quote_or_paraphrase: "Cartridges exported as HTML / .js use a global array of integers (pico8_gpio) ... The shell HTML should define the array: var pico8_gpio = Array(128);"
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El rango de memoria `0x5f80..0x5fff` se interpreta como pines GPIO. La correspondencia física depende del host (CHIP, Pocket CHIP, Raspberry Pi); los valores son digitales `0`/`255` en CHIP y Raspberry Pi. Para temporización precisa se usa `SERIAL()`; en exportaciones web los pines se exponen vía `pico8_gpio` en el shell HTML.

## Modelo mental

GPIO es la vía de PICO-8 hacia el mundo físico o hacia el host: se lee y escribe a través del espacio de memoria (`POKE`/`PEEK`), y el runtime se encarga de despachar los valores al final de cada frame.

## Consecuencias de implementación

- Para LED/switches basta `POKE`/`PEEK`; para streams con temporización se prefiere `SERIAL` (`derived` desde claim 4).
- En web hay que definir `pico8_gpio` en el shell para que los pines funcionen (`derived` desde claim 5).
- El contrato completo de `SERIAL` vive en `pico8.api.serial`; el de `POKE` en el dominio memory.

## Documentos relacionados

- `pico8.api.serial` — canales de GPIO y bytestreams con temporización precisa.
- `pico8.api.poke` — escritura en memoria (dominio memory).

## Ambigüedades

El manual avisa de la diferencia de indexado BCM vs WiringPi en Raspberry Pi; los mapeos exactos por modelo quedan remitidos a wiringpi.com y no se verifican aquí.
