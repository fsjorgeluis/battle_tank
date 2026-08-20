## Why

El mapa actual solo distingue entre "sólido" y "no sólido", por lo que todos los tiles se sientan iguales bajo el tanque. Esto limita la variedad táctica y la identidad de cada zona del campo de batalla. Se necesita un sistema de tipos de tile que afecte la navegación y el render, sentando la base para futuros niveles con terreno variado.

## What Changes

- Definir un set de tipos de tile por **comportamiento** (no por bioma), usando los flags de sprite de PICO-8 (`fget`/`fset`) para la física de movimiento del tanque (`pico8.api.fget`, `pico8.api.fset`):
  - **Ladrillo destructible**: bloquea y se destruye con disparos (ya existe).
  - **Muro/roca indestructible**: bloquea siempre (ya existe).
  - **Bosque/follaje**: el tanque pasa por debajo, se dibuja en una capa de render **sobre** el tanque.
  - **Hielo**: transitable, aplica deslizamiento/inercia al movimiento.
  - **Arena/fango**: transitable, reduce la velocidad y la aceleración del tanque.
  - **Agua**: impasable para el tanque; las balas la cruzan.
- Usar una tabla en código (`BULLET_TILE_ACT`) para modelar la interacción bala↔tile, que tiene más de dos estados posibles (atraviesa / destruye / rebota / victoria / game over).
- Cambiar el modelo de movimiento del jugador para separar la dirección del cañón (`body_a`) del vector de velocidad (`vx, vy`), permitiendo el deslizamiento real en hielo (`pico8.api.cos`, `pico8.api.sin`).
- Aplicar multiplicadores de fricción, velocidad máxima y aceleración según el tile bajo el centro del tanque.
- Añadir una pasada de render posterior a las entidades para los tiles con flag `OVERLAY` (bosque), de modo que el follaje oculte visualmente al tanque (`pico8.api.spr`).
- Incluir sprites placeholder distinguibles para hielo, arena, bosque y agua en la hoja de sprites (`pico8.constraint.sprite-sheet-size`, `pico8.constraint.sprite-count`).
- Dejar la generación procedural del mapa sin cambios; este cambio solo expone el comportamiento y la física.

**Fuera de alcance**: generación de biomas por nivel, jefe, efectos ambientales, animación de agua, daño por tile.

## Capabilities

### New Capabilities
- `tile-behaviour`: Define los tipos de tile por comportamiento, sus flags de sprite para física de movimiento y la tabla de interacción bala↔tile.
- `tile-physics`: Define cómo el tile bajo el tanque altera la aceleración, la fricción y la velocidad máxima, incluyendo el deslizamiento en hielo.
- `tile-rendering`: Define la capa de render de tiles `OVERLAY` que se dibuja después de las entidades para ocultar visualmente al tanque bajo el bosque.

### Modified Capabilities
- `player-movement`: El tanque pasa de usar `speed` escalar a un vector de velocidad (`vx, vy`) independiente de `body_a`, y aplica física según el tile actual.
- `projectiles`: Las balas ahora usan una tabla de lookup (`BULLET_TILE_ACT`) para decidir si destruyen, rebotan, atraviesan o activan victoria/game over al impactar un tile.

## Impact

- `src/const.lua`: nuevas constantes de tiles, sprites, flags, parámetros de física y la tabla `BULLET_TILE_ACT`.
- `src/map.lua`: configuración de flags en `map_init()`, helpers de consulta de tile (`map_get_ground_type`, `map_tile_is`) y dibujo de overlay.
- `src/player.lua`: refactor de movimiento a vector de velocidad con física por tile.
- `src/bullet.lua`: uso de `BULLET_TILE_ACT[tile]` para resolver impactos con tiles.
- `src/ui.lua`: llamada a `map_draw_overlay()` después de las entidades.
- `battle_tank.p8`: sección `__gfx__` ampliada con sprites placeholder para los nuevos tiles.

## Presupuestos afectados

- **Tokens**: conteo actual aproximado de ~4.925 tokens; estimado de incremento de ~260 tokens (incluyendo la tabla `BULLET_TILE_ACT`), quedando en ~5.185. Límite de PICO-8: 8.192 (`pico8.constraint.token-limit`). El número exacto debe confirmarse con `info()` durante las pruebas manuales.
- **Sprites**: +6 sprites placeholder (índices 20-25), quedando 122 libres.
- **Mapa**: sin cambios en la generación procedural ni en el tamaño del mapa (16×14).
- **CPU/frame**: impacto mínimo: una pasada de 16×14 tiles para overlay, una raíz cuadrada por frame para clamp de velocidad, y 1-2 consultas `fget`/`mget` por frame.
- **Audio / entrada**: sin cambios.
