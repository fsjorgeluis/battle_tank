## 1. Preparación del módulo

- [x] 1.1 Crear `src/track.lua` con la tabla de estado `tracks` y constantes (`TRACK_COLOR`, `TRACK_LIFE`, `TRACK_SPEED_THRESHOLD`, `TRACK_TREAD_OFFSET`, `TRACK_TREAD_OFFSET_IN`).
- [x] 1.2 Añadir `#INCLUDE "src/track.lua"` en el tab principal o archivo de inclusión del juego (`pico8.concept.include-directive`).
- [x] 1.3 Implementar `tr_init()` para vaciar la tabla de rastros al iniciar/reiniciar partida.

## 2. Emisión de puntos de oruga

- [x] 2.1 Implementar `tr_emit(x, y, dir, speed)` que genere dos puntos desplazados perpendicularmente a la dirección cuando `speed >= TRACK_SPEED_THRESHOLD`.
- [x] 2.2 Asegurar que las direcciones de 90° usan desplazamientos en `x` o `y` puros, sin funciones trigonométricas.
- [x] 2.3 Llamar a `tr_emit()` desde `pl_update()` (jugador) pasando `pl.x`, `pl.y`, `pl.dir`, `pl.speed`.
- [x] 2.4 Llamar a `tr_emit()` desde `en_update()` para cada enemigo que tenga velocidad, pasando `en.x`, `en.y`, `en.dir`, `en.speed`.

## 3. Envejecimiento y poda

- [x] 3.1 Implementar `tr_update()` que recorra la tabla de puntos y reduzca `life` en cada frame.
- [x] 3.2 Eliminar puntos con `life <= 0` usando `deli()` (`pico8.api.deli`) para evitar agujeros en la tabla.
- [x] 3.3 Invocar `tr_update()` desde `st_update_play()` después de actualizar entidades.

## 4. Dibujo en capa de suelo

- [x] 4.1 Implementar `tr_draw()` que recorra los puntos y los dibuje con `pset()` (`pico8.api.pset`) si `rnd(1) < life/max_life` (`pico8.api.rnd`).
- [x] 4.2 Invocar `tr_draw()` desde `ui_draw_play()` inmediatamente después de `cls()` y antes de `en_draw()`.

## 5. Verificación y ajuste

- [x] 5.1 Ejecutar el cartucho en PICO-8 y comprobar que el jugador deja dos líneas paralelas al moverse.
- [x] 5.2 Verificar que al soltar la flecha el rastro continúa mientras dura la inercia y luego cesa.
- [x] 5.3 Verificar que los puntos desaparecen gradualmente sin saturar la pantalla.
- [x] 5.4 Comprobar que el rastro se dibuja por debajo del tanque, enemigos y balas.
- [x] 5.5 Ejecutar `info` en PICO-8 y confirmar que el incremento de tokens está dentro del presupuesto (~60–90 tokens) (`pico8.api.info`, `pico8.constraint.token-limit`). **Tokens: 2374 / 8192.**
- [x] 5.6 Medir carga de CPU con `stat(1)` o CTRL-P y confirmar que no hay caídas de frame (`pico8.constraint.cpu-throughput`). **CTRL-P: 30/30 estable, ~0.02 (2% de frame), picos de 0.01 en explosiones.**
