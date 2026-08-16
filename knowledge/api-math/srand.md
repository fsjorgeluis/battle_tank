---
schema_version: "1.0"
id: "pico8.api.srand"
kind: "api"
title: "SRAND"
summary: "Fija la semilla del generador aleatorio; la semilla se aleatoriza al arrancar el cartucho."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.8 Math"
    anchor: "SRAND"
relationships:
  - type: "related-api"
    target: "pico8.api.rnd"
claims:
  - id: "pico8.api.srand.claim.1"
    statement: "SRAND(X) fija la semilla del generador de números aleatorios."
    evidence:
      locator: "6.8 Math > SRAND"
      quote_or_paraphrase: "Sets the random number seed."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.srand.claim.2"
    statement: "La semilla se aleatoriza automáticamente en el arranque del cartucho."
    evidence:
      locator: "6.8 Math > SRAND"
      quote_or_paraphrase: "The seed is automatically randomized on cart startup."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.srand.claim.3"
    statement: "El manual muestra SRAND(33) antes de un bucle de 100 PSET con RND(128)."
    evidence:
      locator: "6.8 Math > SRAND"
      quote_or_paraphrase: "FUNCTION _DRAW() CLS() SRAND(33) FOR I=1,100 DO PSET(RND(128),RND(128),7) END END"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
srand(x)
```

## Semántica

Fija la semilla del generador de números aleatorios usado por `rnd()`. Sin llamada explícita, la semilla se aleatoriza en el arranque del cartucho.

## Parámetros y retorno

- `x`: semilla.
- Retorno: no especificado por la fuente.

## Efectos y límites

Fijar la semilla produce secuencias deterministas de `rnd()`.

## Ejemplos relacionados

```lua
function _draw()
  cls()
  srand(33)
  for i=1,100 do
    pset(rnd(128), rnd(128), 7)
  end
end
```

## Ambigüedades

Ninguna documentada.
