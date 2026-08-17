## Context

Ver `proposal.md` para el "why". Sobre la base `add-movement-and-gameover` +
`fix-tank-and-enemy-sprites`: `pl.turret_a` ya es un ángulo independiente del
cuerpo (rotado con btn(4) mantenido, o siguiendo `body_a`), la primitiva
`ut_aabb_overlap` ya existe (`util.lua`), y X (btnp(5)) está libre en el estado
partida. La iteración audio (D8 del primer design) ya reservó canales para
shoot/hit/explosion.

Restricciones de plataforma que condicionan el diseño: 8192 tokens de código
(`pico8.constraint.token-limit`), 128x128 píxeles (`pico8.constraint.display-resolution`),
bucle `_update` a 30fps (`pico8.concept.game-loop`), ángulo normalizado donde
1.0 = vuelta completa con `sin()` invertido para pantalla (`pico8.api.cos`,
`pico8.api.sin`), botones 0..5 (`pico8.constraint.controller-button-count`) y
`btnp` con repetición tras 15 frames cada 4 (`pico8.api.btnp`).

## Goals / Non-Goals

**Goals:**
- Disparar balas desde la boca del cañón en dirección `pl.turret_a` y que
  maten al enemigo.
- Marcador de puntos por baja en HUD y game over.
- El enemigo reaparece en otra zona tras morir: la amenaza no desaparece y se
  siente un bucle jugable (matar → sumar → el enemigo vuelve).
- Estructura de enemigos como lista (`enemies`) para absorber el futuro
  spawner sin refactor.
- Coste mínimo de tokens/CPU: balas procedurales y despawn sin recursos.

**Non-Goals:**
- Sin enemigos móviles ni spawner (iteración futura).
- Sin muros que detengan las balas: la bala solo se elimina por límites de
  arena o timeout.
- Sin SFX de disparo/impacto (iteración de audio, reserva D8).
- Sin estados de victoria: el juego continúa con el enemigo reapareciendo.
- Sin 60fps: se mantiene `_update` a 30fps.

## Decisions

### D1. Módulo nuevo `src/bullet.lua` con lista global `bullets`
Prefijo `bl_`, tabla `bl` y lista `bullets` (add enough / delete con del).
Cada bala: `{x, y, vx, vy, born}`. La lista se itera con `all()`
(`pico8.api.all`) y se elimina con `del()` (`pico8.api.del` por valor, no por
índice). Se añade `#include src/bullet.lua` en `battle_tank.p8` y
`bl_init()` en `_init` para arrancar `bullets={}`.

Consistente con el layout D1 existente (`pico8.concept.include-directive`).

### D2. Entrada de disparo con X y cadencia mínima
En `st_update_play`, `if btnp(5) then bl_fire(pl.x, pl.y, pl.turret_a) end`.
`btnp(5)` dispara en el borde y repite tras 15 frames cada 4
(`pico8.api.btnp`); sin embargo la repetición nativa es demasiado rápida para
el precioso cadenciado del tanque, así que se añade un cooldown de disparo
con `t()` (mismo patrón que `invuln_until` en `player.lua`): `bl.cooldown_until`
se fija a `t()+FIRE_COOLDOWN` al disparar, y `bl_fire` no dispara si
`t() < bl.cooldown_until`.

**Alternativa descartada**: apoyarse solo en la repetición de `btnp(5)`,
rechazada por disparar a ~7 disparos/seg, demasiado para el feel del tanque.

### D3. Bala procedural (0 sprites) y despawn
La bala se dibuja con `rectfill()` (`pico8.api.rectfill`) como un cuadrado
pequeño (BULLET_SIZE ≈ 2) en color amarillo. Spawn en la boca del cañón:
`pl.x+cos(a)*BARREL_LEN`, `pl.y+sin(a)*BARREL_LEN` (boca = extremo del cañón
que ya dibuja `line()` en `pl_draw`). Velocidad constante: `vx=cos(a)*BULLET_SPEED`,
`vy=sin(a)*BULLET_SPEED` (`pico8.api.cos/sin`), con `BULLET_SPEED ≈ 4 px/frame`.
A 4px/frame cruzando un enemigo de 8px, sin swept test necesario: la caja de la
bala (2x2) siempre se solapa al menos 1 frame con la caja del enemigo (8x8).

Despawn por dos condiciones:
- Fuera de la arena: `x<-2 or x>130 or y<-2 or y>130` (margen del tamaño de la
  bala).
- Timeout: `t() - born > BULLET_LIFE` (≈ 2s ⇒ recorre ~120px, cubre cualquier
  tiro cruzado).

Iteración segura con eliminación en vuelo: se recoge la lista nueva en una
variable local y se reasigna, para no romper el iterador de `all()`.

### D4. Colisión bala-enemigo: matar, sumar y reaparecer
Para cada bala, AABB contra cada enemigo vivo de `enemies`
(`ut_aabb_overlap`). En el primer solape (`bl_hit`):
1. Se borra la bala (`del(bullets, b)`).
2. Se marca el enemigo como muerto (`e.alive=false`); se elimina de la lista
   (`del(enemies, e)`). La lectura de AABB y el gating de colisiones del
   jugador usan la lista: un enemigo eliminado deja de bloquear y dañar (ver
   D6).
3. `gs.game.score = gs.game.score + KILL_POINTS`.
4. Se programa el respawn: `en.next_respawn=t()+RESPAWN_TIME` (≈ 2s).

`en_update()` comprueba: si la lista está vacía y `t() >= en.next_respawn`, se
inserta un enemigo nuevo en una zona distinta de la que murió (ver D5).
`KILL_POINTS=100`.

