## Why

El sprite unificado del jugador (casco + canon integrado mirando arriba)
requiere un modelo de control donde cada flecha apunta Y mueve en esa direccion.
El modelo previo (rotar sprite con `ut_rspr`) producia visuales invertidos en
arriba/abajo y dependia de formulas de counter-rotation fragiles.

Este cambio implementa un modelo 4-direcciones con sprites estaticos + flip:
sprite 0 (canon arriba) y sprite 1 (canon izquierda), usando `spr()` con
`flip_x`/`flip_y` para las 4 orientaciones. Sin trigonometria en el
renderizado.

## What Changes

- **Modelo de movimiento**: Cada flecha (←→↑↓) establece direccion cardinal
  fija (0.5, 0, 0.75, 0.25). El tanque acelera en esa direccion con
  inercia (aceleracion + friccion). Sin retroceso (↓ no es "atras").
- **Sprite**: Dos sprites estaticos + flip. Sprite 0 (arriba) con flip_y para
  abajo. Sprite 1 (izquierda) con flip_x para derecha. Eliminacion de
  `ut_rspr()`.
- **Sin modo apuntado**: btn(4) ya no rota canon independientemente.
  El canon siempre sigue la direccion del cuerpo.
- **Sin turret_a**: Se elimina la variable `turret_a`. El canon y el cuerpo
  apuntan siempre en la misma direccion.
- **Fogonazo**: Tabla precalculada `MUZZLE` con offsets por direccion, sin
  coordenadas polares.
- **Snapping inline**: Sin `ut_snap4()`. Direccion se establece directamente
  desde la tecla presionada.
- **Constantes eliminadas**: `TURRET_OFFSET`, `ROT_SPEED`, `BARREL_LEN`.
- **Constantes nuevas**: `SPR_PLAYER_FLAT` (sprite 1), `MUZZLE` (offsets por
  body_a).

## Capabilities

### New Capabilities

Ninguna — este cambio ajusta implementacion existente.

### Modified Capabilities

- `player-movement`: Modelo 4-direcciones. Flechas = direccion cardinal.
  Aceleracion con inercia. Sin retroceso. Sin modo apuntado.
- `projectiles`: Direccion de bala con `body_a` directo. Fogonazo con
  tabla `MUZZLE`.
- `player-rendering`: Sprite con `spr()` + flip. Sin rotacion de pixels.

## Impact

- **Archivos**: `src/util.lua`, `src/player.lua`, `src/bullet.lua`,
  `src/const.lua`.
- **Eliminacion**: `ut_rspr()`, `SPR_CANNON`, `turret_a`, `TURRET_OFFSET`,
  `ROT_SPEED`, `BARREL_LEN`, `prev_btn0`, `prev_btn1`.
- **Correccion**: Renderizado del sprite (flip en vez de rotacion), posicion
  del fogonazo (tabla MUZZLE en vez de polares).
- **Tokens**: Reduccion neta (menos variables, menos logica, sin ut_rspr).
- **CPU**: Reduccion neta (sin snapping, sin modo apuntado, sin
  sget/pset de ut_rspr).
