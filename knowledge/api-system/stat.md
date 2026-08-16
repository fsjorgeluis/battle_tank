---
schema_version: "1.0"
id: "pico8.api.stat"
kind: "api"
title: "STAT"
summary: "Devuelve el estado del sistema según X: memoria, CPU, portapapeles, parámetros, framerate, audio, tiempo, breadcrumb y modo frame-by-frame."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "STAT"
relationships:
  - type: "related"
    target: "pico8.api.extcmd"
  - type: "related"
    target: "pico8.concept.devkit-input"
  - type: "related"
    target: "pico8.api.sfx"
  - type: "related"
    target: "pico8.api.music"
  - type: "related"
    target: "pico8.api.load"
  - type: "related"
    target: "pico8.api.run"
  - type: "related"
    target: "pico8.api.resume"
  - type: "related"
    target: "pico8.api.serial"
claims:
  - id: "pico8.api.stat.claim.1"
    statement: "stat(0) devuelve el uso de memoria (0..2048)."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "0  Memory usage (0..2048)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.2"
    statement: "stat(1) devuelve la CPU usada desde el último flip (1.0 == 100% de CPU)."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "1  CPU used since last flip (1.0 == 100% CPU)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.3"
    statement: "stat(4) devuelve el contenido del portapapeles, disponible sólo tras pulsar CTRL-V durante la ejecución."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "4  Clipboard contents (after user has pressed CTRL-V)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.4"
    statement: "stat(6) devuelve la string de parámetros pasada a RUN() o LOAD()."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "6  Parameter string"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.5"
    statement: "stat(7) devuelve el framerate actual."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "7  Current framerate"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.6"
    statement: "stat(46..49) devuelve el índice del SFX en reproducción en los canales 0..3; stat(50..53) la nota (0..31) en cada canal."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "46..49  Index of currently playing SFX on channels 0..3 | 50..53  Note number (0..31) on channel 0..3"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.7"
    statement: "stat(54) es el índice de patrón en reproducción, stat(55) los patrones reproducidos, stat(56) los ticks del patrón actual y stat(57) un booleano true cuando suena música."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "54  Currently playing pattern index | 55  Total patterns played | 56  Ticks played on current pattern | 57  (Boolean) TRUE when music is playing"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.8"
    statement: "stat(80..85) devuelve la hora UTC (año, mes, día, hora, minuto, segundo) y stat(90..95) la hora local."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "80..85  UTC time: year, month, day, hour, minute, second | 90..95  Local time"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.9"
    statement: "stat(100) devuelve la etiqueta del breadcrumb actual, o nil."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "100  Current breadcrumb label, or nil"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.10"
    statement: "stat(110) devuelve true cuando el modo frame-by-frame está activo."
    evidence:
      locator: "6.1 System > STAT"
      quote_or_paraphrase: "110  Returns true when in frame-by-frame mode"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.11"
    statement: "Los valores de audio 16..26 son la versión legada de las consultas 46..56; sólo informan del estado actual del mezclador, que cambia aproximadamente 20 veces por segundo según el driver de sonido del host."
    evidence:
      locator: "6.1 System > STAT (nota)"
      quote_or_paraphrase: "Audio values 16..26 are the legacy version of audio state queries 46..56. They only report on the current state of the audio mixer, which changes only ~20 times a second (depending on the host sound driver and other factors)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.12"
    statement: "stat(120) devuelve true cuando hay datos disponibles en el canal 0x800 (archivo soltado); stat(121) para el canal 0x802 (imagen soltada)."
    evidence:
      locator: "6.12 GPIO > Serial"
      quote_or_paraphrase: "0x800  dropped file  // stat(120) returns TRUE when data is available | 0x802  dropped image // stat(121) returns TRUE when data is available"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.stat.claim.13"
    statement: "La CPU también puede medirse con CTRL-P (CPU meter) o imprimiendo stat(1) al final de cada frame."
    evidence:
      locator: "5 PICO-8 Program Structure > CPU"
      quote_or_paraphrase: "To view the CPU load while a cartridge is running, press CTRL-P to toggle a CPU meter, or print out STAT(1) at the end of each frame."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
stat(x)
```

## Semántica

Devuelve un valor de estado del sistema según el índice `x`. El tipo y significado del retorno dependen del valor de `x`; los valores cubiertos por esta fase son los de 6.1 System y 6.12 GPIO.

## Parámetros y retorno

- `x`: índice de consulta. Valores documentados en esta fase: `0`, `1`, `4`, `6`, `7`, `16..26` (legado), `46..57`, `80..85`, `90..95`, `100`, `110`, `120`, `121`.
- Retorno: número, string o booleano según el índice.

## Efectos y límites

- Los valores `30..39` (entrada devkit) pertenecen a 6.13 y se documentan en `pico8.concept.devkit-input`.
- La lista de la fuente es discreta; los índices no enumerados no están descritos y no se infieren.
- Los valores de audio `16..26` reportan el estado actual del mezclador (aprox. 20 veces por segundo); `46..56` almacenan un historial del mezclador por tick para mayor resolución.

## Ejemplos relacionados

`STAT(1)` al final de cada frame mide la carga de CPU; `STAT(6)` lee los parámetros pasados con `RUN()`.

## Ambigüedades

Ninguna documentada.
