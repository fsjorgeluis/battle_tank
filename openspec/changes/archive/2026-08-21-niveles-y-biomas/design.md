## Context

El juego ya cuenta con una máquina de estados (`src/states.lua`), generación procedural de laberinto (`src/map.lua`), un enemigo con respawn infinito (`src/enemy.lua`), HUD fijo (`src/ui.lua`) y sistema de terreno con flags (`src/const.lua`, `src/map.lua`). El cambio añade progresión por 8 niveles y biomas sin alterar la física de tiles ni duplicar sprites. Ver motivación en `proposal.md`.

## Goals / Non-Goals

**Goals:**
- Modelar 8 niveles lineales con bioma propio cada uno.
- Revestir el laberinto base con tiles de terreno según el bioma activo preservando conectividad.
- Aplicar una paleta sutil solo al mundo, nunca a entidades ni HUD.
- Gestionar oleadas finitas de enemigos por nivel y detectar cuándo se completa un nivel.
- Conservar vidas y puntaje entre niveles; resetear posición, enemigos, balas, efectos y toques.
- Mostrar nivel en el HUD y nombre del bioma en un banner al inicio de cada nivel.

**Non-Goals:**
- Modificar la geometría del laberinto base (divisiones, erosión, cámaras de base).
- Cambiar colores de jugador, enemigos, balas, explosiones o HUD.
- Introducir boss fights en niveles 4 y 8 (se tratan como biomas normales).
- Añadir efectos ambientales o de iluminación.
- Persistencia entre partidas (cartdata) ni ramificación de niveles.

## Decisions

### 1. Nuevo estado `GS_LEVEL_CLEAR` en la máquina de estados
**Elegido:** Añadir `GS_LEVEL_CLEAR` en `src/states.lua` en lugar de sobrecargar `GS_VICTORY`.
**Razón:** `GS_VICTORY` se mantiene exclusivamente para la victoria final del nivel 8. Tener un estado intermedio permite mostrar el banner, regenerar el mapa y re-seedear enemigos sin mezclar lógica con el game over o la victoria final.
**Alternativa descartada:** Reutilizar `GS_VICTORY` para cada nivel, lo que hubiera requerido banderas adicionales para distinguir nivel intermedio de victoria final.

### 2. Datos de bioma en `src/biome.lua`
**Elegido:** Nuevo módulo `src/biome.lua` con una tabla `BIOMES` de 8 entradas.
**Razón:** Mantiene la definición de biomas separada de la generación de mapa y del render, facilitando ajustes de balance y reemplazo posterior por boss fights. Cada entrada contiene:
- `name`: nombre para el banner.
- `tiles`: pesos de revestimiento para tiles transitables (`empty`, `forest`, `ice`, `sand`) y sólidos (`brick`, `water`).
- `palette`: lista de pares `{src,dst}` para `pal(src,dst)`.
**Alternativa descartada:** Meter todo en `src/const.lua`, que crecería y mezclaría datos de bioma con constantes de motor.

### 3. Revestimiento que preserva conectividad
**Elegido:** Aplicar el revestimiento en una pasada posterior al laberinto base, respetando la clasificación sólido/transitable de cada tile.
**Razón:** Garantiza que el BFS de conectividad (`map_check_connectivity`) siga siendo válido sin regenerar el mapa por bioma. Las reglas son:
- Tiles vacíos del interior se reemplazan por `empty`, `forest`, `ice` o `sand` según pesos del bioma.
- Tiles de ladrillo del interior se reemplazan por `brick` o `water` según pesos del bioma.
- Metal, bases y borde exterior permanecen inalterados.
**Alternativa descartada:** Generar el laberinto desde cero con pesos de bioma, que habría requerido revalidar conectividad por bioma y aumentado el riesgo de bloqueos.

### 4. Paleta aplicada solo al mundo
**Elegido:** Encapsular el render del mundo entre `pal()` del bioma y `pal()` de reset, con una segunda aplicación para la capa overlay.
**Razón:** `pal()` afecta a todos los `spr()`/`map()`/`sspr()` posteriores. Aplicarla solo alrededor del `map()` y del overlay garantiza que entidades y HUD usen la paleta por defecto. El ciclo de `ui_draw_play` queda:
1. `cls()` y `camera(0,-HUD_H)`.
2. Aplicar paleta del bioma.
3. `map()` (capa base).
4. Resetear paleta.
5. Dibujar entidades (rastros, enemigos, efectos, jugador, balas).
6. Aplicar paleta del bioma.
7. `map_draw_overlay()` (bosque u otros tiles `OVERLAY`).
8. Resetear paleta.
9. `camera(0,0)` y HUD.
**Alternativa descartada:** Aplicar `pal()` una sola vez al inicio del frame; hubiera tenido que restaurar antes de entidades y volver a aplicar para overlay de todos modos.

