---
schema_version: "1.0"
id: "pico8.concept.lua-syntax-primer"
kind: "concept"
title: "Primer de sintaxis Lua en PICO-8"
summary: "Los programas de PICO-8 usan sintaxis Lua sin la biblioteca estándar; los números son fixed point 16:16, los arrays son 1-based, los rangos de los bucles son inclusivos y hay atajos no estándar de PICO-8 para condiciones, operadores de asignación y el operador !=."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "4 Lua Syntax Primer"
relationships:
  - type: "related"
    target: "pico8.constraint.number-precision"
  - type: "related"
    target: "pico8.constraint.number-min"
  - type: "related"
    target: "pico8.constraint.number-max"
  - type: "related"
    target: "pico8.concept.game-loop"
claims:
  - id: "pico8.concept.lua-syntax-primer.claim.1"
    statement: "Los programas de PICO-8 usan sintaxis Lua pero no la biblioteca estándar de Lua."
    evidence:
      locator: "4 Lua Syntax Primer"
      quote_or_paraphrase: "PICO-8 programs are written using Lua syntax, but do not use the standard Lua library."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.2"
    statement: "Los tipos de Lua son números, strings, booleanos y tablas."
    evidence:
      locator: "4 Lua Syntax Primer > Types and assignment"
      quote_or_paraphrase: "Types in Lua are numbers, strings, booleans and tables."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.3"
    statement: "Los números de PICO-8 son todos 16:16 fixed point, con rango de -32768.0 a 32767.99999; se admite notación hexadecimal con parte fraccionaria opcional y los decimales se redondean al valor fixed point más cercano."
    evidence:
      locator: "4 Lua Syntax Primer > Types and assignment"
      quote_or_paraphrase: "Numbers in PICO-8 are all 16:16 fixed point. They range from -32768.0 to 32767.99999 ... 0x11.4000 -- 17.25 ... Numbers written in decimal are rounded to the closest fixed point value."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.4"
    statement: "Dividir por cero evalúa a 0x7fff.ffff si es positivo, o -0x7fff.ffff si es negativo."
    evidence:
      locator: "4 Lua Syntax Primer > Types and assignment"
      quote_or_paraphrase: "Dividing by zero evaluates to 0x7fff.ffff if positive, or -0x7fff.ffff if negative."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.5"
    statement: "Los bucles FOR y WHILE admiten rangos inclusivos, pasos positivos y negativos, y pueden escribirse en una sola línea."
    evidence:
      locator: "4 Lua Syntax Primer > Loops"
      quote_or_paraphrase: "Loop ranges are inclusive: FOR X=1,5 DO PRINT(X) END -- PRINTS 1,2,3,4,5 ... FOR X=5,1,-2 DO PRINT(X) END -- 5,3,1"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.6"
    statement: "Las variables declaradas como LOCAL están limitadas al bloque de código contenedor (una FUNCTION, un bucle FOR, o un IF THEN END)."
    evidence:
      locator: "4 Lua Syntax Primer > Functions and Local Variables"
      quote_or_paraphrase: "Variables declared as LOCAL are scoped to their containing block of code (for example, inside a FUNCTION, a FOR loop, or IF THEN END statement)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.7"
    statement: "Las tablas son colecciones de pares clave-valor con tipos mezclables; los arrays usan indexado 1-based por defecto, y las tablas con índices enteros 1-based soportan el operador # y las funciones ADD, DEL, DELI, ALL y FOREACH."
    evidence:
      locator: "4 Lua Syntax Primer > Tables"
      quote_or_paraphrase: "Tables with 1-based integer indexes are special though. The length of such an array can be found with the # operator, and PICO-8 uses such arrays to implement ADD, DEL, DELI, ALL and FOREACH functions."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.8"
    statement: "Se puede usar indexado 0-based escribiendo en el slot cero, e índices string con notación de punto."
    evidence:
      locator: "4 Lua Syntax Primer > Tables"
      quote_or_paraphrase: "if you prefer 0-based arrays, just write something the zeroth slot ... PLAYER.X = 2 -- is equivalent to PLAYER[\"X\"]"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.9"
    statement: "PICO-8 admite atajos no estándar: IF THEN END y WHILE THEN END en una sola línea con paréntesis obligatorios alrededor de la condición, operadores de asignación compuestos (+=, &=, ..=, etc.) si la sentencia entera está en una línea, y != como alternativa a ~=."
    evidence:
      locator: "4 Lua Syntax Primer > PICO-8 Shorthand"
      quote_or_paraphrase: "IF THEN END statements, and WHILE THEN END can be written on a single line ... Note that brackets around the short-hand condition are required ... Shorthand assignment operators can also be used if the whole statement is on one line ... pico-8 also accepts != instead of ~= for \"not equal to\""
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.10"
    statement: "Las strings iguales están internadas (interning), por lo que la comparación con == funciona por valor."
    evidence:
      locator: "4 Lua Syntax Primer > PICO-8 Shorthand"
      quote_or_paraphrase: "PRINT(\"FOO\" == \"FOO\") -- TRUE (STRING ARE INTERNED)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.lua-syntax-primer.claim.11"
    statement: "El código de todas las pestañas se concatena de izquierda a derecha y se ejecuta; PICO-8 llama a _UPDATE() a 30fps, _DRAW() una vez por frame visible, y _INIT() una vez al arrancar, si están definidas."
    evidence:
      locator: "PICO-8 Program Structure"
      quote_or_paraphrase: "all of the code from tabs is concatenated (from left to right) and executed ... _UPDATE() -- Called once per update at 30fps. _DRAW() -- Called once per visible frame. _INIT() -- Called once on program startup."
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

