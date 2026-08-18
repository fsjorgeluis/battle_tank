## 1. Limpiar codigo obsoleto

- [x] 1.1 Eliminar constante `SPR_CANNON` de `src/const.lua`
- [x] 1.2 Eliminar `TURRET_OFFSET` de `src/const.lua`
- [x] 1.3 Eliminar `ROT_SPEED` de `src/const.lua`
- [x] 1.4 Eliminar `BARREL_LEN` de `src/const.lua`
- [x] 1.5 Eliminar `turret_a` de `player.lua`
- [x] 1.6 Eliminar `prev_btn0`, `prev_btn1` de `player.lua`
- [x] 1.7 Eliminar funcion `ut_rspr()` de `src/util.lua`

## 2. Constantes nuevas

- [x] 2.1 Agregar `SPR_PLAYER_FLAT=1` a `src/const.lua` (sprite canon izquierda)
- [x] 2.2 Agregar tabla `MUZZLE` a `src/const.lua`:
  ```lua
  MUZZLE={[0]={3,0},[0.25]={0,-3.5},[0.5]={-3,0},[0.75]={0,3.5}}
  ```

## 3. Modelo de movimiento 4-direcciones

- [x] 3.1 Flechas establecen `body_a` directamente (0.5, 0, 0.75, 0.25)
- [x] 3.2 Aceleracion con inercia (aceleracion + friccion)
- [x] 3.3 Sin retroceso (↓ = abajo, no "atras")
- [x] 3.4 Sin modo apuntado (btn(4) sin funcion)

## 4. Sprite y renderizado con flip

- [x] 4.1 `pl_draw` usa `spr()` con flip segun body_a:
  - ↑ (0.25): `spr(0, x-4, y-4)`
  - ↓ (0.75): `spr(0, x-4, y-4, 1,1, false, true)`
  - ← (0.5): `spr(1, x-4, y-4)`
  - → (0): `spr(1, x-4, y-4, 1,1, true, false)`
- [x] 4.2 Fogonazo usa `MUZZLE[body_a]` en vez de coordenadas polares

## 5. Balas

- [x] 5.1 `bl_fire` usa `body_a` directo (sin `turret_a`)
- [x] 5.2 `bl_fire` usa `MUZZLE[body_a]` para posicion de spawn
- [x] 5.3 Retroceso opuesto a `body_a`

## 6. Verificacion

- [x] 6.1 Ejecutar cartucho: flecha derecha → tanque apunta y va a la derecha
- [x] 6.2 Flecha izquierda → tanque apunta y va a la izquierda
- [x] 6.3 Flecha arriba → tanque apunta y va arriba
- [x] 6.4 Flecha abajo → tanque apunta y va abajo
- [x] 6.5 Disparo → bala sale en la direccion del canon visible
- [x] 6.6 Fogonazo → aparece en punta correcta del canon
- [x] 6.7 Sin tecla → tanque frena suavemente (friccion)
- [x] 6.8 Colision bala-enemigo sin cambios
- [x] 6.9 Tokens con `info()`
