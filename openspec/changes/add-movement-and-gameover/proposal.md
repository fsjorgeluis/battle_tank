## Why

Es la primera tajada jugable del proyecto: hoy no existe código. Se necesita una
experiencia de juego completa mínima (menú, partida con movimiento, game over)
que sirva de base escalable para el objetivo final "Battle Tank / Battle City".
Un control rotatorio y un estado de salud son la raíz sobre la que crecerán
muros, disparos y enemigos móviles en iteraciones posteriores.

## What Changes

- **Menú inicial** con dos opciones, "Jugar" y "Salir", navegables con
  arriba/abajo y confirmables. "Jugar" arranca la partida; "Salir" detiene el
  cartucho. (El estado `menú` se refinará en la iteración de menú UI/UX.)
- **Movimiento del tanque rotatorio**: izquierda/derecha rotan el cuerpo del
  tanque, arriba acelera hacia adelante, abajo retrocede. Se modela un ángulo
  de cañón (`turret_a`) separado del cuerpo.
- **Toggle de apuntado**: mantener O (btn(4)) hace que izquierda/derecha roten
  el cañón en lugar del cuerpo. Sin balas en esta iteración; el cañón solo
  apunta.
- **Límites de arena**: el tanque no puede salir del área de juego (128x128).
- **Enemigo estático**: un objeto fijo con sprite propio; el contacto con el
  jugador causa daño. No se mueve, no empuja y no hay muros todavía.
- **Salud del jugador**: 3 corazones/vidas visibles en HUD. Cada toque al
  enemigo resta una vida; al recibir daño hay una ventana de invulnerabilidad
  de 3 segundos con el tanque parpadeando.
- **Game over**: al llegar a 0 vidas se muestra la pantalla de game over con la
  indicación de pulsar X para reintentar; al reintentar se re-inicializa la
  partida de forma limpia.

## Capabilities

### New Capabilities

- `game-flow`: máquina de estados del cartucho (menú, partida, game over) con
  transiciones explícitas y reinicio limpio.
- `player-movement`: control rotatorio de tanque (cuerpo + cañón), aceleración
  y límites de arena.
- `player-health`: vidas (3 corazones), daño por contacto e invulnerabilidad
  con parpadeo tras el toque.
- `enemies`: entidad enemiga estática que daña al contacto.

### Modified Capabilities

Ninguna: repositorio greenfield, no existen specs previas.

## Impact

- **Código**: primer cartucho `.p8` del proyecto; arranque, máquina de estados,
  actualización (movimiento/detección de contacto) y render separados por tabs
  con `#INCLUDE` (pico8.concept.include-directive).
- **Tokens**: presupuesto objetivo holgado (< 1200 de 8192) para dejar margen a
  iteraciones futuras.
- **Sprites**: tanque del jugador (variante por dirección o sprite base
  rotado), cañón dibujado como línea, sprite del enemigo y corazones/vidas.
  Aprox. 2-3 sprites; el cañón y las vidas pueden dibujarse por software
  (pico8.constraint.sprite-count).
- **Mapa**: sin uso en esta iteración (sin muros; entra en world building).
- **Audio**: sin SFX/música en esta iteración (se define reserva de canales en
  design cuando se introduzcan).
- **CPU**: holgada; entidades mínimas (n=1 jugador, n=1 enemigo) y detección de
  contacto por AABB (pico8.constraint.cpu-throughput).
- **Entrada**: botones 0..3 (rotar/acelerar/reversa), btn(4) toggle de apuntado
  y btnp(5)/btnp(X) para confirmar y reintentar (pico8.api.btn,
  pico8.api.btnp, pico8.constraint.controller-button-count).

## Conocimiento verificado de soporte

- `pico8.api.cos`, `pico8.api.sin`: ángulo normalizado donde 1.0 = vuelta
  completa; `sin` invertido para pantalla. Base del control rotatorio.
- `pico8.api.btn` / `pico8.api.btnp`: mapeo de botones y pulsación en borde.
- `pico8.concept.game-loop`: bucle `_init`/`_update`/`_draw` a 30fps.
- `pico8.constraint.display-resolution`: arena de 128x128.
- `pico8.api.spr` / `pico8.api.print`: render de sprites y texto de menú/game over.