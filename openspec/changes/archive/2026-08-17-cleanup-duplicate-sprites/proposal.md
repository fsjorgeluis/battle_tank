## Why

La hoja de sprites (`__gfx__`) contiene sprites duplicados: los slots 0-3 son cuatro copias byte-idénticas del tanque del jugador y los slots 4-7 otras cuatro copias idénticas del enemigo (sprites de 8x8 en hoja de 128x128, `pico8.constraint.sprite-size`). El esquema de "4 sprites base + volteos" (`ut_sprite_for_sector`, `src/util.lua`) se diseñó para arte direccional que nunca se dibujó: el cuerpo es simétrico y el cañón se pinta con `line()`, por lo que los volteos no producen ningún cambio visual. Además, los sprites 5-7 no los referencia ningún código (código muerto). Limpiarlos deja un sprite único por entidad y simplifica el render.

## What Changes

- Borrar los sprites duplicados 1, 2, 3 y 5, 6, 7 de la sección `__gfx__` del cartucho (ponerlos a cero), dejando un único sprite por entidad: `[0]=jugador`, `[4]=enemigo`, `[8]=corazón`.
- Eliminar la maquinaria de volteos por sector: `ut_snap_sector` y `ut_sprite_for_sector` de `src/util.lua` (≈50 tokens). Se conservan `ut_aabb_overlap` y `ut_clamp`, que siguen en uso.
- Simplificar `pl_draw` en `src/player.lua` para dibujar directamente `spr(SPR_PLAYER, ...)` en lugar de calcular sector y volteos. Resultado visual idéntico.
- Usar la constante `SPR_PLAYER` (hoy definida en `src/const.lua` pero sin uso).
- Corregir la deriva de spec: `player-movement/spec.md` exige "sprite de 12x10 rectangular", pero el arte real es un sprite de 8x8 con cuerpo de 6x6. Actualizar el requisito a la realidad implementada.

## Capabilities

### New Capabilities

Ninguna.

### Modified Capabilities

- `player-movement`: Corregir el requisito de tamaño de sprite del tanque del jugador de 12x10 rectangular a 8x8 (cuerpo de 6x6 centrado), alineando el spec con la implementación.

## Impact

- `battle_tank.p8`: Sección `__gfx__` — slots 1, 2, 3, 5, 6, 7 a cero; se conservan 0, 4 y 8.
- `src/util.lua`: Eliminación de `ut_snap_sector` y `ut_sprite_for_sector` (≈50 tokens de código).
- `src/player.lua`: `pl_draw` simplificado a una llamada `spr(SPR_PLAYER, ...)`.
- `openspec/specs/player-movement/spec.md`: Requisito de tamaño de sprite actualizado.
- Presupuesto afectado:
  - Sprites usados: 3 de 128 (antes 9 de 128) (`pico8.constraint.sprite-count`).
  - Tokens: se liberan ≈50 tokens de código (`pico8.constraint.token-limit`).
  - ROM: se liberan 6 slots de 16 bytes (96 bytes) en `__gfx__`.
  - CPU/frame: sin cambio significativo (una sola llamada `spr` en vez de dos funciones y un `spr`).
