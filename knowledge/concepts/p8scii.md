---
schema_version: "1.0"
id: "pico8.concept.p8scii"
kind: "concept"
title: "Códigos de control P8SCII"
summary: "Ciertos caracteres impresos con print() alteran el cursor, el estilo del texto o el estado de dibujo; incluyen códigos de control (chr 0..15), comandos especiales, modos de renderizado, escritura cruda a memoria y una fuente personalizable."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "7.1 Appendix A: P8SCII Control Codes"
relationships:
  - type: "related"
    target: "pico8.api.print"
  - type: "related"
    target: "pico8.api.chr"
  - type: "related"
    target: "pico8.api.poke"
  - type: "related"
    target: "pico8.concept.memory-layout"
claims:
  - id: "pico8.concept.p8scii.claim.1"
    statement: "Al imprimir con print(), algunos caracteres tienen un significado especial que altera la posición del cursor y el estilo de renderizado del texto."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes"
      quote_or_paraphrase: "When printed with PRINT (), some characters have a special meaning that can be used to alter things like the cursor position and text rendering style."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.2"
    statement: "Los caracteres de control de PICO-8 son CHR(0)..CHR(15) y pueden escribirse como secuencia escapada (p. ej. \"\\n\" para nueva línea)."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes"
      quote_or_paraphrase: "Control characters in PICO-8 are CHR(0)..CHR(15) and can be written as an escaped sequence (\"\\n\" for newline etc.)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.3"
    statement: "Los parámetros de los códigos usan un esquema que es superconjunto del hexadecimal: '0'..'f' significan 0..15 y los caracteres posteriores a 'f' también se aceptan ('g' = 16, etc.)."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes"
      quote_or_paraphrase: "Such parameters are written using a scheme that is a superset of hexadecimal format ... 'g' means 16 and so on."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.4"
    statement: "Los códigos de control incluyen: 0 termina la impresión, 1 repite el siguiente carácter P0 veces, 2 dibuja fondo sólido con color P0, 3/4/5 desplazan el cursor (horizontal, vertical o ambos), 6 es un comando especial, 7 audio, 8 retroceso, 9 tabulador, 'a' nueva línea, 'b' decora el carácter previo, 'c' fija el color de primer plano, 'd' retorno de carro, 'e' cambia a la fuente definida en 0x5600 y 'f' vuelve a la fuente por defecto."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Control Codes"
      quote_or_paraphrase: "0 \"\\0\" terminate printing; 1 \"\\*\" repeat next character P0 times; 2 \"\\#\" draw solid background with colour P0; 3 \"\\-\" shift cursor horizontally by P0-16; 4 \"\\|\" shift cursor vertically by P0-16; 5 \"\\+\" shift cursor by P0-16, P1-16; 6 \"\\^\" special command; 7 \"\\a\" audio; 8 \"\\b\" backspace; 9 \"\\t\" tab; a \"\\n\" newline; b \"\\v\" decorate previous character; c \"\\f\" set foreground colour; d \"\\r\" carriage return; e \"\\014\" switch to font defined at 0x5600; f \"\\015\" switch to default font"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.5"
    statement: "Los comandos especiales empiezan con \"\\^\" y toman hasta 2 parámetros (P0, P1); incluyen saltar 1..9 frames (1,2,4,8,16,32..256), cls con color P0, retardo de P0 frames por carácter, ir al home, fijar home, saltar a posición absoluta P0*4, P1*4, límite de wrap derecho, ancho de tab, subrayado, y ajustar ancho (por defecto 4) y alto (por defecto 6) de carácter."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Special Commands"
      quote_or_paraphrase: "1..9 skip 1,2,4,8,16,32..256 frames; c cls to colour P0, set cursor to 0,0; d set delay to P0 frames for every character printed; g set cursor position to home; h set home to cursor position; j jump to absolute P0*4, P1*4; r set rhs character wrap boundary to P0*4; s set tab stop width to P0 pixels; u underline; x set character width (default: 4); y set character height (default: 6)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.6"
    statement: "Los modos de renderizado se habilitan con \"\\^\" más el carácter y se deshabilitan prefijando con \"-\": w ancho (escala 2x1), t alto (1x2), = stripey (sólo píxeles pares cuando ancho/alto), p pinball (equivale a ancho+alto+stripey), i invertir, b borde (1px en izquierda y arriba, activo por defecto), '#' fondo sólido (inactivo por defecto, activado automáticamente por \"\\#\")."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Rendering mode options"
      quote_or_paraphrase: "// prefix these with \"-\" to disable: w wide mode: scales by 2x1; t tall mode: scales by 1x2; = stripey mode: when wide or tall, draw only even pixels; p pinball mode: equivalent to setting wide, tall and stripey; i invert; b border: toggle 1px padding on left and top // on by default; # solid background // off by default, but enabled automatically by \\#"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.7"
    statement: "Dos comandos escriben en memoria cruda con parámetros hex de 4 caracteres: \"@addrnnnn[binstr]\" hace poke de nnnn bytes a addr, y \"!addr[binstr]\" hace poke de todos los caracteres restantes a addr."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Raw memory writes"
      quote_or_paraphrase: "@addrnnnn[binstr] poke nnnn bytes to address addr; !addr[binstr] poke all remaining characters to address addr"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.8"
    statement: "Se pueden especificar caracteres en línea con \"\\^.\" seguido de 8 bytes de datos binarios, o \"\\^:\" seguido de 8 valores hexadecimales de 2 dígitos; cada byte es una fila de píxeles 1-bit con el bit bajo a la izquierda."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > One-off characters"
      quote_or_paraphrase: "Character data can be specified and printed in-line using \\^. followed by 8 bytes of raw binary data, or \\^: followed by 8 2-digit hexadecimal values ... each byte specifies a row of 1-bit pixel values, with the low bit on the left."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.9"
    statement: "Los contornos se dibujan con \"\\^o\" seguido del color y de 2 caracteres hex con el bitfield de vecinos; dibujar un contorno cuesta aproximadamente el doble de CPU que un carácter sin contorno."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > P8SCII Outlines"
      quote_or_paraphrase: "The outline command first draws each pixel of the character in up to 8 neighbouring positions given by an 8-bit bitfield ... Drawing an outline costs around twice as much cpu as drawing a non-outlined character."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.10"
    statement: "El comando de audio \"\\a\" reproduce datos de SFX: si no se indica índice, se selecciona automáticamente un sfx no activo entre 60..63; se pueden prefijar atributos de velocidad y loop y escribir notas a..g con sostenido/ bemol y octava, además de atributos de instrumento (por defecto 5), volumen (por defecto 5) y efecto (por defecto 0)."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "If an sfx index is not specified, a non-active sfx between 60..63 is selected automatically ... s P0 set the sfx speed; l P0 P1 set the sfx loop start and end points ... i P0 set the instrument (default: 5); v P0 set the volume (default: 5); x P0 set the effect (default: 0)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.11"
    statement: "El comando \"\\v\" decora el último carácter impreso con otro carácter a un desplazamiento dado y restaura la posición del cursor previa."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Decoration Characters"
      quote_or_paraphrase: "The control character \\v can be used to decorate the last printed character with another character at a given offset ... After the decorating character is printed, the previous cursor position is restored."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.12"
    statement: "Se puede definir una fuente personalizada en 0x5600 con 8 bytes por carácter × 256 caracteres = 2048 bytes; los primeros 128 bytes describen atributos (ancho, alto, offsets, flags y tab) y los caracteres 0..15 nunca se dibujan."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Custom Font"
      quote_or_paraphrase: "A custom font can be defined at 0x5600, consisting of 8 bytes per character * 256 characters = 2048 bytes ... The first 128 bytes (characters 0~15 are never drawn) describe attributes of the font"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8scii.claim.13"
    statement: "Los valores por defecto de los atributos de renderizado se pueden fijar escribiendo en 0x5f58..0x5f5b: 0x5f58 es un bitfield (padding, ancho, alto, fondo sólido, invertir, stripey, usar fuente personalizada), 0x5f59 char_w/char_h, 0x5f5a char_w2/tab_w y 0x5f5b offset_x/offset_y."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Default Attributes"
      quote_or_paraphrase: "it is possible to set their default values by writing to memory addresses 0x5f58..0x5f5b ... 0x5f58 // bitfield ... 0x5f59 char_w (low nibble), char_h (high) ... 0x5f5a char_w2 (low nibble), tab_w (high) ... 0x5f5b offset_x (low nibble), offset_y (high)"
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

