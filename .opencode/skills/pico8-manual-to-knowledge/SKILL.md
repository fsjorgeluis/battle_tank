---
name: pico8-manual-to-knowledge
description: Convierte un manual PICO-8 HTML o TXT en una base de conocimiento atómica, trazable y validada. Úsalo al crear o actualizar knowledge/; no para implementar un juego.
metadata:
  opencode/slash: "true"
---

# Generación de conocimiento PICO-8

## Propósito y límites

Este skill transforma una fuente oficial local en documentos de conocimiento. No
implementa mecánicas del juego y no usa conocimiento no respaldado por la fuente.
El manual no se copia dentro de este archivo: se lee desde `sources/` y los
resultados se escriben en `knowledge/`.

## Prioridad de instrucciones

El alcance declarado por el usuario para la invocación actual tiene prioridad
sobre cualquier instrucción general de este skill. "Genera la base" no autoriza
generar dominios que el usuario no haya aprobado explícitamente para esta fase.

## Entrada requerida

Antes de empezar, comprueba que existe exactamente una fuente principal en
`sources/`, con nombre `pico8-manual-v<version>.html` o
`pico8-manual-v<version>.txt`.

Si no existe, pregunta antes de descargarla. Si el usuario autoriza descargar el
manual oficial, ejecuta:

```sh
python3 scripts/fetch_manual.py --version <version>
```

No sustituyas una fuente existente sin confirmación explícita. Conserva la fuente
anterior para que la actualización pueda revisarse.

## Perfiles de fase y captura de alcance

Los siguientes perfiles son contratos canónicos. "constraints" y "concepts" son
dominios de conocimiento transversales: no son una única sección de la API y por
eso nunca deben omitirse de un menú por estar fuera de las secciones 6.x.

| Perfil | Dominios autorizados | Rutas autorizadas | Fuente principal a consultar |
| --- | --- | --- | --- |
| `foundation` | límites, estructura/ciclo de juego, entrada | `knowledge/constraints/`, `knowledge/concepts/`, `knowledge/api-input/`, `knowledge/index.md` | especificaciones de plataforma, sección 5, 6.4 y 6.13 |
| `graphics` | gráficos | `knowledge/api-graphics/`, `knowledge/constraints/`, `knowledge/index.md` | 6.2 y límites gráficos relacionados |
| `map-memory` | mapa y memoria | `knowledge/api-map/`, `knowledge/api-memory/`, `knowledge/constraints/`, `knowledge/index.md` | 6.6 y 6.7 |
| `audio` | audio | `knowledge/api-audio/`, `knowledge/constraints/`, `knowledge/index.md` | 6.5 y límites de audio relacionados |
| `data-math` | tablas, strings, datos de cartucho y matemáticas | `knowledge/api-tables/`, `knowledge/api-strings/`, `knowledge/api-math/`, `knowledge/constraints/`, `knowledge/index.md` | 6.3, 6.8, 6.10 y 6.11 |
| `system-tools` | sistema, menú, GPIO, Lua adicional y herramientas | `knowledge/api-system/`, `knowledge/api-menu/`, `knowledge/concepts/`, `knowledge/index.md` | 6.1, 6.9, 6.12, 6.14 y secciones de herramientas pertinentes |
| `complete` | todos los anteriores | todas las rutas de los perfiles | manual completo |

Si el usuario no ha declarado un alcance, pregunta primero por uno de esos
perfiles o por un alcance personalizado. El menú, si se ofrece, debe incluir
exactamente todos los perfiles de la tabla y una opción `personalizado`; no
ofrezcas menús basados sólo en secciones 6.x.

Si el usuario expresa el alcance en lenguaje natural, normalízalo a los dominios
y rutas de esta tabla y muestra el resultado para confirmar. No le pidas que
adapte su alcance a categorías incompletas. Si coincide exactamente con un
perfil, usa ese perfil y no vuelvas a preguntar qué dominios autoriza.

Un perfil autoriza sólo sus rutas. La presencia de `knowledge/constraints/` en
un perfil permite documentar únicamente restricciones necesarias para ese
dominio; no autoriza procesar restricciones no relacionadas de fases futuras.

## Bloqueo de alcance: obligatorio antes de escribir

Este skill funciona siempre en dos pasos: `PLAN` y `EJECUCIÓN`.

### Paso PLAN (sin escritura)

Antes de crear, modificar o borrar cualquier archivo de `knowledge/`, extrae del
mensaje del usuario un contrato de fase con estos cinco campos:

