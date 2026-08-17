---
name: pico8-sprite-viewer
description: Render PICO-8 sprites as ASCII art so you can see and understand the game's sprites/images/pixel art. Use when the user asks to see, understand, inspect, or render sprites, the sprite sheet, images, or art — e.g. "ver los sprites", "cómo se ve", "render sprite", "ascii".
metadata:
  opencode/slash: "true"
---

# Visualización de sprites como ASCII

## Propósito

Renderiza sprites del cartucho `.p8` como arte ASCII para poder "ver" el arte
sin abrir el editor de PICO-8. Es una herramienta de lectura: no modifica el
cartucho, `knowledge/` ni `sources/`.

## Ejecución

Ejecuta el script desde la raíz del proyecto (preserva rutas relativas):

```sh
python3 .opencode/skills/pico8-sprite-viewer/scripts/sprite_to_ascii.py battle_tank.p8 --sprite 0
```

Opciones:

- `--sprite N` — renderiza el sprite de índice `N` (0..255).
- `--name NAME` — resuelve `SPR_<NAME>` desde `src/const.lua` (ej. `player`,
  `enemy`, `heart`) y renderiza ese sprite.
- `--all` — renderiza todos los sprites no vacíos en una cuadrícula etiquetada.
- `--palette` — muestra la paleta completa de 16 colores con sus índices.

## Convenciones de salida

- Cada pixel es 1 carácter: un carácter distinto por cada índice de color de la
  paleta (16 colores, `pico8.constraint.palette-color-count`).
- El color 0 (transparente/negro) se muestra como `.`.
- La leyenda imprime los índices realmente usados con su nombre del manual
  (`0 black, 1 dark_blue, 2 dark_purple, ... 15 peach`).
- Un sprite mide 8x8 píxeles (`pico8.constraint.sprite-size`); sprite `n` en la
  hoja 128x128 (`pico8.constraint.sprite-sheet-size`) ocupa columnas
  `(n%16)*8` y filas `(n//16)*8` (`pico8.concept.memory-layout`, formato texto:
  1 char hex = 1 pixel).

## Reglas de uso

- Ejecuta siempre el script; no inventes el aspecto de un sprite.
- Si el nombre no existe en `src/const.lua`, informa del hueco y sugiere
  `--sprite <N>` o `--all`.
- No modifiques `knowledge/` ni `sources/` durante esta tarea.