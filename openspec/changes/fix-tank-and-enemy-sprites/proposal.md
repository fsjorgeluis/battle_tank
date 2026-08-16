## Why

El sprite del enemigo (índice 4) está completamente vacío (todos ceros en `__gfx__`), por lo que es invisible durante el juego. Esto viola el spec `enemies/spec.md` que requiere "un sprite propio que lo distinga visualmente del jugador". Además, el tanque del jugador tiene un sprite demasiado pequeño (8x8 píxeles) que no se visualiza correctamente como un tanque rectangular.

## What Changes

- Rediseñar sprites del tanque jugador de 8x8 a 12x10 píxeles con forma más rectangular
- Crear sprite del enemigo con el mismo tamaño (12x10) pero diferente color
- Actualizar constante `SPR_SIZE` de 8 a 12 en `src/const.lua`
- Mantener el cañón como `line()` actual (sin cambios)
- El enemigo inicialmente usará el mismo sprite que el jugador con color diferente

## Capabilities

### New Capabilities

Ninguna. Este es un bugfix que corrige implementación existente.

### Modified Capabilities

- `enemies`: Corregir sprite vacío - el spec requiere sprite propio visible pero la implementación tiene un sprite de 8x8 vacío (todos ceros)
- `player-movement`: Actualizar tamaño de sprite de 8x8 a 12x10 para mejor visualización del tanque rectangular

## Impact

- `battle_tank.p8`: Sección `__gfx__` - nuevos sprites de 12x10
- `src/const.lua`: Constante `SPR_SIZE` (8→12)
- `src/player.lua`: Ajustar posición de dibujo para sprite más grande
- `src/enemy.lua`: Ajustar posición de dibujo para sprite más grande
- Sprite size: 8x8 → 12x10 (pico8.constraint.sprite-size)
- Sprites usados: 2 (jugador + enemigo) de 128 disponibles

## Presupuesto Afectado

- Sprites: 2 de 128 (pico8.constraint.sprite-count)
- Tokens: Sin cambio significativo
- ROM: Sin cambio significativo
- CPU/frame: Sin cambio significativo