```text
Fase: <identificador breve>
Dominios autorizados: <lista cerrada>
Rutas autorizadas: <lista cerrada de rutas bajo knowledge/>
Objetivo: <qué documentos o resultados se esperan>
Fuente: <archivo concreto bajo sources/>
```

Si falta cualquiera de ellos, pregunta por el campo faltante y no escribas nada.
Si el usuario pide todos los dominios, muestra igualmente el plan completo y pide
confirmación explícita. No interpretes "el manual" o "la base" como autorización
implícita para procesar todos los dominios.

Responde con un plan cerrado que liste exactamente:

- archivos que se crearán o modificarán;
- documentos existentes que se leerán;
- dominios y rutas expresamente excluidos;
- comando de validación que se ejecutará.

Antes de redactar el PLAN, lee `templates/phase-plan.md` y sigue su estructura.
No sustituyas sus tablas obligatorias por listas abreviadas ni declares que un
control ha pasado si la evidencia visual requerida por la plantilla no aparece
en el propio PLAN.

### Manifiesto verificable del PLAN

Antes de mostrar cualquier PLAN al usuario, lee
`references/phase-manifest-schema.md` y crea un manifiesto JSON temporal en
`/tmp/pico8-phase-<fase>.json`. No escribas este manifiesto dentro del proyecto
ni dentro de `knowledge/`.

El manifiesto es la única fuente de verdad para:

- `allowed_paths` de la fase;
- todos los archivos nuevos y modificados;
- cada fila de restricción atómica;
- las incertidumbres previstas.

Ejecuta obligatoriamente:

```sh
python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_phase_plan.py /tmp/pico8-phase-<fase>.json --render-plan
```

Si el comando falla, corrige el manifiesto y vuelve a ejecutarlo. No muestres un
PLAN ni pidas `CONFIRMO` hasta que termine con `PLAN válido`. Copia literalmente
todo el bloque delimitado por `PICO8-PLAN-MANIFEST-START` y
`PICO8-PLAN-MANIFEST-END`; no lo reescribas, resumas ni sustituyas por tablas
manuales. Ese bloque contiene archivos creados/modificados, tabla atómica e
incertidumbres. El PLAN Markdown no puede enumerar rutas, restricciones o
incertidumbres fuera de ese bloque.

### Verificación mecánica obligatoria del PLAN.md

No confíes en releer o contar celdas a simple vista para comprobar que copiaste
el bloque sin alterarlo: ese control ya falló en producción pese a estar
explícitamente instruido en este mismo skill. Antes de mostrar el PLAN al
usuario:

1. Escribe el documento PLAN completo (con el bloque del manifiesto ya pegado
   dentro) en `/tmp/pico8-phase-<fase>-plan.md`.
2. Ejecuta obligatoriamente:

   ```sh
   python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_phase_plan.py /tmp/pico8-phase-<fase>.json --verify-plan-md /tmp/pico8-phase-<fase>-plan.md
   ```

Este comando recalcula la salida canónica a partir del manifiesto real y la
compara, carácter por carácter, contra el bloque que efectivamente quedó en tu
archivo. Detecta mecánicamente cualquier tabla con menos columnas de las
esperadas, cualquier incertidumbre sin `acción`, y cualquier reformulación del
bloque, sin depender de que lo audites tú mismo. Sólo puedes mostrar el PLAN al
usuario y pedir `CONFIRMO` cuando este comando termine con
`PLAN.md verificado: coincide con el manifiesto`. Si informa una discrepancia,
el PLAN es inválido: corrige el archivo (normalmente pegando de nuevo, sin
editar, la salida de `--render-plan`) y repite la verificación.

Si tu entorno no te permite ejecutar comandos de shell, no generes un bloque que
aparente ser la salida de estos scripts. Indica explícitamente al usuario que no
puedes ejecutar la validación mecánica del PLAN y detente antes de pedir
`CONFIRMO`.

Incluye ambas líneas de salida, `PLAN válido: ...` y
`PLAN.md verificado: coincide con el manifiesto`, en la puerta de calidad.

Termina el paso PLAN con la frase exacta: `Esperando CONFIRMO para ejecutar esta
fase.` No escribas archivos, no crees directorios y no descargues fuentes durante
el paso PLAN.

### Paso EJECUCIÓN (sólo tras confirmación)

Ejecuta únicamente después de que el usuario responda `CONFIRMO` al plan de esa
misma fase. La confirmación no autoriza ningún archivo que no estuviera listado.

