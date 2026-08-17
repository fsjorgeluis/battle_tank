## 1. Constantes y módulo de balas

- [x] 1.1 Añadir a `const.lua` constantes de disparo: `BULLET_SPEED=4`,
      `BULLET_SIZE=2`, `BULLET_LIFE=2.0`, `FIRE_COOLDOWN=0.35`, `KILL_POINTS=100`,
      `RESPAWN_TIME=2.0`, lista `ENEMY_ZONES` y color de bala
- [x] 1.2 Crear `src/bullet.lua` (tabla `bl`, prefijo `bl_`, lista `bullets`)
      con `bl_init()` para `bullets={}` y `bl_fire(x,y,a)` que respeta el
      cooldown, spawnea la bala en la boca del cañón (`BARREL_LEN`) y la
      inserta con `add()`
- [x] 1.3 Implementar `bl_update()`: mover cada bala por frame (`cos/sin`),
      detectar salida de arena (margen BULLET_SIZE) y timeout (`t()-born`),
      eliminar con `del()` reasignando lista local para iteración segura
- [x] 1.4 Implementar `bl_draw()`: dibujar cada bala con `rectfill()` en color
      de bala y el flag de colisión contra enemigos (`bl_hit(b)`)

## 2. Refactor de enemigo a lista + respawn

- [x] 2.1 Refactorizar `enemy.lua` de singleton `en` a lista `enemies`
      (`all()`/`add()`/`del()`): `en_init()` siembra un enemigo en
      `ENEMY_X,ENEMY_Y` con `alive=true`; `en_draw()` itera y dibuja solo vivos;
      cada elemento `{x,y,alive}`
- [x] 2.2 Implementar `en_kill(e)`: eliminar de la lista, sumar `KILL_POINTS`
      a `gs.game.score` y fijar `en.next_respawn=t()+RESPAWN_TIME`
- [x] 2.3 Implementar `en_update()`: si la lista está vacía y
      `t() >= en.next_respawn`, respawnear en una zona de `ENEMY_ZONES` distinta
      de la anterior (índice circular determinista)

## 3. Colisiones del jugador contra la lista

- [x] 3.1 Actualizar `player.lua` (contacto + bloqueo sólido): iterar `enemies`
      con `all()` en vez del singleton `en`; solo aplican las reglas contra
      enemigos vivos (los muertos están fuera de la lista)
- [x] 3.2 Verificar que `en_draw` y el gating de colisiones no dibujan ni
      procesan enemigos no vivos

## 4. Flujo de partida, HUD y arranque

- [x] 4.1 En `states.lua`: `st_init()` añade `gs.game.score=0`; `st_reset()`
      reinicia también `bl_init()`, `en_init()` y `gs.game.score=0`;
      `st_update_play()` llama a `bl_update()` y dispara con `btnp(5)` vía
      `bl_fire(pl.x,pl.y,pl.turret_a)`
- [x] 4.2 En `ui.lua`: `ui_draw_play()` dibuja `bl_draw()` y el HUD muestra
      `puntos: <score>`; `ui_draw_gameover()` muestra el marcador final
- [x] 4.3 Añadir `#include src/bullet.lua` y `bl_init()` en el arranque de
      `battle_tank.p8`

## 5. Verificación en PICO-8

- [x] 5.1 Ejecutar el cartucho en `pico8` desde la raíz y comprobar el caso
      normal: disparar y matar al enemigo
- [x] 5.2 Comprobar bordes: bala fuera de arena, timeout, cooldown, respawn en
      otra zona, enemigo muerto no bloquea ni daña
- [x] 5.3 Comprobar reinicio: introducir una bala en vuelo, pasar a game over y
      reintentar; no quedan balas ni marcador previo
- [x] 5.4 Comprobar presupuestos: tokens con `info` (< 8192) y CPU con stat(1) /
      CTRL-P (mínima)