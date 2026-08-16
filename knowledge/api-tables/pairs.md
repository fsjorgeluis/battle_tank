---
schema_version: "1.0"
id: "pico8.api.pairs"
kind: "api"
title: "PAIRS"
summary: "Itera en FOR sobre toda la tabla con clave y valor; el orden no está garantizado."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.3 Table Functions"
    anchor: "PAIRS"
relationships:
  - type: "related-api"
    target: "pico8.api.all"
  - type: "related-api"
    target: "pico8.api.foreach"
claims:
  - id: "pico8.api.pairs.claim.1"
    statement: "PAIRS(TBL) se usa en bucles FOR para iterar sobre la tabla TBL proporcionando la clave y el valor de cada elemento."
    evidence:
      locator: "6.3 Table Functions > PAIRS"
      quote_or_paraphrase: "Used in FOR loops to iterate over table TBL, providing both the key and value for each item."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pairs.claim.2"
    statement: "A diferencia de ALL(), PAIRS itera sobre todos los elementos sin importar el esquema de indexación."
    evidence:
      locator: "6.3 Table Functions > PAIRS"
      quote_or_paraphrase: "Unlike ALL(), PAIRS() iterates over every item regardless of indexing scheme."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pairs.claim.3"
    statement: "El orden de iteración de PAIRS no está garantizado."
    evidence:
      locator: "6.3 Table Functions > PAIRS"
      quote_or_paraphrase: "Order is not guaranteed."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.pairs.claim.4"
    statement: "El manual muestra T = {['HELLO']=3, [10]='BLAH'}; T.BLUE = 5 y la salida de FOR K,V IN PAIRS(T) con PRINT('K: '..K..'  V:'..V)."
    evidence:
      locator: "6.3 Table Functions > PAIRS"
      quote_or_paraphrase: "T = {['HELLO']=3, [10]='BLAH'}; T.BLUE = 5; FOR K,V IN PAIRS(T) DO PRINT('K: '..K..'  V:'..V) END -- Output: K: 10 v:BLAH; K: HELLO v:3; K: BLUE v:5"
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
pairs(tbl)
```

## Semántica

Iterador genérico de tabla: recorre todos los elementos (clave y valor) sin importar el esquema de indexación. Es la única función de la sección 6.3 que funciona con tablas hash o conjuntos.

## Parámetros y retorno

- `tbl`: cualquier tabla.
- Retorno: iterador que produce pares clave, valor. El orden no está garantizado.

## Efectos y límites

No se aplica la restricción de tablas de estilo array que sí afecta a ADD, DEL, DELI, COUNT, ALL y FOREACH.

## Ejemplos relacionados

```lua
t = {["HELLO"]=3, [10]="BLAH"}
t.BLUE = 5
for k,v in pairs(t) do
  print("K: "..k.."  V:"..v)
end
```

## Ambigüedades

Ninguna documentada.
