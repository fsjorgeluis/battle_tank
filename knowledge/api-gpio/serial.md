---
schema_version: "1.0"
id: "pico8.api.serial"
kind: "api"
title: "SERIAL"
summary: "Envía bytestreams a pines GPIO o canales host con temporización precisa; 64k/sec máximo; canales 0x800..0x807 para archivos/streams del SO."
status: "ambiguous"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.12 GPIO"
    anchor: "SERIAL"
relationships:
  - type: "related"
    target: "pico8.concept.gpio"
  - type: "related"
    target: "pico8.api.peek"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.api.stat"
claims:
  - id: "pico8.api.serial.claim.1"
    statement: "SERIAL(CHANNEL, ADDRESS, LENGTH) permite temporización más precisa que el bit-banging manual con POKE, porque los escritos GPIO se bufferizan y se despachan al final de cada frame."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "For more precise timing, the SERIAL() command can be used. GPIO writes are buffered and dispatched at the end of each frame, allowing clock cycling at higher and/or more regular speeds than is possible by manually bit-banging using POKE() calls."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.2"
    statement: "Los canales 0x000..0x0fe corresponden a números de pin GPIO; se envía 0x00 para LOW o 0xFF para HIGH."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "0x000..0x0fe corresponds to gpio pin numbers; send 0x00 for LOW or 0xFF for HIGH"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.3"
    statement: "El canal 0x0ff es un retardo: LENGTH se interpreta como 'duración' en microsegundos (sin contar overhead)."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "0x0ff delay; length is taken to mean \"duration\" in microseconds (excl. overhead)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.4"
    statement: "El canal 0x400..0x401 corresponde a tiras de LEDs ws281x (experimental)."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "0x400..0x401 ws281x LED string (experimental)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.5"
    statement: "ADDRESS es la ubicación de memoria PICO-8 de la que leer o a la que escribir; LENGTH es el número de bytes a enviar, permitiéndose octavos para bits parciales."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "ADDRESS: The PICO-8 memory location to read from / write to. LENGTH: Number of bytes to send. 1/8ths are allowed to send partial bit strings."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.6"
    statement: "Hay canales adicionales para bytestreams hacia y desde el sistema operativo host, pensados sobre todo para entornos tipo UNIX al desarrollar toolchains."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "Additional channels are available for bytestreams to and from the host operating system. These are intended to be most useful for UNIX-like environments while developing toolchains"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.7"
    statement: "La tasa de transferencia máxima en todos los casos es 64k/sec y bloquea la CPU."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "Maximum transfer rate in all cases is 64k/sec (blocks cpu)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.8"
    statement: "Los canales host son: 0x800 archivo soltado (stat(120) true cuando hay datos), 0x802 imagen soltada (stat(121) true cuando hay datos), 0x804 stdin, 0x805 stdout, 0x806 archivo dado con 'pico8 -i', 0x807 archivo dado con 'pico8 -o'."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "0x800 dropped file // stat(120) returns TRUE when data is available | 0x802 dropped image // stat(121) returns TRUE when data is available | 0x804 stdin | 0x805 stdout | 0x806 file specified with: pico8 -i filename | 0x807 file specified with: pico8 -o filename"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.9"
    statement: "Las imágenes soltadas aparecen en el canal 0x802 como un bytestream: los primeros 4 bytes son ancho y alto (2 bytes cada uno, little-endian, como PEEK2) y después la imagen en orden de lectura, un byte por píxel, con colores ajustados a la paleta de pantalla en el momento del drop."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "The first 4 bytes are the image's width and height (2 bytes each little-endian, like PEEK2), followed by the image in reading order, one byte per pixel, colour-fitted to the display palette at the time the file was dropped."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.10"
    statement: "El texto principal indica que los canales de bytestream no están disponibles mientras se ejecuta un cart BBS o un cart exportado."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "are not available while running a BBS or exported cart [1]"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.serial.claim.11"
    statement: "La nota [1] aclara que los canales 0x800 y 0x802 SÍ están disponibles en binarios exportados, pero con un tamaño máximo de archivo de 256k, o 128x128 para imágenes."
    evidence:
      locator: "6.12 GPIO > Serial (nota [1])"
      quote_or_paraphrase: "[1] Channels 0x800 and 0x802 are available from exported binaries, but with a maximum file size of 256k, or 128x128 for images."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
serial(channel, address, length)
```

## Semántica

Envía un bytestream con temporización precisa: a pines GPIO, a tiras ws281x o a canales del sistema operativo host. Los escritos se bufferizan y despachan al final de cada frame.

## Parámetros y retorno

- `channel`: canal destino (pines 0x000..0x0fe, retardo 0x0ff, ws281x 0x400..0x401, host 0x800..0x807).
- `address`: ubicación de memoria PICO-8 a leer o escribir.
- `length`: número de bytes a enviar (se permiten octavos).
- Retorno: no especificado por la fuente.

## Efectos y límites

- Tasa máxima 64k/sec en todos los casos; el envío bloquea la CPU.
- En binarios exportados, los canales 0x800/0x802 tienen límite de 256k (o 128x128 para imágenes).

## Ejemplos relacionados

El manual muestra cómo enviar un byte bit a bit a una tira APA102 usando `POKE(0x4300, 0)`, `POKE(0x4301, 0xFF)` y ciclos de `SERIAL(DAT, ...)` / `SERIAL(0xFF, 5)` de retardo.

## Ambigüedades

El texto principal de 6.12 afirma que los canales de bytestream "no están disponibles mientras se ejecuta un BBS o un cart exportado", pero la nota [1] indica que 0x800 y 0x802 sí están disponibles desde binarios exportados con límites de tamaño. Ambas afirmaciones se documentan sin resolver por suposición: el caso BBS es claro (no disponibles), el caso de cartucho exportado es ambiguo respecto a qué canales exactos y qué restricciones aplican.
