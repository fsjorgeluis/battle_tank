---
schema_version: "1.0"
id: "pico8.api.sfx"
kind: "api"
title: "SFX"
summary: "Reproduce el SFX N (0..63) en el canal CHANNEL (0..3) desde la nota OFFSET (0..31) durante LENGTH notas; los canales y N negativos son comandos de auto-asignación, parada o liberación de bucle."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.5 Audio"
    anchor: "SFX"
relationships:
  - type: "related"
    target: "pico8.api.music"
  - type: "related"
    target: "pico8.constraint.audio-channels"
  - type: "related"
    target: "pico8.constraint.sound-instruments"
  - type: "related-api"
    target: "pico8.api.print"
claims:
  - id: "pico8.api.sfx.claim.1"
    statement: "SFX(N, [CHANNEL], [OFFSET], [LENGTH]) reproduce el SFX N en el canal CHANNEL desde la nota OFFSET (0..31 en notas) durante LENGTH notas."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "Play sfx N (0..63) on CHANNEL (0..3) from note OFFSET (0..31 in notes) for LENGTH notes."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.2"
    statement: "El efecto a reproducir se indexa con N en 0..63."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "Play sfx N (0..63) on CHANNEL (0..3) ..."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.3"
    statement: "CHANNEL -1 (por defecto) asigna automáticamente un canal que no esté en uso."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "CHANNEL -1: (default) to automatically choose a channel that is not being used"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.4"
    statement: "CHANNEL -2 detiene el sonido dado en cualquier canal."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "CHANNEL -2: to stop the given sound from playing on any channel"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.5"
    statement: "N también puede ser un comando para el canal dado (o para todos los canales cuando CHANNEL es negativo): N -1 detiene el sonido en ese canal; N -2 libera el sonido de su bucle en ese canal."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "N -1: to stop sound on that channel. N -2: to release sound on that channel from looping."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.6"
    statement: "El manual muestra los modos combinados: SFX(3) reproduce el SFX 3; SFX(3,2) lo reproduce en el canal 2; SFX(3,-2) detiene el SFX 3 en cualquier canal; SFX(-1,2) detiene lo que suene en el canal 2; SFX(-2,2) libera el bucle en el canal 2; SFX(-1) detiene todos los sonidos de todos los canales; SFX(-2) libera el bucle en todos los canales."
    evidence:
      locator: "6.5 Audio > SFX"
      quote_or_paraphrase: "SFX(3) -- PLAY SFX 3 ... SFX(-2) -- RELEASE LOOPING ON ALL CHANNELS"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.sfx.claim.7"
    statement: "El rango N (0..63) se corresponde con las 64 definiciones de sonido del sistema, aunque el manual no lo declara explícitamente en esta sección."
    evidence:
      locator: "6.5 Audio > SFX y Specifications"
      quote_or_paraphrase: "Play sfx N (0..63) on CHANNEL (0..3) ... / Sound: 4 channel, 64 definable chip blerps"
    classification: "derived"
    confidence: "medium"
---

## Contrato

```lua
sfx(n, [channel], [offset], [length])
```

## Semántica

Reproduce el efecto de sonido `n` en un canal de audio a partir de una nota y durante un número de notas. Los valores negativos de `channel` y de `n` se interpretan como comandos especiales en lugar de índices.

## Parámetros y retorno

- `n`: índice del efecto (0..63). Con `n` -1 detiene el sonido en el canal dado; con `n` -2 libera ese canal de un bucle en curso.
- `channel` (opcional, por defecto -1): índice de canal 0..3. -1 elige automáticamente un canal libre; -2 detiene el sonido dado en cualquier canal.
- `offset` (opcional): nota de inicio (0..31 en notas).
- `length` (opcional): duración en notas.
- Retorno: no especificado por el manual.

## Efectos y límites

Cuando `channel` es negativo, `n` actúa como comando sobre todos los canales. Los canales reservados por `music` siguen pudiendo usar este efecto si se solicita explícitamente ese índice de canal.

## Ejemplos relacionados

Los ejemplos del manual están documentados en `pico8.api.sfx.claim.6` (siete llamadas que cubren reproducción, parada y liberación de bucle por canal y globales).

## Ambigüedades

Ninguna documentada.