### D5. `enemies` como lista + zonas de respawn
Refactor de `enemy.lua`: la tabla pasa de `en` a `enemies` (lista). Cada
elemento `{x, y, alive}`. Se mantienen las funciones `en_init`, `en_update`,
`en_draw` y se añaden `en_kill(e)` y `en_respawn()`. `en_init()` siembra un
enemigo inicial en `ENEMY_X,ENEMY_Y`.

Zonas de respawn (`ENEMY_ZONES` en `const.lua`) son posiciones fijas repartidas
por la arena (p. ej. 4 puntos alrededor del centro), verificadas para no caer
sobre la posición inicial del jugador. `en_respawn()` elige la zona usando un
índice incremental circular (no aleatorio, para no cargar `rnd()` y ser
determinista): la zona reposicionada no repite la inmediatamente anterior.

**Alternativa descartada**: respawn aleatorio con `rnd()`
(`pico8.api.rnd`). Descartada por preferir comportamiento determinista y
reproducible en pruebas.

### D6. Gating de colisión del jugador por "vivos"
`player.lua` hoy colisiona contra `en` como singleton. Al pasar a lista:
- El cálculo de las cajas enemigas itera `enemies` (`all()`).
- El daño por contacto (hits/lifes) solo aplica si solapa algún enemigo vivo.
- El bloqueo sólido solo revierte la posición si solapa un enemigo vivo.

El gating por `alive` es implícito porque los muertos se eliminan de la lista
al morir (D4); sin embargo se mantiene el campo `alive` para futuro spawner y
para que `en_draw` no dibuje muertos pendientes de `del`. No se toca el
bloqueo/enemigo-no-empujado: el enemigo sigue inmóvil.

### D7. Marcador en `gs.game` y UI
`gs.game` ya vive en `states.lua` con `menu_sel` y `hits`. Se añade
`gs.game.score=0` en `st_init()` y se reinicia en `st_reset()`. El HUD
(`ui_draw_hud`) muestra `puntos: <score>` y `game over` muestra
`puntos: <score>`. `ui_draw_play` dibuja `bl_draw()` tras `pl_draw()` (las
balas por encima del fondo pero bajo el HUD).

### D8. Reinicio limpio (`st_reset`)
`st_reset()` re-inicializa la partida completa: `pl_init()`, `en_init()`,
`bl_init()` y `gs.game.score=0`. Cubre el escenario "Reintento" del game-flow:
no pueden quedar balas del round anterior volando, ni enemigos muertos sin
reaparecer, ni marcador acumulado.

## Risks / Trade-offs

- **[Balas atraviesan enemigos por velocidad alta]** → `BULLET_SPEED=4` con
  enemigo de 8px: la caja de contacto se solapa ≥1 frame siempre, sin
  tunneling. Mitigación documentada y verificable en prueba manual.
- **[Cooldown con t() dependiente de fps]** → a 30fps `FIRE_COOLDOWN*30` frames;
  coherente con `invuln_until` existente (mismo patrón aceptado).
- **[Eliminar mientras se itera]** → la reasignación de la lista local en
  `bl_update` evita saltos/errores de `all()` en P8 Lua.
- **[Comportamiento del respawn si el jugador ocupa la zona]** → zonas fijas
  lejos del spawn del jugador y el respawn es inmediato al contacto; riesgo
  aceptado en esta iteración (enemigo estático inmóvil). El spawner futuro
  revisará overlap.
- **[Multiplicación de colisiones por lista]** → coste O(balas × enemigos),
  acotado y mínimo en esta iteración (`pico8.constraint.cpu-throughput`).

## Presupuestos previstos

| Recurso | Estimado | Limite | Notas |
| --- | --- | --- | --- |
| Tokens | +80..120 | 8192 | módulo balas + entrada + respawn |
| CPU/frame | < 1% extra | ~133k instr. | n balas × n enemigos AABB |
| Sprites | 0 | 128 | bala procedural (`rectfill`) |
| Mapa | 0 | 128x32 tiles | sin muros |
| Canales audio | 0 | 4 | reserva shoot/hit/explosion (D8 previo) |
| RAM | +40 bytes aprox | 64k | lista de balas |
| Cartdata | 0 | 64 numeros | sin persistencia |

## Migration Plan

Cambio sobre código existente, sin despliegue externo. El cartucho se valida
por ejecución en `pico8` contra los criterios de aceptación de cada spec.
Rollback: `git revert` del cambio o volver a la rama previa
(`feat/projectile` sale de la rama anterior sin otras features mezcladas).

## Open Questions

- Número y posición exacta de las zonas de respawn: se eligen valores
  sensatos (4 zonas alrededor del centro) y se ajustan al probar; no altera
  specs ni descompone tareas.
- Valor exacto de `KILL_POINTS` (100) y cadencia (`FIRE_COOLDOWN`): valores de
  balance ajustables sin quiebre de specs.
- Si el respawn debería esperar a que el jugador se aparte del área de la zona:
  se descarta en esta iteración y se anota para el spawner futuro.

## Conocimiento verificado de soporte

- `pico8.api.btnp`, `pico8.api.all`, `pico8.api.del`, `pico8.api.add`,
  `pico8.api.cos`, `pico8.api.sin`, `pico8.api.rectfill`, `pico8.api.time`,
  `pico8.api.rnd` (descartada en D5), `pico8.api.print`,
  `pico8.concept.game-loop`, `pico8.concept.include-directive`,
  `pico8.constraint.token-limit`, `pico8.constraint.display-resolution`,
  `pico8.constraint.cpu-throughput`, `pico8.constraint.audio-channels`,
  `pico8.constraint.controller-button-count`, `pico8.constraint.sprite-count`.