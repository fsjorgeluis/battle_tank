---
schema_version: "1.0"
id: "pico8.api.menuitem"
kind: "api"
title: "MENUITEM"
summary: "Añade o actualiza un ítem del menú de pausa (índice 1..5, etiqueta hasta 16 caracteres) con callback; bits 0xff00 del índice filtran botones."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.9 Custom Menu Items"
    anchor: "MENUITEM"
relationships:
  - type: "related"
    target: "pico8.api.btn"
  - type: "related"
    target: "pico8.api.dset"
  - type: "related"
    target: "pico8.api.printh"
claims:
  - id: "pico8.api.menuitem.claim.1"
    statement: "MENUITEM añade o actualiza un ítem del menú de pausa."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "Add or update an item to the pause menu."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.2"
    statement: "INDEX debe estar entre 1 y 5 y determina el orden de visualización del ítem."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "INDEX should be 1..5 and determines the order each menu item is displayed."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.3"
    statement: "LABEL debe ser una string de hasta 16 caracteres."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "LABEL should be a string up to 16 characters long"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.4"
    statement: "CALLBACK se llama cuando el usuario selecciona el ítem; si devuelve true, el menú de pausa permanece abierto."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "CALLBACK is a function called when the item is selected by the user. If the callback returns true, the pause menu remains open."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.5"
    statement: "Cuando no se suministra etiqueta ni función, el ítem del menú se elimina."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "When no label or function is supplied, the menu item is removed."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.6"
    statement: "El callback recibe un único argumento: un bitfield de pulsaciones de los botones L, R y X."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "The callback takes a single argument that is a bitfield of L,R,X button presses."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.7"
    statement: "Se puede suministrar una máscara en los bits 0xff00 de INDEX para filtrar las pulsaciones que pueden disparar el callback; por ejemplo, los bits 0x300 desactivan L y R."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "To filter button presses that are able to trigger the callback, a mask can be supplied in bits 0xff00 of INDEX. For example, to disable L, R for a particular menu item, set bits 0x300 in the index"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.menuitem.claim.8"
    statement: "Los ítems pueden actualizarse, añadirse o eliminarse desde dentro de los propios callbacks."
    evidence:
      locator: "6.9 Custom Menu Items > MENUITEM"
      quote_or_paraphrase: "Menu items can be updated, added or removed from within callbacks"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
menuitem(index, [label], [callback])
```

## Semántica

Gestiona ítems personalizados del menú de pausa: añadirlos/actualizarlos con etiqueta y callback, o eliminarlos (sin etiqueta ni callback).

## Parámetros y retorno

- `index`: posición 1..5; los bits 0xff00 forman una máscara de filtro de botones (L, R, X).
- `label` (opcional): texto de hasta 16 caracteres.
- `callback` (opcional): función ejecutada al seleccionar; recibe un bitfield de L/R/X y, si devuelve true, mantiene el menú abierto.
- Retorno: no especificado por la fuente.

## Efectos y límites

- Un `index` sin `label` ni `callback` elimina el ítem.
- El bitfield del callback corresponde a los botones L, R, X (ver `pico8.api.btn`).

## Ejemplos relacionados

`MENUITEM(1, "RESTART PUZZLE", function() reset_puzzle() sfx(10) end)` reinicia el puzzle desde el menú de pausa.

## Ambigüedades

Ninguna documentada.
