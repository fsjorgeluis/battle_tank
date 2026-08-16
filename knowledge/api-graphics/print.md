---
schema_version: "1.0"
id: "pico8.api.print"
kind: "api"
title: "PRINT"
summary: "Imprime la cadena str en (x, y) con color opcional; sin coordenadas añade salto de línea y puede hacer scroll; devuelve la x más a la derecha impresa."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "PRINT"
relationships:
  - type: "related"
    target: "pico8.api.cursor"
  - type: "related"
    target: "pico8.api.color"
  - type: "related-api"
    target: "pico8.api.sfx"
claims:
  - id: "pico8.api.print.claim.1"
    statement: "PRINT(str, x, y, [col]) imprime la cadena str y opcionalmente fija el color de dibujo a col."
    evidence:
      locator: "6.2 Graphics > PRINT"
      quote_or_paraphrase: "Print a string STR and optionally set the draw colour to COL."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.2"
    statement: "Escrito en una sola línea, ? puede llamar a print sin paréntesis."
    evidence:
      locator: "6.2 Graphics > PRINT"
      quote_or_paraphrase: "written on a single line, ? can be used to call print without brackets: ?\"HI\""
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.3"
    statement: "Cuando x e y no se especifican, se añade un salto de línea automáticamente; puede omitirse terminando la cadena con un carácter de control \0."
    evidence:
      locator: "6.2 Graphics > PRINT"
      quote_or_paraphrase: "When X, Y are not specified, a newline is automatically appended. This can be omitted by ending the string with an explicit termination control character."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.4"
    statement: "Cuando x e y no se especifican, imprimir texto por debajo de 122 hace scroll en la consola; puede desactivarse durante la ejecución con POKE(0x5f36, 0x40)."
    evidence:
      locator: "6.2 Graphics > PRINT"
      quote_or_paraphrase: "when X, Y are not specified, printing text below 122 causes the console to scroll. This can be disabled during runtime with POKE(0x5f36,0x40)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.5"
    statement: "PRINT devuelve la posición x más a la derecha alcanzada al imprimir; se puede usar para conocer el ancho de un texto imprimiéndolo fuera de pantalla."
    evidence:
      locator: "6.2 Graphics > PRINT"
      quote_or_paraphrase: "PRINT returns the right-most x position that occurred while printing. This can be used to find out the width of some text by printing it off-screen: W = PRINT(\"HOGE\", 0, -20) -- returns 16"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.6"
    statement: "Los parámetros de los códigos de control P8SCII usan un esquema superconjunto del hexadecimal: '0'..'f' también significan 0..15, y los caracteres posteriores a 'f' también se aceptan ('g' significa 16, etc.); estos parámetros se escriben como P0, P1."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes"
      quote_or_paraphrase: "Some of the control codes below take parameters which are written using a scheme that is a superset of hexadecimal format. That is, '0'..'f' also mean 0..15. But characters after 'f' are also accepted: 'g' means 16 and so on."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.7"
    statement: "El código de control \\a reproduce audio: \"\\A\" solo produce un beep único y \"\\A12\" reproduce los datos existentes del SFX 12."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "?\"\\A\"   -- SINGLE BEEP ?\"\\A12\" -- PLAY EXISTING DATA AT SFX 12"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.8"
    statement: "Cuando \\a no especifica índice de SFX, se selecciona automáticamente un SFX no activo entre 60..63."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "If an sfx index is not specified, a non-active sfx between 60..63 is selected automatically."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.9"
    statement: "Para llenar el SFX con datos antes de la reproducción se anexan comandos tras \\a; los atributos de SFX deben aparecer una vez al inicio porque aplican a todo el sonido: 's P0' fija la velocidad del SFX y 'l P0 P1' fija los puntos de inicio y fin del bucle."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "To fill the SFX with data before playback, the following commands can then be appended. 1. (optional) SFX attributes must appear once at the start as they apply to the whole sound: s P0 set the sfx speed, l P0 P1 set the sfx loop start and end points"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.10"
    statement: "Las notas se escriben como a..g, opcionalmente seguidas de un sostenido '#' o un bemol '-' y el número de octava; las notas vacías se escriben con un punto."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "Note are written as a..g, optionally followed by a sharp # or flat -, and octave number. Empty notes Can be written with a dot"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.11"
    statement: "Los comandos de atributo de nota aplican a las notas siguientes: 'i P0' fija el instrumento (por defecto 5), 'v P0' fija el volumen (por defecto 5), 'x P0' fija el efecto (por defecto 0), y '<' y '>' aumentan o disminuyen el volumen en 1."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "i P0 set the instrument (default: 5), v P0 set the volume (default: 5), x P0 set the effect (default: 0), < > increase or decrease volume by 1"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.12"
    statement: "El manual muestra PRINT \"\\ACE-G\" que reproduce una tríada menor, y PRINT \"\\AC..E-..G\" que la reproduce staccato con notas vacías."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "PRINT \"\\ACE-G\" -- MINOR TRIAD / PRINT \"\\AC..E-..G\" -- STACCATO MINOR TRIAD"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.print.claim.13"
    statement: "El manual muestra PRINT \"\\AS4X5C1EGC2EGC3EGC4\" que reproduce un arpegio rápido (velocidad 4) y staccato (efecto 5) empezando en C1."
    evidence:
      locator: "7.1 Appendix A: P8SCII Control Codes > Audio"
      quote_or_paraphrase: "For example, to play a fast (speed 4), staccato (effect 5) arpeggio starting at C1: PRINT \"\\AS4X5C1EGC2EGC3EGC4\""
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
print(str, x, y, [col])
print(str, [col])
```

## Semántica

Imprime una cadena en la posición dada, con color opcional. Sin coordenadas, escribe en la consola del shell con salto de línea al final (omitible con `\0`). Los códigos de control P8SCII y fuentes personalizadas se documentan en el Apéndice A; además del formateo de texto, el código `\A` permite reproducir o escribir datos de SFX (velocidad, bucle, notas, instrumento, volumen, efecto) — véanse los claims 7-13.

## Parámetros y retorno

- `str`: cadena a imprimir.
- `x`, `y` (opcional en la segunda firma): posición del texto.
- `col` (opcional): color de dibujo.
- Retorno: la x más a la derecha alcanzada al imprimir.

## Efectos y límites

El modo consola (sin coordenadas) hace scroll al imprimir por debajo de y=122; el scroll se desactiva con POKE(0x5f36, 0x40) (dominio de memoria).

## Ejemplos relacionados

El manual muestra `W = PRINT("HOGE", 0, -20) -- returns 16` para medir el ancho de un texto.

## Ambigüedades

Ninguna documentada.
