# PLAN — Fase map-memory

## Contrato de fase

- Fase: map-memory
- Dominios autorizados: mapa y memoria
- Rutas autorizadas: knowledge/api-map/, knowledge/constraints/, knowledge/index.md
- Objetivo: 2 documentos nuevos (1 API, 1 restricción) y actualización del índice
- Fuente: sources/pico8-manual-v0.2.7.html

## Salida validada del manifiesto

<!-- PICO8-PLAN-MANIFEST-START: no resumir ni editar este bloque -->
## Salida validada del manifiesto

Fase: `map-memory`
Rutas creadas: 2 · Rutas modificadas: 1 · Restricciones: 1

### Archivos creados

| ruta | kind | id |
| --- | --- | --- |
| knowledge/api-map/mget.md | api | pico8.api.mget |
| knowledge/constraints/map-width.md | constraint | pico8.constraint.map-width |

### Archivos modificados

- `knowledge/index.md`

### Tabla atómica de restricciones

| ruta | id | subject | property | operator | value | unit | scope |
| --- | --- | --- | --- | --- | --- | --- | --- |
| knowledge/constraints/map-width.md | pico8.constraint.map-width | map | grid-width | fixed | 128 | tiles | default map layout |

### Incertidumbres previstas

| documento | categoría | evidencia/localizador | acción |
| --- | --- | --- | --- |
| knowledge/constraints/map-width.md | cross-domain-dependency | 6.7 > Remapping Graphics and Map Data > 0x5F57 MAP SIZE | Registrar que el ancho es el valor por defecto y puede remapearse via 0x5F57; no tratarlo como límite absoluto de hardware. |

<!-- PICO8-PLAN-MANIFEST-END -->

## Puerta de calidad

- Rutas nuevas/modificadas: 2 creadas + 1 modificada.
- Restricciones: 1 archivo = 1 fila atómica.
- PLAN.md verificado: coincide con el manifiesto.

Esperando CONFIRMO para ejecutar esta fase.
