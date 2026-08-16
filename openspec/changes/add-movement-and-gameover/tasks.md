## 1. Setup del cartucho y estructura

- [ ] 1.1 Crear el cartucho `battle_tank.p8` con la sección `__lua` conteniendo las directivas `#INCLUDE` de los módulos de `src/` y guardarlo (imprescindible antes de usar rutas relativas, `pico8.concept.include-directive`)
- [ ] 1.2 Crear `src/const.lua` con las constantes semánticas: estados (MENU/PLAY/GAMEOVER), colores, velocidades (`SPEED_MAX`, `SPEED_ACCEL`), tasa de rotación, `BLINK_HZ`, posición inicial del jugador y del enemigo
- [ ] 1.3 Crear `src/util.lua` con las funciones puras `ut_aabb_overlap`, `ut_clamp` y `ut_snap_sector`; validarlas con `assert` en la consola de PICO-8

## 2. Máquina de estados

- [ ] 2.1 Crear `src/states.lua`: tabla global `gs` (state + partida `game`), `st_init`, `st_set_state` y los despachadores `st_update`/`st_draw` por estado
- [ ] 2.2 Implementar `st_reset()` que reconstruye la partida desde cero (posiciones, ángulos, `lifes=3`, `hits=0`, enemigo) para el reinicio limpio de `game-flow`

## 3. Menú inicial

- [ ] 3.1 Dibujar el menú (`ui_draw_menu`) con "Jugar" y "Salir", selección visible y navegación circular con `btnp` (btn(2)/btn(3))
- [ ] 3.2 Confirmar con X (btnp(5)): "Jugar" transiciona a PLAY, "Salir" llama a `stop()` (`pico8.api.stop`)

## 4. Movimiento del tanque

- [ ] 4.1 `pl_init`: posición inicial, `body_a`, `turret_a`, `speed`, `lifes`, `invuln_until`
- [ ] 4.2 `pl_update`: rotación de cuerpo con btn(0)/btn(1); con btn(4) mantenido, la rotación se aplica a `turret_a` y en modo normal `turret_a` sigue a `body_a`; aceleración (btn(2)) y retroceso (btn(3)) con fricción, clamp a `[-SPEED_MAX, SPEED_MAX]`
- [ ] 4.3 Integración de movimiento con `cos(body_a)`/`sin(body_a)` y clamp de posición a la arena 128x128 (`pico8.api.cos/sin`, `pico8.constraint.display-resolution`)
- [ ] 4.4 Colisión sólida con la caja del enemigo: si la nueva posición solapa, revertir a la anterior (el enemigo no es empujado ni atravesado)
- [ ] 4.5 Render del cuerpo por sector de 1/8 con 4 sprites base + volteos (`spr` con flags, `ut_snap_sector`) y cañón con `line()` hacia `turret_a` (procedural, rotación continua)
- [ ] 4.6 Parpadeo por invulnerabilidad: no dibujar el cuerpo en frames alternos mientras `t() < pl.invuln_until`

## 5. Enemigo

- [ ] 5.1 `en_init`/`en_draw`: enemigo estático con su sprite propio en la posición definida por constantes; sin update

## 6. Salud y daño

- [ ] 6.1 Detección de contacto (misma caja que la colisión): si el jugador es vulnerable y solapa al enemigo, `game.hits += 1`, `pl.lifes -= 1`, `pl.invuln_until = t() + 3.0`
- [ ] 6.2 Transición a GAMEOVER cuando `pl.lifes <= 0` (`st_set_state`)

## 7. HUD y game over

- [ ] 7.1 HUD en partida: 3 corazones (sprite de corazón, omitir los perdidos) y contador de toques ("toques: N")
- [ ] 7.2 Pantalla de game over: título, "toques recibidos: <hits>", instrucción "X para reintentar" con btnp(5) → `st_reset()` → PLAY

## 8. Sprites y arte

- [ ] 8.1 Dibujar en la hoja de sprites: 4 sprites base del tanque (N/NE/E/SE), 1 sprite de enemigo y 1 sprite de corazón; verificar posición y mapeo con `fget`/flags

## 9. Verificación y presupuestos

- [ ] 9.1 Ejecutar el cartucho en `pico8` y verificar los criterios de aceptación de las 4 specs: menú (navegar/jugar/salir), movimiento (rotar/acelerar/reversa/girar-andar/toggle cañón/sin entrada), límites de arena, colisión sólida con enemigo, daño+invulnerabilidad de 3s con parpadeo, game over y reintento limpio
- [ ] 9.2 Verificar presupuestos: tokens con `info` (objetivo < 900) y CPU con `stat(1)`/CTRL-P; revisar el checklist `references/openspec-checklist.md` antes de cerrar