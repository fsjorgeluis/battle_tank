## Why

El HUD actual (vidas, toques y puntos) se dibuja con las mismas coordenadas de pantalla que el mundo, lo que provoca que la fila superior de tiles del mapa (borde de metal) lo tape visualmente. Esto reduce la legibilidad del HUD y rompe la presentación del juego. Es necesario reservar una franja superior fija para el HUD y ajustar el área jugable para que nunca invada esa zona.

## What Changes

- Reservar una franja superior de **16 píxeles** (2 filas de tiles) exclusiva para el HUD.
- Dibujar el mundo con `camera(0, -HUD_H)` y resetear a `camera(0, 0)` justo antes de dibujar el HUD, garantizando que el HUD siempre use coordenadas de pantalla fijas (`pico8.api.camera`, `pico8.constraint.display-resolution`).
- Reducir el área de generación procedural del mapa de **16×16 a 16×14 celdas**, manteniendo el ancho de 16 tiles y recortando 2 filas de altura.
- Reubicar la base aliada y el spawn del jugador dentro del nuevo límite de 14 filas.
- Derivar los límites del mundo (clamps de jugador, bounds de balas) desde `MAP_W * 8` y `MAP_H * 8` en lugar de valores hardcodeados a 128.
- **Fuera de alcance**: sistema de terreno, biomas, niveles, boss, scroll de cámara o comportamiento de seguimiento.

## Capabilities

### New Capabilities
- `hud-layout`: Define la franja fija de 16 px para el HUD, el uso de `camera()` para separar coordenadas de mundo de coordenadas de pantalla, y el orden de render que evita solapamiento.

### Modified Capabilities
- `procedural-map`: El área de generación procedural pasa de 16×16 a 16×14 celdas. Cambian las posiciones de la base aliada, el spawn del jugador y los límites internos del generador, pero no el algoritmo de laberinto ni las reglas de conectividad.

## Impact

- `src/ui.lua`: cambia el ciclo de dibujo de partida para aplicar y resetear la cámara.
- `src/const.lua`: nueva constante `HUD_H` y constantes derivadas del tamaño del mundo.
- `src/map.lua`: `MAP_H` pasa a 14; ajuste de bases, zonas protegidas, límites de erosión y conectividad.
- `src/player.lua`: spawn y clamp vertical derivados de `MAP_H * 8`.
- `src/bullet.lua`: límite vertical de desecho derivado de `MAP_H * 8`.
- `src/enemy.lua`: sin cambios; reutiliza `map_find_empty_top_spawn()`.

## Presupuestos afectados

- **Tokens**: cambios mínimos en 5 archivos (~+15/-15 tokens).
- **Mapa**: 2 filas menos de tiles utilizadas (de 16×16 a 16×14).
- **CPU**: sin impacto significativo; `camera()` es una operación de estado de dibujo.
- **Sprites / audio / entrada**: sin cambios.
