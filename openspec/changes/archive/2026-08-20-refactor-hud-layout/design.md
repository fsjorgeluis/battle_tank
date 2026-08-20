## Context

Ver `proposal.md` para la motivación. El estado actual dibuja el mapa de 16x16 tiles ocupando toda la pantalla de 128x128 píxeles y luego pinta el HUD sobre las mismas coordenadas, lo que provoca solapamiento con la fila superior de tiles (`pico8.constraint.display-resolution`, `pico8.constraint.sprite-size`).

## Goals / Non-Goals

**Goals:**
- Separar visualmente el HUD del área jugable mediante una franja fija de 16 píxeles en la parte superior.
- Usar `camera()` para desplazar el mundo y resetearla antes del HUD (`pico8.api.camera`).
- Reducir el playfield generado de 16×16 a 16×14 celdas, ajustando bases, spawns y límites derivados.
- Eliminar valores hardcodeados a 128 en los clamps y bounds del mundo, derivándolos de `MAP_W * 8` y `MAP_H * 8`.

**Non-Goals:**
- Introducir scroll de cámara o seguimiento al jugador.
- Modificar terreno, biomas, niveles, boss, algoritmo de laberinto ni reglas de conectividad.
- Cambiar el comportamiento de enemigos, balas o estados de juego más allá del ajuste de límites espaciales.

## Decisions

### 1. Usar `camera(0, -HUD_H)` en lugar de offset manual de cada sprite
**Elegido:** aplicar `camera(0, -HUD_H)` antes de dibujar el mundo y `camera(0, 0)` antes del HUD.

**Rationale:**
- `camera()` desplaza el origen de todas las operaciones de dibujo en `-x, -y` (`pico8.api.camera`).
- Con un offset negativo en Y, el mundo se renderiza 16 píxeles más abajo en pantalla sin modificar las coordenadas lógicas de entidades.
- Evita tocar cada llamada a `spr()`, `circfill()`, `rectfill()` o `map()` de entidades, reduciendo riesgo de regresiones.

**Alternativas consideradas:**
- Offset manual en cada primitiva: más frágil y difícil de mantener si se añade scroll posteriormente.
- Usar `map(0, 0, 0, HUD_H, ...)` sin `camera()`: requeriría desplazar también todas las entidades manualmente.

### 2. Mantener las coordenadas del mundo en 0..127 (X) y 0..111 (Y)
**Elegido:** el mundo sigue usando sus propias coordenadas lógicas; `camera()` solo afecta el render.

**Rationale:**
- La lógica de colisiones, spawns y límites no necesita saber dónde se dibuja en pantalla.
- Con `MAP_H = 14`, la altura lógica del mundo es `14 * 8 = 112` píxeles (0..111), que cabe exactamente en los 112 píxeles restantes debajo del HUD.
- Separa responsabilidades: lógica vs. presentación.

### 3. Reducir el mapa a 16×14 en lugar de recortar visualmente un mapa 16×16
**Elegido:** cambiar `MAP_H` de 16 a 14 y reubicar proporcionalmente la base aliada y el spawn del jugador.

**Rationale:**
- Sin scroll, un mapa 16×16 quedaría parcialmente oculto; recortar 2 filas mantiene todo el playfield visible.
- La base enemiga permanece en la fila 1 (cerca del borde superior visible) y la base aliada pasa a la fila 12, manteniendo la simetría vertical original (2 filas de margen sobre el borde inferior).
- El BFS de conectividad y el spawn del jugador se ajustan a la nueva geometría.

### 4. Derivar `WORLD_W` y `WORLD_H` de las dimensiones del mapa
**Elegido:** definir constantes derivadas en `const.lua` y usarlas en `player.lua` y `bullet.lua`.

**Rationale:**
- Elimina los valores mágicos `127` y `111` dispersos en el código.
- Facilita futuros ajustes de tamaño del playfield.
- `WORLD_W = MAP_W * 8` y `WORLD_H = MAP_H * 8` (o `WORLD_H = MAP_H * 8 - 1` para clamps si se prefiere el límite inclusivo).

## Risks / Trade-offs

- **[Risk]** Algunos comentarios o constantes en el código aún pueden asumir 128 píxeles de alto.
  → **Mitigación:** revisar todos los usos de `127`, `128`, `MAP_H` y `MAP_W` durante la implementación.
- **[Risk]** La reducción a 14 filas acorta la distancia entre bases, lo que puede afectar la dificultad percibida.
  → **Mitigación:** este cambio es puramente de layout; ajustes de balance quedan fuera de alcance y se tratarán en cambios futuros si es necesario.
- **[Risk]** `map_erode_walls()` actualmente itera hasta `MAP_W-3` en el eje Y en lugar de `MAP_H-3`, lo que podría dejar paredes sin erosionar correctamente al cambiar la altura.
  → **Mitigación:** corregir el bug como parte de este cambio, documentándolo en la tarea correspondiente.
- **[Trade-off]** Se pierden 2 filas de mundo, pero se gana una presentación limpia del HUD sin solapamientos.

## Migration Plan

No aplica migración de datos ni despliegue. El cambio es local al cartucho:
1. Actualizar constantes en `const.lua`.
2. Ajustar render en `ui.lua`.
3. Ajustar generación y límites en `map.lua`, `player.lua` y `bullet.lua`.
4. Ejecutar el cartucho y verificar visualmente que el HUD no se solape y que el juego siga jugable.

## Open Questions

Ninguna. Las decisiones de alcance (sin scroll, HUD de 16 px, mapa 16×14, derivación de límites) fueron confirmadas durante la exploración.
