---
schema_version: "1.0"
id: "pico8.constraint.code-compressed-size-max"
kind: "constraint"
title: "Tamaño comprimido máximo del código en .png/.rom"
summary: "Al guardar en formato .p8.png o .p8.rom, el tamaño comprimido del código debe ser menor de 15360 bytes."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "1.5 Loading and Saving"
    anchor: "Code size restrictions for .p8.png / .p8.rom formats"
relationships:
  - type: "related"
    target: "pico8.constraint.token-limit"
  - type: "related"
    target: "pico8.concept.export-tools"
  - type: "related"
    target: "pico8.api.info"
claims:
  - id: "pico8.constraint.code-compressed-size-max.claim.1"
    statement: "Al guardar en formato .png o .rom, el tamaño comprimido del código debe ser menor que 15360 bytes para que el total de datos quepa."
    evidence:
      locator: "1.5 Loading and Saving > Code size restrictions for .p8.png / .p8.rom formats"
      quote_or_paraphrase: "When saving in .png or .rom format, the compressed size of the code must be less than 15360 bytes so that the total data is [able to fit]"
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.code-compressed-size-max.claim.2"
    statement: "El tamaño comprimido actual del código se consulta con el comando INFO."
    evidence:
      locator: "1.5 Loading and Saving > Code size restrictions for .p8.png / .p8.rom formats"
      quote_or_paraphrase: "To find out the current size of your code, use the INFO command."
    classification: "fact"
    confidence: "high"
  - id: "pico8.constraint.code-compressed-size-max.claim.3"
    statement: "El límite de tamaño comprimido no se aplica al guardar en formato .p8."
    evidence:
      locator: "1.5 Loading and Saving > Code size restrictions for .p8.png / .p8.rom formats"
      quote_or_paraphrase: "The compressed size limit is not enforced for saving in .p8 format."
    classification: "fact"
    confidence: "high"
constraint:
  subject: "code"
  property: "compressed-code-size"
  operator: "max"
  value: "15360"
  unit: "bytes"
  scope: "cartridge saved in .p8.png or .p8.rom format"
  enforcement: "save-time limit for .png/.rom formats; not enforced for .p8"
---

## Consecuencia práctica

El límite afecta a la distribución en formatos `.p8.png` (imagen de cartucho) y `.p8.rom` (binario de 32k). El código comprimido debe quedar por debajo de 15360 bytes; `INFO` muestra el tamaño comprimido actual. Este límite es independiente del máximo de 8192 tokens y se suma a él como restricción de formato de guardado.

## Ambigüedades

La fuente expresa el límite como "menos de 15360 bytes" sin especificar el mensaje ni el momento exacto del rechazo al guardar; no se infiere el comportamiento de fallo.
