## Context

La hoja de sprites del cartucho (`battle_tank.p8`, sección `__gfx__`) tiene 9 slots no vacíos de los 128 disponibles, pero son en su mayoría duplicados byte-idénticos:

- Sprites `0..3`: cuatro copias idénticas del tanque del jugador (cuerpo de 6x6 centrado sobre 8x8, colores {1,2}).
- Sprites `4..7`: cuatro copias idénticas del tanque enemigo (mismo cuerpo, colores {6,7}).
- Sprite `8`: el corazón, único.

El esquema de render actual (`src/player.lua`) calcula un sector de 1/8 (`ut_snap_sector`) y selecciona sprite + volteos (`ut_sprite_for_sector`) pensado para arte direccional. El arte nunca se dibujó direccional: el cuerpo es simétrico y el cañón se pinta de forma procedural con `line()`, por lo que los volteos no producen ningún cambio visual (`pico8.api.spr` soporta volteos, pero aplicarlos a un sprite simétrico es inerte). Los sprites `5..7` no los referencia ningún código.

Además, el spec actual `player-movement/spec.md` exige "sprite de 12x10 rectangular", divergente de la implementación real (sprite de 8x8 con cuerpo de 6x6 y `SPR_SIZE=8`).

## Goals / Non-Goals

**Goals:**
- Un único sprite por entidad: `[0]=jugador`, `[4]=enemigo`, `[8]=corazón` (3 de 128 usados, `pico8.constraint.sprite-count`).
- Cero la maquinaria de sectores/volteos en `src/util.lua` (`ut_snap_sector`, `ut_sprite_for_sector`), que queda como código muerto.
- Simplificar `pl_draw` a una llamada `spr(SPR_PLAYER, ...)` directa; resultado visual idéntico al actual.
- Alinear `player-movement/spec.md` con la realidad (sprite de 8x8, cuerpo de 6x6).
- Usar la constante `SPR_PLAYER` ya definida en `src/const.lua` (hoy sin uso).

**Non-Goals:**
- Reorganizar los índices de sprites (no se mueven el enemigo ni el corazón a slots contiguos).
- Rediseñar el arte del tanque (no se dibuja un tanque 12x10).
- Añadir nuevos tipos de enemigos ni animaciones.
- Cambiar `SPR_SIZE` (se mantiene en 8).

## Decisions

### D1: Borrar los sprites duplicados y conservar los índices actuales
Se ponen a cero los slots `1,2,3` y `5,6,7` en `__gfx__`, conservando `0`, `4` y `8` con sus valores actuales.
- **Alternativa descartada**: reorganizar a `[0] [1] [2]` contiguos. Ahorra índices pero obliga a tocar `SPR_ENEMY`/`SPR_HEART` y no aporta utilidad con 125 slots libres.
- **Cambio observable**: ninguno; los sprites 1-3 y 5-7 no se dibujan hoy.

### D2: Eliminar `ut_snap_sector` y `ut_sprite_for_sector`
Ambas funciones (`src/util.lua:18-36`) dejan de usarse al simplificar `pl_draw`. Se eliminan para salvar ≈50 tokens (`pico8.constraint.token-limit`). `ut_aabb_overlap` y `ut_clamp` se conservan (se usan en `player.lua`, `bullet.lua`).
- **Alternativa descartada**: mantenerlas "por si acaso" para futuro arte direccional. Mantiene código muerto (~80 tokens) y el skill `pico8-development` desaconseja ampliar funcionalidad no solicitada.

### D3: `pl_draw` dibuja el sprite del jugador directamente
Reemplazo en `src/player.lua:113-115`:

```lua
spr(SPR_PLAYER, pl.x-SPR_SIZE/2, pl.y-SPR_SIZE/2)
```

Usa la constante `SPR_PLAYER` (0) ya existente (`src/const.lua:33`). El cañón se mantiene como `line()` procedural hacia `turret_a` (sin cambios). Referencia: `pico8.api.spr`.

### D4: Actualizar spec `player-movement` a la realidad implementada
El requisito "sprite 12x10 rectangular" se corrige a "sprite de 8x8 con cuerpo de 6x6 centrado y cañón procedural". Se actualiza también `openspec/specs/enemies/spec.md`? No: el spec de enemigos no menciona tamaño, solo "sprite propio que lo distinga visualmente" (se cumple). Solo `player-movement` tiene deriva.

## Riesgos / Trade-offs

- [Regresión visual si un sprite distinto se dibujaba oculto] → Los 6 slots borrados son byte-idénticos a su gemelo y los `5..7` no se referencian (grep `spr(` confirma 3 usos: `player`, `enemy`, `ui`). No hay cambio visible.
- [Algún código futuro espere `ut_sprite_for_sector`] → No: la búsqueda global (src, openspec) solo halla referencias en `player.lua`, que se actualiza en este mismo cambio.
- [Spec y código vuelvan a divergir] → El spec corregido describe exactamente la implementación (8x8, cuerpo 6x6, cañón por `line()`).
- [Presupuesto] → Sprites: 3/128 (antes 9/128). Tokens: −50. ROM: −96 bytes en `__gfx__`. CPU/frame: neutro (una llamada `spr` en vez de dos funciones + `spr`).

## Presupuestos previstos

- Tokens: −50 (liberados por la eliminación de 2 funciones) (`pico8.constraint.token-limit`, verificación con `pico8.api.info`).
- Sprites: 3 de 128 dedicados (`pico8.constraint.sprite-count`).
- ROM: 6 slots de sprite × 16 bytes = −96 bytes (`pico8.constraint.cart-rom-size`).
- CPU/frame: igual o menor (se elimina la resolución de sector por frame).