PICO-8 usa la sintaxis de Lua sin su biblioteca estándar. Los números son 16:16 fixed point (sección 4 > Types and assignment), los rangos de bucles son inclusivos, las tablas con índices enteros 1-based son "especiales" (operador `#` y funciones de lista), y hay atajos propios de PICO-8 (shorthand de IF/WHILE en una línea con paréntesis, operadores de asignación compuestos en una línea, e `!=`). El intérprete concatena las pestañas y llama a `_UPDATE`/`_DRAW`/`_INIT`.

## Modelo mental

El programador escribe Lua con restricciones y extensiones de PICO-8. La aritmética es fixed point: conviene modelar mentalmente cualquier cálculo numérico bajo esa lente. El bucle principal se define declarativamente con `_UPDATE`/`_DRAW`, y el intérprete se encarga de la cadencia.

## Consecuencias de implementación

- No usar la biblioteca estándar de Lua (`string`, `math`, `table`, `os`, etc.); usar las funciones del API de PICO-8 (`derived` desde claim 1).
- Los incrementos en contadores deben vigilarse: sumar 1 por frame a un número fixed point desborda alrededor de los 18 minutos (ver `pico8.concept.p8-quirks` y `pico8.constraint.number-precision`) (`derived` desde claims 3 y 4).
- Los arrays 1-based exigen cuidado en bucles e índices: el primer elemento es `[1]`, no `[0]` (`derived` desde claim 7).
- El atajo de una línea para IF/WHILE requiere paréntesis; los operadores compuestos requieren que toda la sentencia esté en una línea (`derived` desde claim 9).

## Documentos relacionados

- `pico8.constraint.number-precision` — precisión del fixed point 16:16.
- `pico8.constraint.number-min` / `pico8.constraint.number-max` — rango numérico.
- `pico8.concept.game-loop` — cadencia de `_UPDATE`/`_DRAW` y modo 60fps.
- `pico8.concept.p8-quirks` — gotchas derivados de esta sintaxis.

## Ambigüedades

El manual afirma que PICO-8 "no incluye la biblioteca estándar de Lua" y deriva el resto al sitio oficial de Lua (www.lua.org); los detalles de semántica de Lua fuera del resumen no forman parte de esta fuente.
