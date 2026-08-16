# Manifiesto de PLAN v1

Durante el paso PLAN, crea un JSON temporal bajo `/tmp`; nunca dentro de
`knowledge/`. El manifiesto es la fuente de verdad para el PLAN Markdown.

```json
{
  "phase": "map-memory",
  "allowed_paths": [
    "knowledge/api-map/",
    "knowledge/api-memory/",
    "knowledge/constraints/",
    "knowledge/index.md"
  ],
  "created": [
    {"path": "knowledge/api-map/mget.md", "kind": "api", "id": "pico8.api.mget"},
    {"path": "knowledge/constraints/map-size.md", "kind": "constraint", "id": "pico8.constraint.map-size"}
  ],
  "modified": ["knowledge/index.md"],
  "constraints": [
    {
      "path": "knowledge/constraints/map-size.md",
      "id": "pico8.constraint.map-size",
      "subject": "map",
      "property": "grid-dimensions",
      "operator": "fixed",
      "value": "128x32",
      "unit": "tiles",
      "scope": "default map"
    }
  ],
  "uncertainties": [
    {
      "document": "knowledge/api-map/tline.md",
      "category": "source-limitation",
      "evidence": "6.6 > Setting TLINE Precision",
      "action": "No inferir la dirección del registro."
    }
  ]
}
```

`created` incluye todos los archivos nuevos, incluso restricciones. `modified`
incluye únicamente archivos existentes que cambiarán. Una restricción debe
aparecer una vez en `created` con `kind: constraint` y una vez en
`constraints`. Sólo las categorías de incertidumbre permitidas por el skill son
válidas.