Durante la ejecución:

- crea o modifica exclusivamente los archivos enumerados en el plan aprobado;
- no crees directorios vacíos como preparación para fases futuras;
- no leas ni generes documentación de dominios excluidos;
- no continúes automáticamente a otra fase, aunque termines antes de lo previsto;
- al terminar, ejecuta el validador, informa su salida y detente.

Antes de escribir el primer archivo, vuelve a ejecutar el validador del
manifiesto temporal. Si el manifiesto ya no existe o falla, no ejecutes la fase:
vuelve al paso PLAN y solicita una confirmación sobre un PLAN válido.

Una fase posterior requiere una nueva invocación o un nuevo contrato de fase y
otra confirmación `CONFIRMO`.

## Contrato obligatorio

1. Lee por completo `references/knowledge-schema.md` antes de crear o modificar
   documentos.
2. Calcula el SHA-256 de la fuente y úsalo en el campo `source.sha256` de todos
   los documentos generados desde ella.
3. Crea documentos pequeños y de un único tipo: `api`, `constraint`, `concept` o
   `example`. Una función o callback es un documento `api`; no agrupes APIs no
   equivalentes.
   Los operadores, abreviaturas, directivas, modos o variantes de sintaxis no
   son `kind: api` por sí mismos: documéntalos como claims de la función,
   callback o concepto que representan. Por ejemplo, `@ADDR`, `%ADDR` y `$ADDR`
   se documentan respectivamente en `pico8.api.peek`, `pico8.api.peek2` y
   `pico8.api.peek4`, no en un documento `peek-operators`.
4. Toda afirmación factual debe tener una entrada en `claims` con un localizador
   concreto en el manual: título de sección, encabezado de API o rango de líneas
   de la instantánea TXT. No declares como `verified` aquello que no puedas
   localizar.
5. Las deducciones de ingeniería son válidas sólo si se marcan como `derived`.
   Clasifica toda incertidumbre con la puerta de clasificación de este skill;
   no la llames `ambiguous` por defecto ni la resuelvas por suposición.
6. Usa IDs estables con el prefijo `pico8.` y enlaza documentos mediante
   `relationships`; no dependas de texto libre para enlazarlos.
7. Actualiza `knowledge/index.md` sólo con los documentos de las rutas autorizadas
   en esta fase. Puede contener una sección "pendiente" para dominios no
   procesados, pero no puede listar documentos que no existen.
8. Ejecuta `python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_knowledge.py knowledge` al terminar. Corrige
   todos los errores antes de declarar éxito. Los avisos deben quedar explicados
   en la respuesta final.

## Proceso de ejecución aprobado

1. Inspecciona la versión, URL canónica, fecha de obtención y hash de la fuente.
2. Lee únicamente las secciones del manual necesarias para los dominios aprobados.
3. Genera sólo los documentos del plan aprobado. Genera restricciones antes de
   ejemplos cuando ambos estén dentro del alcance.
4. Genera ejemplos sólo si el manual ofrece el ejemplo o si cada línea relevante
   puede justificarse mediante documentos `verified`; en el segundo caso usa
   `evidence_mode: composed`.
5. Declara en la respuesta: fuente usada, hash, documentos creados o modificados,
   ambigüedades encontradas y salida del validador. Después, detente.

## Puerta de calidad del PLAN

Antes de pedir `CONFIRMO`, verifica y declara que el plan cumple todo lo siguiente:

1. Cada salida se lista como una ruta de archivo completa, por ejemplo
   `knowledge/constraints/token-limit.md`. No aceptes como salida suficiente un
   directorio, una cantidad de documentos o una lista de IDs.
2. Un documento `kind: api` representa una API real completa y usa un ID canónico
   único: `pico8.api.stat`, no `pico8.api.stat-input` ni otro ID que describa sólo
   una selección de valores, parámetros o un caso de uso. Las APIs transversales
   se ubican una vez y se relacionan desde otros dominios. Si el alcance no deja
   documentar el contrato completo, anótalas como pendientes en el índice y no
   crees su archivo.
3. El PLAN no puede afirmar que un documento es `verified`. Sólo puede decir que
   se intentará verificar. Tras escribir las claims y evidencias, la ejecución
   asignará `verified`, `ambiguous` o `needs-review` según corresponda.
4. El único comando de validación aceptable desde la raíz del repositorio es:

   ```sh
   python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_knowledge.py knowledge
   ```

