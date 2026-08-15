---
schema_version: "1.0"
id: "pico8.constraint.controller-button-count"
kind: "constraint"
title: "Número de botones por controlador"
summary: "PICO-8 usa controladores de 6 botones."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "Specifications"
relationships:
  - type: "related"
    target: "pico8.api.btn"
  - type: "related"
    target: "pico8.api.btnp"
claims:
  - id: "pico8.constraint.controller-button-count.claim.1"
    statement: "Los controladores tienen 6 botones."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Input: 6-button controllers"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.controller-button-count.claim.2"
    statement: "Los botones se indexan de 0 a 5: izquierda, derecha, arriba, abajo, botón O y botón X."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "B: 0..5: left right up down button_o button_x"
    classification: "fact"
    confidence: "high"
constraint:
  subject: "input"
  property: "button-count"
  operator: "fixed"
  value: 6
  unit: "buttons"
  scope: "per player controller"
  enforcement: "hardware capability"
---

## Consecuencia práctica

Todo diseño de entrada debe apoyarse en estos 6 botones por jugador. Pulsar izquierda y derecha a la vez es físicamente imposible en un controlador, y algunas combinaciones con arriba son incómodas si no se usa O/X.

## Ambigüedades

Ninguna documentada.
