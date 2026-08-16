# Plantilla obligatoria de PLAN de fase

Usa esta plantilla antes de pedir `CONFIRMO`. Los campos entre `<...>` se
reemplazan; no se eliminan las tablas obligatorias.

```md
# PLAN — Fase <id>

## Contrato de fase

- Fase: <id>
- Dominios autorizados: <lista cerrada>
- Rutas autorizadas: <lista cerrada>
- Objetivo: <resultado>
- Fuente: <ruta, versión, SHA-256>

## Salida validada del manifiesto

Pega sin modificar el bloque emitido por:

```sh
python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_phase_plan.py /tmp/pico8-phase-<fase>.json --render-plan
```

No añadas listas o tablas manuales de archivos, restricciones o incertidumbres.

## Puerta de calidad

- Rutas nuevas/modificadas: <número y desglose>.
- Restricciones: <número de archivos> = <número de filas atómicas>.
- Tabla atómica: ocho columnas visibles en la cabecera y en cada fila.
- APIs: sólo funciones/callbacks; sintaxis y operadores documentados como claims.
- Fuentes: cada archivo tiene una sección fuente declarada.
- Validación: `python3 .opencode/skills/pico8-manual-to-knowledge/scripts/validate_knowledge.py knowledge`

Esperando CONFIRMO para ejecutar esta fase.
```
