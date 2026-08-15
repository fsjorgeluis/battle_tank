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
---

## Contrato

```lua
print(str, x, y, [col])
print(str, [col])
```

## Semántica

Imprime una cadena en la posición dada, con color opcional. Sin coordenadas, escribe en la consola del shell con salto de línea al final (omitible con `\0`). Los códigos de control P8SCII y fuentes personalizadas se documentan en el Apéndice A.

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
