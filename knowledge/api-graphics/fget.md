---
schema_version: "1.0"
id: "pico8.api.fget"
kind: "api"
title: "FGET"
summary: "Obtiene el valor del flag F del sprite N; sin F recupera todos los flags como un bitfield."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.2 Graphics"
    anchor: "FGET"
relationships:
  - type: "related"
    target: "pico8.api.fset"
claims:
  - id: "pico8.api.fget.claim.1"
    statement: "FGET(n, [f]) obtiene el valor del flag f del sprite n."
    evidence:
      locator: "6.2 Graphics > FGET"
      quote_or_paraphrase: "Get or set the value (VAL) of sprite N's flag F."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fget.claim.2"
    statement: "F es el índice de flag 0..7 y VAL es TRUE o FALSE."
    evidence:
      locator: "6.2 Graphics > FGET"
      quote_or_paraphrase: "F is the flag index 0..7. VAL is TRUE or FALSE."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fget.claim.3"
    statement: "El estado inicial de los flags 0..7 se puede fijar en el editor de sprites; permite atributos de sprite personalizados y dibujar un subconjunto de tiles del mapa con una máscara en MAP()."
    evidence:
      locator: "6.2 Graphics > FGET"
      quote_or_paraphrase: "The initial state of flags 0..7 are settable in the sprite editor, so can be used to create custom sprite attributes. It is also possible to draw only a subset of map tiles by providing a mask in MAP()."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.fget.claim.4"
    statement: "Cuando F se omite, todos los flags se recuperan como un único bitfield."
    evidence:
      locator: "6.2 Graphics > FGET"
      quote_or_paraphrase: "When F is omitted, all flags are retrieved/set as a single bitfield."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
fget(n, [f])
```

## Semántica

Devuelve el valor booleano del flag `f` del sprite `n`. Sin `f`, devuelve los 8 flags como un único bitfield.

## Parámetros y retorno

- `n`: índice de sprite.
- `f` (opcional): índice de flag 0..7.
- Retorno: booleano con `f`; bitfield de los flags sin `f`.

## Efectos y límites

Los flags son útiles como atributos arbitrarios de sprite y para filtrar tiles en `MAP()`. La máscara de MAP es una nota transversal del dominio de mapa.

## Ejemplos relacionados

El manual ilustra la lectura con flags fijados por `fset`: `PRINT(FGET(2)) -- 27`.

## Ambigüedades

Ninguna documentada.
