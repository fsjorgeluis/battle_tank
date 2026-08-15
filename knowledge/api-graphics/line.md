---
schema_version: "1.0"
id: "pico8.api.line"
kind: "api"
title: "LINE"
summary: "Dibuja una línea de (x0, y0) a (x1, y1); sin el segundo punto usa el final de la última línea."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "LINE"
relationships:
  - type: "related"
    target: "pico8.api.rect"
  - type: "related"
    target: "pico8.api.fillp"
claims:
  - id: "pico8.api.line.claim.1"
    statement: "LINE(x0, y0, [x1, y1, [col]]) dibuja una línea de (x0, y0) a (x1, y1)."
    evidence:
      locator: "6.2 Graphics > LINE"
      quote_or_paraphrase: "Draw a line from (X0, Y0) to (X1, Y1)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.line.claim.2"
    statement: "Si (x1, y1) no se dan, se usa el final de la última línea dibujada."
    evidence:
      locator: "6.2 Graphics > LINE"
      quote_or_paraphrase: "If (X1, Y1) are not given, the end of the last drawn line is used."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.line.claim.3"
    statement: "LINE() sin parámetros hace que la siguiente llamada LINE(x1, y1) sólo fije los puntos finales sin dibujar."
    evidence:
      locator: "6.2 Graphics > LINE"
      quote_or_paraphrase: "LINE() with no parameters means that the next call to LINE(X1, Y1) will only set the end points without drawing."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.line.claim.4"
    statement: "El manual muestra un ejemplo que dibuja una figura de líneas en bucle con LINE."
    evidence:
      locator: "6.2 Graphics > LINE"
      quote_or_paraphrase: "CLS() LINE() FOR I=0,6 DO LINE(64+COS(I/6)*20, 64+SIN(I/6)*20, 8+I) END"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
line(x0, y0, [x1, y1, [col]])
```

## Semántica

Dibuja un segmento de línea. Sin el segundo extremo, continúa desde el extremo de la línea anterior; `line()` sin argumentos sólo prepara los puntos finales para la siguiente llamada.

## Parámetros y retorno

- `x0`, `y0`: punto inicial.
- `x1`, `y1` (opcionales): punto final.
- `col` (opcional): índice de color.
- Retorno: no especificado por la fuente.

## Efectos y límites

La llamada sin parámetros no dibuja; la siguiente llamada con sólo el punto final se limita a actualizar el extremo sin trazar.

## Ejemplos relacionados

El ejemplo del manual dibuja una figura cerrada de 6 lados con `LINE` dentro de un bucle.

## Ambigüedades

Ninguna documentada.
