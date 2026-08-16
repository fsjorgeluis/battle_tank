---
schema_version: "1.0"
id: "pico8.constraint.cart-rom-size"
kind: "constraint"
title: "Tamaño de la cart ROM"
summary: "La cart ROM de PICO-8 es de 32k y comparte layout con la RAM base hasta 0x4300."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.7 Memory"
relationships:
  - type: "related"
    target: "pico8.constraint.ram-size"
  - type: "related"
    target: "pico8.constraint.lua-ram-size"
  - type: "related"
    target: "pico8.api.reload"
  - type: "related"
    target: "pico8.api.cstore"
claims:
  - id: "pico8.constraint.cart-rom-size.claim.1"
    statement: "La cart ROM es de 32k y tiene el mismo layout que la RAM base hasta 0x4300."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "2. Cart ROM (32k): same layout as base ram until 0x4300"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.cart-rom-size.claim.2"
    statement: "32k se interpreta como 32768 bytes."
    evidence:
      locator: "6.7 Memory"
      quote_or_paraphrase: "Cart ROM (32k)"
    classification: "derived"
    confidence: "medium"
constraint:
  subject: "cartridge rom"
  property: "size"
  operator: "fixed"
  value: "32"
  unit: "kibibytes"
  scope: "cartridge storage"
  enforcement: "cartridge format"
---

## Consecuencia práctica

La cart ROM es el almacenamiento persistente del cartucho; `reload` copia desde ella a la RAM base y `cstore` en sentido inverso, respetando la protección de la sección de código (>= 0x4300).

## Ambigüedades

- Nota de dominio cruzado: el límite de datos del cartucho (32k) queda pendiente para la fase data-math (sección 6.11) y se registra en el índice; la afirmación de 6.7 es consistente con esa fuente.
