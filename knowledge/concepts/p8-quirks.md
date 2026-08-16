---
schema_version: "1.0"
id: "pico8.concept.p8-quirks"
kind: "concept"
title: "Rarezas de PICO-8"
summary: "Gotchas documentados: la mitad inferior de la spritesheet y del mapa comparten memoria, los números tienen precisión y rango limitados, los arrays de Lua son 1-based por defecto, sin()/cos() usan 0..1 con sin invertido, y sgn(0) devuelve 1."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "5 Quirks of PICO-8"
relationships:
  - type: "related"
    target: "pico8.concept.memory-layout"
  - type: "related"
    target: "pico8.constraint.sprite-shared-count"
  - type: "related"
    target: "pico8.constraint.map-shared-size"
  - type: "related"
    target: "pico8.api.sin"
  - type: "related"
    target: "pico8.api.cos"
claims:
  - id: "pico8.concept.p8-quirks.claim.1"
    statement: "La mitad inferior de la spritesheet y la mitad inferior del mapa ocupan la misma memoria; conviene usar sólo una de las dos si no se entiende cómo funciona el solapamiento."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "The bottom half of the sprite sheet and bottom half of the map occupy the same memory. // Best use only one or the other if you're unsure how this works."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8-quirks.claim.2"
    statement: "Los números de PICO-8 tienen precisión y rango limitados: el paso mínimo entre números es aproximadamente 0.00002 (0x0.0001), con rango -32768 (-0x8000) a aproximadamente 32767.99999 (0x7fff.ffff)."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "PICO-8 numbers have limited accuracy and range; the minimum step between numbers is approximately 0.00002 (0x0.0001), with a range of -32768 (-0x8000) to approximately 32767.99999 (0x7fff.ffff)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8-quirks.claim.3"
    statement: "Sumar 1 a un contador cada frame desbordará alrededor de los 18 minutos."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "If you add 1 to a counter each frame, it will overflow after around 18 minutes!"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8-quirks.claim.4"
    statement: "Los arrays de Lua son 1-based por defecto, no 0-based; FOREACH empieza en TBL[1], no TBL[0]."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "Lua arrays are 1-based by default, not 0-based. FOREACH starts at TBL[1], not TBL[0]."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8-quirks.claim.5"
    statement: "cos() y sin() toman 0..1 en lugar de 0..PI*2, y sin() está invertido."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "COS() and SIN() take 0..1 instead of 0..PI*2, and SIN() is inverted."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.p8-quirks.claim.6"
    statement: "sgn(0) devuelve 1."
    evidence:
      locator: "5 Quirks of PICO-8"
      quote_or_paraphrase: "SGN(0) returns 1."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

La sección 5 del manual lista seis gotchas: solapamiento memoria spritesheet/mapa, precisión y rango numéricos limitados, desbordamiento de contadores en ~18 minutos a 30fps, arrays 1-based, `sin()`/`cos()` con entrada 0..1 y `sin` invertido, y `sgn(0) == 1`.

## Modelo mental

Son comportamientos documentados, no bugs: la máquina virtual prioriza simplicidad y determinismo sobre convenciones de Lua estándar o de matemática habitual. El solapamiento de memoria y el vacuidad numérica son los dos que más influyen en el diseño de datos.

## Consecuencias de implementación

- Para el solapamiento spritesheet/mapa, elegir una estrategia en diseño de datos: escribir en ambas mitades o reservar una región (`derived` desde claim 1).
- Con contadores largos (timers de minutos), usar valores más bajos o reiniciar antes de ~18 minutos a 30fps (`derived` desde claim 3).
- Para trigonometría, normalizar el ángulo a 0..1 y recordar que `sin` va invertido; en su lugar se puede usar `atan2` para angulaciones reales (`derived` desde claim 5).
- Recordar `sgn(0) == 1` al implementar control de velocidad/dirección con signo (`derived` desde claim 6).

## Documentos relacionados

- `pico8.concept.memory-layout` — dónde vive cada región de memoria compartida.
- `pico8.constraint.sprite-shared-count` / `pico8.constraint.map-shared-size` — tamaños del área compartida.
- `pico8.api.sin` / `pico8.api.cos` — semántica de parámetros 0..1.

## Ambigüedades

La sección es un resumen de "common gotchas"; no detalla el mecanismo interno del solapamiento ni los límites exactos más allá de los rangos citados.