Si uno de estos controles falla, corrige el PLAN y vuelve a mostrarlo. No pidas
ni aceptes `CONFIRMO` hasta que se cumplan todos.

Controles adicionales obligatorios:

5. El número declarado de archivos debe ser exactamente igual al número de rutas
   de archivo únicas enumeradas. Calcula y muestra el desglose por ruta o tipo;
   si no coincide, el PLAN falla.
6. Cada documento `kind: constraint` representa una sola propiedad medible del
   sistema. No combines límites independientes en un único documento: por
   ejemplo, canales de audio y número de SFX son documentos separados; del mismo
   modo, no combines métricas de CPU distintas si tienen valor, unidad o ámbito
   propios. Las claims relacionadas pueden convivir sólo si describen la misma
   propiedad.
7. Para cada archivo planificado, su sección fuente debe aparecer en la lista de
   secciones que se leerán durante la ejecución. Si se planea `#INCLUDE`, el plan
   debe incluir la sección del manual que documenta `#INCLUDE`; no basta con
   inferirla desde estructura de programa. Una fuente no declarada debe añadirse
   al contrato y confirmarse de nuevo, o el archivo debe retirarse del plan.

Estos siete controles son parte de la puerta de calidad y se verifican antes de
mostrar `Esperando CONFIRMO`.

Controles de aprobación para restricciones:

8. El PLAN debe incluir la tabla atómica completa de **todas** las restricciones
   planificadas. Debe contener exactamente una fila por archivo `kind:
   constraint`, con las ocho columnas `ruta | id | subject | property | operator
   | value | unit | scope`. Si falta la tabla, falta una fila, una ruta se repite
   o el número de filas no coincide con el número declarado de restricciones, el
   PLAN falla y no puede pedir `CONFIRMO`.
9. Una restricción pertenece a una única capacidad o contrato de uso. Cuando un
   mismo límite numérico se aplica a APIs distintas, crea un documento por API:
   el límite de resultados de `peek()` y el límite de valores de `poke()` deben
   ser `peek-result-max` y `poke-values-max`, nunca `peek-poke-burst-max`.
   Comparte la evidencia fuente mediante claims y `relationships`, no agrupando
   consumidores distintos en `subject`, `property` o `scope`.

No marques la puerta de calidad como aprobada si los controles 8 o 9 requieren
interpretación: divide primero la restricción y vuelve a contar las rutas.

La tabla debe usar literalmente esta cabecera Markdown, sin abreviarla ni
reemplazarla por un resumen de cuatro columnas:

```text
| ruta | id | subject | property | operator | value | unit | scope |
| --- | --- | --- | --- | --- | --- | --- | --- |
```

