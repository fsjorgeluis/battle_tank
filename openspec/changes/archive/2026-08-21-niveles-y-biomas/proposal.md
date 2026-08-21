## Why

El juego actual regenera el mapa al azar cada partida pero no hay progresión: la victoria se alcanza en un único round y el terreno no transmite variedad visual ni táctica entre partidas. Dividir la partida en 8 niveles con biomas distintos (misma física, distinta piel y paleta) da una estructura de campaña, reutiliza el sistema de terreno ya implementado y prepara el terreno para los boss fights de los niveles 4 y 8 sin duplicar sprites.

## What Changes

- Se introduce una secuencia lineal de **8 niveles**, cada uno asociado a un **bioma**.
- Cada bioma define una **mezcla de tiles** (ladrillo, metal, bosque, hielo, arena, agua) que se aplica como revestimiento sobre el laberinto base generado por `procedural-map`.
- Cada bioma define un **mapeo sutil de paleta** (`pico8.api.pal`) que se aplica solo al mundo (tiles), nunca a entidades ni HUD (`pico8.constraint.palette-color-count`).
- Se redefine la condición de avance de nivel: el jugador **pasa de nivel al eliminar a todos los enemigos de la oleada actual** o, alternativamente, **al destruir la base enemiga** (más rápido pero más arriesgado).
- Al completar un nivel se **regenera el mapa 128×128** para el siguiente bioma, se **resetean posición del jugador, enemigos, balas, efectos y toques recibidos**, y se **conservan vidas y puntaje**.
- El HUD muestra el **número de nivel actual** de forma permanente y un **banner con el nombre del bioma** aparece brevemente al iniciar cada nivel.
- Los niveles 4 y 8 se tratan como biomas normales; el spec de boss fights los reemplazará/extenderá después.
- Efectos ambientales e iluminación quedan fuera del alcance.

## Capabilities

### New Capabilities

- `level-progression`: secuencia de 8 niveles, condiciones de completitud (oleada eliminada o base enemiga destruida), transición entre niveles, persistencia de vidas y puntaje, reset de posición/enemigos/mapa/toques, banner de bioma al inicio.
- `biome-system`: definición de 8 biomas, mapeo de tiles de revestimiento sobre el laberinto base y mapeo sutil de paleta aplicado únicamente al mundo.

### Modified Capabilities

- `game-flow`: la máquina de estados SHALL soportar transiciones de partida a nivel-completado y de nivel-completado al siguiente nivel, sin perder vidas ni puntaje; el estado de victoria final se mantiene para el nivel 8.
- `hud-layout`: el HUD SHALL mostrar el número de nivel actual junto a vidas, toques y puntos.
- `procedural-map`: la generación del mapa SHALL aplicar el revestimiento de tiles definido por el bioma activo tras generar el laberinto base.
- `enemies`: los enemigos SHALL organizarse en oleadas finitas por nivel, con una cantidad configurable por nivel, y SHALL dejar de respawnear infinitamente dentro de un nivel.
- `score`: el marcador SHALL conservarse entre niveles y solo reiniciarse al comenzar una partida nueva desde el menú o game over.

## Impact

- **Código afectado**: máquina de estados del juego, generador de mapa, render de tiles, HUD, inicialización de enemigos y jugador, persistencia de puntaje.
- **APIs de PICO-8 usadas**: `pal()` para remapeo de paleta (`pico8.api.pal`), `map()` y `spr()` para render de tiles (`pico8.api.map`, `pico8.api.spr`), `camera()` para separar mundo y HUD (`pico8.api.camera`).
- **Presupuesto afectado**:
  - **Tokens**: incremento moderado por tablas de biomas, estado de nivel y lógica de transición. Dentro del límite de 8192 tokens (`pico8.constraint.token-limit`).
  - **CPU**: bajo impacto por frame; `pal()` se aplica una vez al inicio de `_draw` del mundo y se restaura antes de entidades/HUD.
  - **Sprites/mapas**: sin cambios; se reutilizan los sprites de terreno existentes.
  - **Memoria**: tablas pequeñas de definición de biomas (8 entradas con mapeos de tile y paleta).