### 5. Oleadas finitas de enemigos
**Elegido:** Sustituir el respawn infinito por una tabla `LEVEL_WAVES` con la cantidad de enemigos por nivel.
**Razón:** La condición de avance requiere saber cuándo no quedan enemigos de la oleada actual. `en_init(level)` spawnea todos los enemigos de la oleada al inicio del nivel; `en_kill` solo los elimina y suma puntos. La detección de oleada vacía se hace en `st_update_play` o en `level_check_clear()`.
**Alternativa descartada:** Mantener respawn infinito y contar kills; habría sido más complejo de balancear y menos claro para el jugador.

### 6. Banner de bioma al inicio de nivel
**Elegido:** Mostrar el banner durante `GS_LEVEL_CLEAR` o como una fase inicial de `GS_PLAY` con un temporizador.
**Razón:** `GS_LEVEL_CLEAR` ya maneja la transición, por lo que mostrar el banner ahí mantiene la lógica de transición en un solo lugar. El banner desaparece tras un tiempo o al pulsar X, momento en que el estado pasa a `GS_PLAY`.
**Alternativa descartada:** Banner como overlay dentro de `GS_PLAY`, que habría requerido lógica adicional de bloqueo de entrada durante los primeros frames.

### 7. Conservar vidas y puntaje, resetear el resto
**Elegido:** `st_next_level()` regenera el mapa y resetea posición, enemigos, balas, efectos, rastros y `gs.game.hits`, pero conserva `pl.lifes` y `gs.game.score`.
**Razón:** Alineado con la decisión del usuario. `st_reset()` sigue reiniciando todo al comenzar una partida nueva o al reintentar desde game over/victoria final.
**Alternativa descartada:** Conservar también los toques recibidos; el usuario decidió resetearlos por nivel.

## Risks / Trade-offs

- **[Risk]** El revestimiento con agua sobre ladrillos mantiene la solidéz, pero si un bioma tiene mucho agua puede hacer el mapa más difícil de navegar visualmente sin afectar la jugabilidad.
  → **Mitigación:** Limitar el peso máximo de `water` por bioma y validar visualmente cada bioma.

- **[Risk]** `pal()` mal aplicado puede teñir accidentalmente el HUD, el jugador o las balas.
  → **Mitigación:** Estructurar `ui_draw_play` con parejas simétricas de `pal()`/reset alrededor de mapa y overlay, y probar con biomas que remapeen colores usados por entidades.

- **[Risk]** El banner al inicio de cada nivel interrumpe el ritmo si es muy largo.
  → **Mitigación:** Duración corta (1.5-2 s) y posibilidad de saltear con X.

- **[Risk]** Añadir 8 biomas consume tokens rápidamente.
  → **Mitigación:** Representar cada bioma como una tabla compacta de pesos y pares de paleta; no duplicar lógica de generación ni sprites. Presupuesto estimado: +500-800 tokens.

- **[Risk]** El BFS de conectividad asume tiles vacíos como transitables. Si un bioma reemplaza vacíos por hielo/arena/bosque, siguen siendo transitables; si algún bioma futuro introdujera un tile transitable de otro sprite, habría que actualizar `map_check_connectivity`.
  → **Mitigación:** Documentar que todo tile sin `FLAG_SOLID` se considera transitable para el BFS.

## Presupuestos previstos

- **Tokens:** incremento de ~500-800 tokens por tablas de biomas, lógica de oleadas, banner y transiciones. Dentro del límite de 8192 (`pico8.constraint.token-limit`).
- **CPU por frame:** bajo. La generación de mapa y revestimiento ocurren fuera del frame (en transición de nivel). `pal()` y `map_draw_overlay` son operaciones baratas.
- **Sprites/mapas:** sin cambios; se reutilizan sprites de terreno existentes.
- **Memoria:** tabla `BIOMES` con 8 entradas y `LEVEL_WAVES` con 8 valores; consumo despreciable frente a los 2 MB de Lua RAM (`pico8.constraint.lua-ram-size`).

## Open Questions

- Ninguna que bloquee el diseño. El nombre exacto de cada bioma y los pesos finales de tiles se ajustarán durante la implementación sin cambiar la arquitectura.
