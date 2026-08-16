---
schema_version: "1.0"
id: "pico8.constraint.sound-instruments"
kind: "constraint"
title: "Definiciones de sonido (sfx)"
summary: "PICO-8 define 64 efectos de sonido indexados 0..63 por SFX."
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
    target: "pico8.api.sfx"
  - type: "related"
    target: "pico8.constraint.audio-channels"
claims:
  - id: "pico8.constraint.sound-instruments.claim.1"
    statement: "El sistema tiene 64 definiciones de sonido (llamadas 'chip blerps' en el manual)."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Sound: 4 channel, 64 definable chip blerps"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.sound-instruments.claim.2"
    statement: "SFX indexa sus efectos con N en 0..63, es decir, 64 valores distintos."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "Play sfx N (0..63) on CHANNEL (0..3) from note OFFSET (0..31 in notes) for LENGTH notes."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "sound"
  property: "definable-sfx-count"
  operator: "fixed"
  value: 64
  unit: "instruments"
  scope: "sfx bank"
  enforcement: "editor capability"
---

## Consecuencia práctica

Sólo hay 64 ranuras de sonido editables. El índice `n` de `SFX` debe estar en 0..63; los comandos especiales -1 y -2 quedan reservados y no reproducen definiciones.

## Ambigüedades

Ninguna documentada.