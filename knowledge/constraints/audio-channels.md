---
schema_version: "1.0"
id: "pico8.constraint.audio-channels"
kind: "constraint"
title: "Canales de audio"
summary: "El bus de audio de PICO-8 tiene 4 canales fijos compartidos por SFX y MUSIC."
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
    target: "pico8.api.music"
  - type: "related"
    target: "pico8.constraint.sound-instruments"
claims:
  - id: "pico8.constraint.audio-channels.claim.1"
    statement: "El audio de PICO-8 tiene 4 canales."
    evidence:
      locator: "Specifications"
      quote_or_paraphrase: "Sound: 4 channel, 64 definable chip blerps"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.audio-channels.claim.2"
    statement: "El parámetro CHANNEL de SFX se indexa de 0 a 3, correspondiente a los 4 canales del bus."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "Play sfx N (0..63) on CHANNEL (0..3) from note OFFSET (0..31 in notes) for LENGTH notes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.audio-channels.claim.3"
    statement: "MUSIC reserva canales con una máscara de bits y SFX y MUSIC comparten el mismo conjunto de canales: los canales reservados para música siguen pudiendo usarse por SFX."
    evidence:
      locator: "6.5 Audio > MUSIC"
      quote_or_paraphrase: "Reserved channels can still be used to play sound effects on, but only when that channel index is explicitly requested by SFX()."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "audio"
  property: "channel-count"
  operator: "fixed"
  value: 4
  unit: "channels"
  scope: "audio output bus"
  enforcement: "hardware capability"
---

## Consecuencia práctica

Toda la reproducción de audio (efectos y música) compite por los mismos 4 canales. `SFX` con canal -1 pide un canal libre automáticamente; `MUSIC` puede reservar canales con `channel_mask`, pero el reparto total nunca supera 4 voces simultáneas.

## Ambigüedades

Ninguna documentada.