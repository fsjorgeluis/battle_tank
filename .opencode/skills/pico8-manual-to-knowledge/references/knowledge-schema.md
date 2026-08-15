# Esquema de la base de conocimiento PICO-8 (v1)

## Raíz y fuente

La base vive en `knowledge/` en la raíz del repositorio. Sus instantáneas de
fuentes viven en `sources/`. Cada documento Markdown tiene frontmatter YAML y un
cuerpo breve. Las claves se muestran en YAML para describir el contrato; los
valores reales deben respetarlo.

```yaml
schema_version: "1.0"                 # obligatorio, exactamente 1.0
id: "pico8.<kind>.<slug>"             # obligatorio, único y estable
kind: "api"                           # api | constraint | concept | example
title: "Nombre humano"                # obligatorio
summary: "Una frase precisa"          # obligatorio
status: "verified"                    # verified | ambiguous | needs-review
source:
  source_id: "pico8-manual-v0.2.7"    # obligatorio
  url: "https://..."                  # URL canónica usada
  retrieved_at: "YYYY-MM-DD"          # fecha de instantánea
  sha256: "<64 hexadecimales>"         # hash del archivo en sources/
  locator:
    section: "6.4 Input"              # sección o encabezado concreto
    anchor: "BTN"                     # opcional si existe
    lines: "1010-1040"                # obligatorio para TXT si se conoce
relationships:                         # [] si no hay relaciones
  - type: "related-api"
    target: "pico8.api.btnp"
claims:
  - id: "pico8.api.btn.claim.1"
    statement: "Afirmación factual y comprobable."
    evidence:
      locator: "6.4 Input > BTN"
      quote_or_paraphrase: "Paráfrasis breve y fiel."
    classification: "fact"            # fact | derived | ambiguity
    confidence: "high"                # high | medium | low
```

## Reglas generales

- `id` coincide con un único archivo y nunca se reutiliza para otro concepto.
- `status: verified` exige que todas las afirmaciones `fact` tengan evidencia
  localizable en la fuente declarada.
- `status: ambiguous` exige una sección `## Ambigüedades` que enumere las
  interpretaciones posibles y por qué la fuente no permite elegir una.
- Las afirmaciones `derived` describen una consecuencia o recomendación del
  equipo, no un hecho del manual. Deben indicar qué claims la sustentan.
- Cada `target` de `relationships` debe ser el `id` de otro documento existente.
- El campo `sha256` debe coincidir con la instantánea, por lo que una actualización
  del manual requiere regenerar o revisar los documentos afectados.

## Documentos API

`kind: api` representa una sola función, callback, comando o directiva. Además
de las claves generales, el cuerpo tiene estas secciones en este orden:

```md
## Contrato
```lua
nombre(parametro [, opcional])
```

## Semántica

## Parámetros y retorno

## Efectos y límites

## Ejemplos relacionados

## Ambigüedades
```

No inventes tipos de retorno: si la fuente no lo declara, indícalo como no
especificado y usa `status: ambiguous` o una claim correspondiente.

## Restricciones

`kind: constraint` se usa para límites de hardware, cartucho, memoria, tokens o
rendimiento. Añade este bloque inmediatamente después del frontmatter:

```yaml
constraint:
  subject: "code"
  property: "token_limit"
  operator: "max"                     # max | fixed | exact | range | approx
  value: 8192
  unit: "tokens"
  scope: "one program"
  enforcement: "editor warning"
```

El valor, unidad y ámbito deben proceder de un claim factual. No transformes un
límite en una estimación de rendimiento sin marcarlo como `derived`.
Cuando la fuente use un valor aproximado, usa `operator: approx`; no elimines el
calificador. Las conversiones de unidad no sustituyen el valor factual de
`constraint.value`.

## Conceptos

`kind: concept` explica una idea transversal, por ejemplo el ciclo de juego.
No debe convertirse en una guía de arquitectura propia sin separar las claims
factuales de las recomendaciones `derived`.

## Ejemplos

`kind: example` usa:

```yaml
example:
  language: "lua"
  objective: "Qué demuestra"
  evidence_mode: "direct"             # direct | composed
  uses:
    - "pico8.api.btn"
  verified_execution: false
```

`direct` significa que el ejemplo aparece en la fuente. `composed` significa
que se construyó a partir de APIs verificadas; debe enlazarlas todas mediante
`uses` y no implica que el ejemplo haya sido ejecutado. Una prueba real debe
cambiar `verified_execution` sólo con evidencia de ejecución registrada.

## Índice

`knowledge/index.md` incluye una tabla con ID, tipo, resumen, estado y ruta, y
grupos por: límites, ciclo de juego, gráficos, entrada, mapa/memoria, audio,
datos y herramientas. Es un mapa de recuperación, no una segunda copia del
manual.