P8SCII es el conjunto de códigos de control interpretados por `print()`. Los códigos `chr(0)..chr(15)` alteran el cursor y el estilo, hay comandos especiales (`\^...`), modos de renderizado, escritura cruda a memoria, caracteres en línea, contornos, audio, decoración y una fuente personalizada en `0x5600`. Los únicos efectos colaterales sobre el estado de dibujo son la posición del cursor y el color de primer plano; el resto de atributos se reinician en cada llamada a `print()`.

## Modelo mental

P8SCII convierte a `print()` en un mini-lenguaje de renderizado: el texto puede posicionarse, decorarse, escalarse, invertirse y escribir directamente en memoria o reproducir audio mediante secuencias de escape. La fuente personalizada y los valores por defecto de los atributos viven en la RAM base.

## Consecuencias de implementación

- Para textos con color de fondo o cursor desplazado, los códigos `\#`/`\f` y los desplazamientos `\-`/`\|`/`\+` evitan llamadas extra a `print()` (`derived` desde claim 4).
- Los contornos multiplican el coste de CPU por ~2 por carácter; usar con moderación en bucles de dibujo (`derived` desde claim 9).
- La fuente personalizada en `0x5600` compite por memoria con otros datos del cartucho; ver `pico8.concept.memory-layout` (`derived` desde claim 12).

## Documentos relacionados

- `pico8.api.print` — función que interpreta los códigos P8SCII.
- `pico8.api.chr` — genera los caracteres de control `chr(0)..chr(15)`.
- `pico8.api.poke` — escritura en RAM base para fuente personalizada y atributos por defecto.
- `pico8.concept.memory-layout` — ubicación de la fuente personalizada (0x5600) y registros 0x5f58..0x5f5b.

## Ambigüedades

La fuente no especifica el comportamiento de combinaciones arbitrarias de modos de renderizado (p. ej. varios activos a la vez además de `pinball`); sólo se documentan los modos que enuncia individualmente.
