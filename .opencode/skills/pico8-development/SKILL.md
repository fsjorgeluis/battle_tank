---
name: pico8-development
description: Diseña, implementa y revisa cambios de juegos PICO-8 consultando conocimiento local verificado y vinculándolo a OpenSpec.
metadata:
  opencode/slash: "true"
---

# Desarrollo PICO-8 basado en conocimiento

## Regla de autoridad

Para cualquier decisión específica de PICO-8, la autoridad es `knowledge/`,
generada por el skill `pico8-manual-to-knowledge`. No inventes APIs, firmas,
límites ni efectos. No modifiques `knowledge/` ni `sources/` durante una tarea de
desarrollo: si falta información, informa del hueco y pide ejecutar el skill de
ingesta o consultar una fuente autorizada.

## Antes de modificar código

1. Lee `knowledge/index.md`.
2. Identifica los documentos pertinentes y léelos completos. Sólo carga los que
   guardan relación con el cambio: por ejemplo entrada, gráficos, mapa o límites.
   Al leer cada documento, revisa su campo `relationships` y abre también los
   documentos enlazados (`related`, `related-api`) si son relevantes para la
   tarea, aunque pertenezcan a otro dominio del índice. Las relaciones son
   bidireccionales por convención, pero no se recorren automáticamente: es
   responsabilidad del agente seguirlas.
3. Verifica que cada documento usado tenga `status: verified`. Si es `ambiguous`
   o `needs-review`, detén la decisión dependiente y decláralo como bloqueo.
4. Consulta las restricciones aplicables antes de escribir diseño o código.

## Límite de trabajo

No amplíes la funcionalidad solicitada ni propongas mecánicas adicionales durante
la misma tarea. Antes de editar, enumera los archivos de código y artefactos
OpenSpec que planeas modificar. Si el usuario no ha pedido explícitamente modo
autónomo, espera su confirmación antes de editar. La falta de conocimiento es un
bloqueo de documentación, no autorización para procesar otras secciones del
manual.

## Flujo OpenSpec

Para cada cambio funcional, crea o actualiza el cambio OpenSpec existente. Incluye
estos apartados en propuesta/diseño/tareas, adaptándolos a las plantillas del
repositorio:

- Objetivo jugable y comportamiento observable.
- Documentos de conocimiento usados: IDs exactos y sus claims relevantes.
- Restricciones PICO-8 aplicables y presupuesto previsto.
- Criterios de aceptación reproducibles, incluyendo comportamiento de entrada y
  representación visible cuando corresponda.
- Estrategia de pruebas: ejecución del cartucho, caso normal, bordes y regresión.
- Incertidumbres o decisiones derivadas, separadas de los hechos documentados.

No implementes una API o comportamiento hasta que el cambio tenga criterios de
aceptación comprobables.

## Durante la implementación

- Mantén el código dentro de las restricciones consultadas.
- En comentarios técnicos o documentación del cambio, referencia IDs de
  conocimiento (`pico8.api...`, `pico8.constraint...`), no afirmaciones sin
  fuente.
- Si surge una API que no está en `knowledge/`, no la supongas. Registra el hueco
  y vuelve al skill de ingesta.

## Entorno de ejecución

Para ejecutar y verificar un cartucho, el agente debe comprobar que
el ejecutable de PICO-8 está disponible en el entorno de ejecución.

La presencia del archivo `.p8` no implica que PICO-8 esté instalado.

Antes de ejecutar el cartucho:

1. Verificar que el ejecutable de PICO-8 está disponible y puede ser
   invocado desde el entorno de ejecución de OpenCode.
2. Verificar que puede invocarse desde la terminal.
3. Ejecutar el cartucho desde el directorio raíz del proyecto para
   preservar las rutas relativas utilizadas por `#INCLUDE`.
4. Si PICO-8 no está disponible, no intentar ejecutar el cartucho
   mediante Lua estándar.
5. Declarar la verificación de ejecución como bloqueada y continuar
   únicamente con las verificaciones que puedan realizarse sin PICO-8.
6. No inventar comandos, argumentos o rutas de PICO-8; cualquier
   procedimiento específico debe estar respaldado por conocimiento
   verificado o una fuente autorizada.

## Cierre

1. Ejecuta las pruebas disponibles y el cartucho en PICO-8 cuando el entorno lo
   permita.
2. Revisa que los criterios de aceptación se cumplan y que no haya afirmaciones
   técnicas no vinculadas a IDs `verified`.
3. Informa: documentos consultados, restricciones comprobadas, pruebas ejecutadas
   y limitaciones que no pudieron verificarse.