No marques `8. ✅` basándote en una lectura o conteo visual de la tabla: ese
control ya falló en producción a pesar de esta misma instrucción explícita.
Márcalo `✅` únicamente si `--verify-plan-md` (ver sección "Verificación
mecánica obligatoria del PLAN.md") terminó con
`PLAN.md verificado: coincide con el manifiesto`. Si no ejecutaste ese comando
sobre el PLAN.md final, o si reportó una discrepancia, el control 8 es `❌` sin
excepción, y no puede marcarse `✅` "de todos modos" aunque la tabla parezca
correcta a simple vista.

## Contrato atómico de restricciones

Para cada archivo `kind: constraint` incluido en el PLAN, muestra una fila con
estas columnas antes de solicitar confirmación:

```text
ruta | id | subject | property | operator | value | unit | scope
```

La fila debe corresponder exactamente a un único bloque `constraint:` que se
escribirá en el documento. `value` es escalar y `property` nombra una sola
propiedad. No se permiten listas, valores separados por comas, ni combinaciones
de dos límites en una misma fila. Si una fuente ofrece dos números relacionados
pero con unidades, ámbitos o propiedades propios, crea dos documentos y dos
filas, aunque puedan enlazarse mediante `relationships`.

La misma regla aplica a consumidores: un valor idéntico no justifica combinar
dos APIs, registros o capacidades. La columna `scope` debe describir un único
consumidor; usa el ID del documento API cuando exista.

Ejemplo correcto:

```text
knowledge/constraints/cpu-throughput.md | pico8.constraint.cpu-throughput | cpu | vm-instruction-throughput | max | 4000000 | vm-instructions/second | runtime
```

Ejemplos que deben dividirse:

```text
"4 canales y 64 SFX"        -> audio-channels + sound-instruments
"8 MHz y 2 ciclos/instr."   -> cpu-clock + cpu-cycles-per-instruction
```

En ejecución, no escribas un documento de restricción hasta que su bloque
`constraint:` tenga los campos `subject`, `property`, `operator`, `value`,
`unit`, `scope` y `enforcement`. El validador rechazará los documentos que no
cumplan esta estructura.

Conserva siempre la modalidad de la fuente. Si el manual usa expresiones como
"around", "approximately", "about" o equivalentes, usa `operator: approx` y
repite el calificativo en la claim; nunca lo conviertas en `fixed` o `exact`.
Del mismo modo, el valor del bloque `constraint:` debe conservar la unidad y
granularidad expresadas por la fuente. Una conversión (por ejemplo, `32k` a
bytes) sólo puede aparecer en una claim o nota `derived`, claramente etiquetada,
y no puede sustituir el valor factual del límite.

## Puerta de clasificación de incertidumbre

Antes de añadir una entrada a `## Ambigüedades`, clasifícala como exactamente una
de estas categorías:

- `ambiguity`: dos o más claims de las secciones autorizadas para la fase son
  incompatibles para la misma pregunta. Registra los IDs o localizadores de las
  claims y explica por qué no pueden coexistir.
- `source-limitation`: la fuente no especifica un detalle necesario. Indica qué
  falta, sin inferir su comportamiento.
- `cross-domain-dependency`: otra sección o fase contiene información adicional
  sobre la misma API, registro o recurso. Registra la sección o ID pendiente en
  `## Documentos relacionados` o en el índice; no es una contradicción.
- `approximation`: la fuente usa un calificador como "around" o
  "approximately". Conserva el calificativo en la claim y el operador; no lo
  presentes como conflicto.
- `source-typo`: errata tipográfica localizable que no cambia el contrato
  normalizado. Regístrala como nota de fuente, no como ambigüedad semántica.

Información sobre bits, parámetros, casos de uso o efectos diferentes de un
mismo registro no es una ambigüedad si puede coexistir como parte de un bitfield
o de una API más amplia. La ausencia de una sección fuera de alcance tampoco es
una ambigüedad: usa `cross-domain-dependency` y deja el detalle pendiente para
la fase propietaria.

En el PLAN, muestra las incertidumbres previstas en una tabla:

```text
documento | categoría | evidencia/localizador | acción
```

Si no hay ambigüedades reales, declara `Ninguna` para esa categoría. No pidas
`CONFIRMO` si una entrada marcada `ambiguity` no contiene dos fuentes
incompatibles y autorizadas.

La columna `categoría` de la tabla es un enum cerrado: sólo acepta
`ambiguity`, `source-limitation`, `cross-domain-dependency`, `approximation` o
`source-typo`. Una etiqueta como `compatible claims`, `nota`, `riesgo` o similar
no es válida. Si dos claims son compatibles, no se incluyen como incertidumbre:
se documentan normalmente en sus documentos y, si ayuda a la recuperación, se
unen con `relationships`.

## Unidades de restricciones ligadas a APIs

Cuando una restricción limite un parámetro, retorno o cantidad de una API, la
columna `unit` debe expresar la semántica del contrato de esa API, no el formato
interno de almacenamiento. Por ejemplo:

```text
PEEK(ADDR, [N]) máximo N=8192  -> unit: results
POKE(ADDR, VAL1, VAL2, ...)    -> unit: values
```

Un resultado o valor puede estar representado internamente como byte, palabra o
número, pero esa representación sólo se documenta como un hecho adicional si la
fuente la especifica. No cambies `results` o `values` por `bytes` salvo que el
límite fuente esté expresado explícitamente en bytes.

En la puerta de calidad del PLAN, verifica y declara que toda restricción cuyo
`scope` referencia un ID `pico8.api.*` usa la unidad semántica de la firma. Si
no se puede determinar, usa `source-limitation` y no inventes una unidad.

## Plantillas

Parte de las plantillas de `templates/`. Usa `concept.md` para `kind: concept`;
no adaptes una plantilla de API o restricción para suplirla. No elimines campos
obligatorios. El formato exacto y las reglas semánticas están en
`references/knowledge-schema.md`.

## Prohibiciones

- No atribuyas al manual APIs, límites, rendimiento o comportamiento que no
  aparezcan en la fuente.
- No conviertas una ambigüedad en una recomendación sin etiquetarla como
  `derived` o `ambiguous`.
- No pongas datos de terceros, foros o recuerdos del modelo bajo el mismo
  `source_id` que el manual oficial.
