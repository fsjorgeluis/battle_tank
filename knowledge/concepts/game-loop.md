---
schema_version: "1.0"
id: "pico8.concept.game-loop"
kind: "concept"
title: "Ciclo de juego PICO-8"
summary: "PICO-8 ejecuta _init, _update y _draw cuando están definidos; el bucle corre a 30fps (60fps con _update60, o cae a 15fps duplicando _update si _draw no llega a tiempo)."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "5 PICO-8 Program Structure"
relationships:
  - type: "related"
    target: "pico8.api.btnp"
  - type: "related"
    target: "pico8.api.btn"
  - type: "related"
    target: "pico8.constraint.cpu-throughput"
claims:
  - id: "pico8.concept.game-loop.claim.1"
    statement: "Al ejecutarse un programa, todo el código de los tabs se concatena (de izquierda a derecha) y se ejecuta."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "all of the code from tabs is concatenated (from left to right) and executed"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.2"
    statement: "_init() se llama una vez al arrancar el programa."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "_INIT() -- Called once on program startup."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.3"
    statement: "_update() se llama una vez por actualización a 30fps."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "_UPDATE() -- Called once per update at 30fps."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.4"
    statement: "_draw() se llama una vez por frame visible."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "_DRAW() -- Called once per visible frame"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.5"
    statement: "Si _draw no completa a tiempo, PICO-8 intenta correr a 15fps y llama a _update dos veces por frame visible para compensar."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "if it can not complete in time, PICO-8 will attempt to run at 15fps and call _UPDATE() twice per visible frame to compensate"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.6"
    statement: "Si se define _update60 en lugar de _update, PICO-8 corre en modo 60fps: _update60 y _draw se llaman a 60fps."
    evidence:
      locator: "5 PICO-8 Program Structure > Running PICO-8 at 60fps"
      quote_or_paraphrase: "both _UPDATE60() and _DRAW() are called at 60fps"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.7"
    statement: "En modo 60fps se dispone de la mitad de CPU por frame antes de caer a 30fps."
    evidence:
      locator: "5 PICO-8 Program Structure > Running PICO-8 at 60fps"
      quote_or_paraphrase: "half the PICO-8 CPU is available per frame before dropping down to 30fps"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.8"
    statement: "No todas las máquinas host pueden correr a 60fps; pueden solicitar 30 o 15fps aun sin superar la CPU, haciendo varias llamadas a _update60 por cada _draw."
    evidence:
      locator: "5 PICO-8 Program Structure > Running PICO-8 at 60fps"
      quote_or_paraphrase: "not all host machines are capable of running at 60fps ... multiple _UPDATE60 calls are made for every _DRAW call in the same way"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.9"
    statement: "El manual muestra un programa de ejemplo que define _init, _update y _draw y dibuja un círculo cuyo color cambia con btnp(5)."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "A simple program that uses all three might look this: ... IF (BTNP(5)) COL = 8 + RND(8) ... CIRCFILL(64,64,32,COL)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.game-loop.claim.10"
    statement: "Es posible proporcionar un bucle principal manual."
    evidence:
      locator: "5 PICO-8 Program Structure"
      quote_or_paraphrase: "It is possible to provide your own main loop manually."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El bucle es dirigido por PICO-8 mediante tres funciones opcionales (`_init`, `_update`, `_draw`). El programa del manual que usa las tres es:

```lua
function _init()
  -- always start on white
  col = 7
end

function _update()
  -- press x for a random colour
  if (btnp(5)) col = 8 + rnd(8)
end

function _draw()
  cls(1)
  circfill(64,64,32,col)
end
```

## Modelo mental

PICO-8 normalmente dirige el ciclo mediante callbacks opcionales: el autor puede definir `_init`, `_update` y `_draw`, o proporcionar un bucle principal manual. El código de todos los tabs se concatena y ejecuta como un único programa. El modo base es 30fps; definir `_update60` cambia a 60fps con la mitad de presupuesto de CPU por frame; si el dibujo no cabe, cae a 15fps duplicando las actualizaciones por frame visible.

## Consecuencias de implementación

- Leer la entrada desde `_update` o `_update60`: el estado que lee `btnp` se resetea al inicio de cada llamada (`derived` desde `pico8.api.btnp`).
- El presupuesto de CPU depende del modo: a 30fps hay más CPU por frame que a 60fps (`derived` desde `pico8.constraint.cpu-throughput`).
- No asumir que el host siempre alcanza 60fps; el juego debe ser jugable a 30 y 15fps (`derived` desde claim 8).

## Documentos relacionados

- `pico8.api.btnp` — estado de entrada reseteado al inicio de `_update`/`_update60`.
- `pico8.constraint.cpu-throughput` — presupuesto de cómputo por segundo.
- `pico8.api.btn` — lectura de botones en el bucle.

## Ambigüedades

Ninguna documentada.
