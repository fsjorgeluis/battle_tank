---
schema_version: "1.0"
id: "pico8.api.music"
kind: "api"
title: "MUSIC"
summary: "Reproduce música desde el patrón N (0..63) con fundido FADE_LEN en ms y una máscara CHANNEL_MASK para reservar canales sólo para música; N -1 detiene la música."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.5 Audio"
    anchor: "MUSIC"
relationships:
  - type: "related"
    target: "pico8.api.sfx"
  - type: "related"
    target: "pico8.constraint.audio-channels"
claims:
  - id: "pico8.api.music.claim.1"
    statement: "MUSIC(N, [FADE_LEN], [CHANNEL_MASK]) reproduce música desde el patrón N (0..63); N -1 detiene la música."
    evidence:
      locator: "6.5 Audio > MUSIC"
      quote_or_paraphrase: "Play music starting from pattern N (0..63). N -1 to stop music"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.music.claim.2"
    statement: "FADE_LEN se expresa en milisegundos y por defecto vale 0; MUSIC(0, 1000) funde el patrón 0 durante 1 segundo."
    evidence:
      locator: "6.5 Audio > MUSIC"
      quote_or_paraphrase: "FADE_LEN is in ms (default: 0). So to fade pattern 0 in over 1 second: MUSIC(0, 1000)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.music.claim.3"
    statement: "CHANNEL_MASK especifica qué canales reservar sólo para música; MUSIC(0, NIL, 7) reproduce sólo en los canales 0..2 (1 | 2 | 4)."
    evidence:
      locator: "6.5 Audio > MUSIC"
      quote_or_paraphrase: "CHANNEL_MASK specifies which channels to reserve for music only. For example, to play only on channels 0..2: MUSIC(0, NIL, 7) -- 1 | 2 | 4"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.music.claim.4"
    statement: "Los canales reservados siguen pudiendo usarse para efectos de sonido, pero sólo cuando SFX solicita explícitamente ese índice de canal."
    evidence:
      locator: "6.5 Audio > MUSIC"
      quote_or_paraphrase: "Reserved channels can still be used to play sound effects on, but only when that channel index is explicitly requested by SFX()."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
music(n, [fade_len], [channel_mask])
```

## Semántica

Reproduce una pista de música a partir de un patrón. Admite un fundido de entrada en milisegundos y una máscara de bits que reserva canales para uso exclusivo de la música.

## Parámetros y retorno

- `n`: índice del patrón (0..63). Con `n` -1 detiene la música.
- `fade_len` (opcional, por defecto 0): duración del fundido en milisegundos.
- `channel_mask` (opcional): máscara de bits que reserva canales para música. `7` (1 | 2 | 4) reserva los canales 0, 1 y 2.
- Retorno: no especificado por el manual.

## Efectos y límites

Los canales reservados con `channel_mask` no son exclusivos: `sfx` puede usarlos si se indica explícitamente el índice de canal. El número de canales (0..3) está limitado por la capacidad del bus de audio.

## Ejemplos relacionados

El manual muestra `MUSIC(0, 1000)` para fundir el patrón 0 en un segundo y `MUSIC(0, NIL, 7)` para limitar la música a los canales 0..2.

## Ambigüedades

Ninguna documentada.