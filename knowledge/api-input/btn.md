---
schema_version: "1.0"
id: "pico8.api.btn"
kind: "api"
title: "BTN"
summary: "btn() devuelve el estado de un botón para un jugador, o un bitfield de los 12 botones de los jugadores 0 y 1."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.4 Input"
    anchor: "BTN"
relationships:
  - type: "related"
    target: "pico8.api.btnp"
  - type: "related"
    target: "pico8.constraint.controller-button-count"
claims:
  - id: "pico8.api.btn.claim.1"
    statement: "btn([b], [pl]) devuelve el estado del botón b para el jugador pl (por defecto 0)."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "Get button B state for player PL (default 0)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.2"
    statement: "b va de 0 a 5 y corresponde a izquierda, derecha, arriba, abajo, botón O y botón X."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "B: 0..5: left right up down button_o button_x"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.3"
    statement: "pl es el índice de jugador de 0 a 7."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "PL: player index 0..7"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.4"
    statement: "En lugar de un número, b puede ser un glifo de botón; en el editor de código se escribe con Shift-L R U D O X."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "it is also possible to use a button glyph. (In the coded editor, use Shift-L R U D O X)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.5"
    statement: "Sin parámetros, devuelve un bitfield de los 12 estados de botón de los jugadores 0 y 1: P0 en bits 0..5 y P1 en bits 8..13."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "If no parameters supplied, returns a bitfield of all 12 button states for player 0 & 1 // P0: bits 0..5 P1: bits 8..13"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.6"
    statement: "El mapeo de teclado por defecto del jugador 0 es: DPAD con cursores, O con Z C N y X con X V M."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "player 0: [DPAD]: cursors, [O]: Z C N   [X]: X V M"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.btn.claim.7"
    statement: "El mapeo de teclado por defecto del jugador 1 es: DPAD con SFED, O con LSHIFT y X con TAB W Q A."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "player 1: [DPAD]: SFED, [O]: LSHIFT  [X]: TAB W  Q A"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
btn([b] [, pl])
```

## Semántica

Devuelve el estado del botón `b` para el jugador `pl`. Con un botón concreto devuelve si está pulsado en este frame. Sin parámetros devuelve un bitfield con los 12 botones de los jugadores 0 y 1.

## Parámetros y retorno

- `b` (opcional): 0..5 (izquierda, derecha, arriba, abajo, O, X) o un glifo de botón. Sin parámetros, sin `b`.
- `pl` (opcional, por defecto 0): índice de jugador 0..7.
- Retorno: booleano si se pasa `b`; bitfield (P0 en bits 0..5, P1 en bits 8..13) si no se pasan parámetros. La fuente no especifica el tipo exacto del bitfield más allá de describir sus bits.

## Efectos y límites

- Lectura por frame; no distingue borde de pulsación (eso es `btnp`).
- Aunque PICO-8 acepta cualquier combinación, es físicamente imposible pulsar izquierda y derecha a la vez en un controlador; en algunos controladores arriba + izquierda/derecha es incómodo.
- Los botones de ratón pueden disparar `btn(4)..btn(6)` en el modo devkit (ver `pico8.concept.devkit-input`).

## Ejemplos relacionados

El programa de ejemplo del ciclo de juego usa `btnp` (no `btn`) para cambiar de color; el manual no muestra un ejemplo directo de `btn`.

## Ambigüedades

Ninguna documentada.
