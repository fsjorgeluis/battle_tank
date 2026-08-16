---
schema_version: "1.0"
id: "pico8.concept.audio-editors"
kind: "concept"
title: "Editores de SFX y música del cartucho"
summary: "64 SFX con 32 notas y propiedades por SFX (SPD, loop); la música son secuencias de patterns de 4 canales; hay instrumentos SFX y de forma de onda."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "2.4 SFX Editor; 2.5 Music Editor"
    anchor: "SFX_Editor"
relationships:
  - type: "related"
    target: "pico8.api.sfx"
  - type: "related"
    target: "pico8.api.music"
claims:
  - id: "pico8.concept.audio-editors.claim.1"
    statement: "Hay 64 SFX en un cartucho, usados tanto para sonido como para música."
    evidence:
      locator: "2.4 SFX Editor"
      quote_or_paraphrase: "There are 64 SFX (\"sound effects\") in a cartridge, used for both sound and music."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.2"
    statement: "Cada SFX tiene 32 notas; cada nota tiene frecuencia (C0..C5), instrumento (0..7), volumen (0..7) y efecto (0..7)."
    evidence:
      locator: "2.4 SFX Editor"
      quote_or_paraphrase: "Each SFX has 32 notes, and each note has: A frequency (C0..C5), An instrument (0..7), A volume (0..7), An effect (0..7)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.3"
    statement: "Cada SFX tiene play speed (SPD: ticks por nota) y loop start/end; el looping se desactiva cuando start >= end."
    evidence:
      locator: "2.4 SFX Editor"
      quote_or_paraphrase: "A play speed (SPD) : the number of 'ticks' to play each note for ... Loop start and end : this is the note index to loop back and to // Looping is turned off when the start index >= end index"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.4"
    statement: "Los efectos van de 0 a 7: 0 none, 1 slide, 2 vibrato, 3 drop, 4 fade in, 5 fade out, 6 arpeggio fast, 7 arpeggio slow; si el SPD <= 8, las velocidades de arpeggio se reducen a la mitad (2, 4)."
    evidence:
      locator: "2.4 SFX Editor > Effects"
      quote_or_paraphrase: "0 none ... 6 arpeggio fast ... 7 arpeggio slow ... If the SFX speed is <= 8, arpeggio speeds are halved to 2, 4"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.5"
    statement: "Los filtros de SFX (tracker mode) son NOIZ, BUZZ, DETUNE-1, DETUNE-2, REVERB y DAMPEN; BUZZ con instrumento 6 y NOIZ off genera ruido pardo."
    evidence:
      locator: "2.4 SFX Editor > Filters"
      quote_or_paraphrase: "NOIZ: Generate pure white noise (applies only to instrument 6) ... When BUZZ is used with instrument 6, and NOIZ is off, pure brown noise is generated."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.6"
    statement: "La música se controla con una secuencia de patterns; cada pattern es una lista de 4 números indicando qué SFX suena en cada canal."
    evidence:
      locator: "2.5 Music Editor"
      quote_or_paraphrase: "Music in PICO-8 is controlled by a sequence of 'patterns'. Each pattern is a list of 4 numbers indicating which SFX will be played on that channel."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.7"
    statement: "El flujo de reproducción se controla con 3 comandos por pattern: STOP, LOOP BACK y LOOP START; sin ninguno, se reproduce el siguiente pattern."
    evidence:
      locator: "2.5 Music Editor > Flow control"
      quote_or_paraphrase: "a STOP command is set on that pattern (the third button) ... a LOOP BACK command is set (the 2nd button), in which case the music player searches back for a pattern with the LOOP START command set (the first button) or returns to pattern 0 if none is found."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.8"
    statement: "Además de los 8 instrumentos integrados, se pueden definir instrumentos custom con los primeros 8 SFX (index en verde en el canal de instrumento)."
    evidence:
      locator: "2.5 Music Editor > SFX Instruments"
      quote_or_paraphrase: "custom instruments can be defined using the first 8 SFX ... which will show up in the instrument channel as green instead of pink."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.audio-editors.claim.9"
    statement: "Los instrumentos de forma de onda funcionan igual que los de SFX pero usan una onda personalizada de 64 bytes en bucle (SFX 0..7)."
    evidence:
      locator: "2.5 Music Editor > Waveform Instruments"
      quote_or_paraphrase: "Waveform instruments function the same way as SFX instruments, but consist of a custom 64-byte looping waveform ... use SFX 0..7 as a waveform instrument."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

El cartucho tiene 64 SFX de 32 notas. Cada nota combina frecuencia/instrumento/volumen/efecto; cada SFX añade SPD y loop. La música son patterns de 4 canales con comandos de flujo (STOP / LOOP BACK / LOOP START). Los instrumentos pueden ser los 8 integrados, instrumentos SFX (primeros 8 SFX) o formas de onda custom de 64 bytes.

## Modelo mental

El audio se modela en dos capas: SFX (una secuencia de 32 notas reproducible sola o como bucle) y música (patterns que disparan SFX en 4 canales). Los efectos y filtros transforman cada nota en reproducción.

## Consecuencias de implementación

- Reproducir un SFX con `SFX()` y la música con `MUSIC()`; los contracts viven en los documentos api correspondientes (`derived` desde claims 1 y 6).
- Para loops que deben detenerse en un punto concreto (p. ej. 3/4), usar un único loop start con el segundo valor a 0, que se muestra como "LEN" (`derived` desde claim 3 y sección 2.5).
- Los instrumentos SFX permiten texturas complejas (tremolo, campanas) sin código; los efectos 4/5 (fade) y el 3 (drop) alteran el disparo (`derived` desde claim 8).

## Documentos relacionados

- `pico8.api.sfx` — reproducción de efectos de sonido.
- `pico8.api.music` — reproducción de patrones de música.

## Ambigüedades

Ninguna documentada.
