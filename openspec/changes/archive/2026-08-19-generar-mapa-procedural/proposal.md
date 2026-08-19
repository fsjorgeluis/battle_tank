## Why

Hoy el juego transcurre en un arena vacía de 128×128 píxeles. El jugador y el enemigo se mueven libremente, pero no hay obstáculos, cobertura ni objetivo más allá de disparar al enemigo. Esto hace que cada partida se sienta igual y carece de tensión estratégica. Un mapa procedural con paredes rompibles, muros de metal irrompibles y bases que hay que defender/atacar añade rejugabilidad, decisión táctica y una condición de victoria clara.

## What Changes

- Generar un mapa de 16×16 tiles de forma procedural en cada partida usando división recursiva seguida de erosión de paredes.
- Llenar inicialmente el mapa de ladrillos rompibles (sprite 11), luego generar un laberinto que conecte la base aliada (sprite 13 en tile aleatorio de la fila 14) con la base enemiga (sprite 14 en tile aleatorio de la fila 1).
- Añadir un borde exterior de metal irrompible (sprite 12) y esparcir bloques de metal aleatorios en el interior.
- Dibujar el mapa con `map()` antes de renderizar entidades.
- Hacer que el jugador colisione con tiles sólidos (ladrillo, metal, bases) en lugar de solo con los bordes de pantalla.
- Hacer que las balas destruyan ladrillos al impactar, desaparezcan al impactar metal y detonen las bases.
- Añadir condiciones de victoria/derrota instantáneas: destruir la base enemiga gana la partida; que destruyan la base aliada pierde la partida.
- Posicionar al jugador dos tiles por encima de la base aliada y a los enemigos en posiciones aleatorias del borde superior, fuera de la cámara de la base enemiga.
- Modelar las propiedades de los tiles mediante los flags de sprite de PICO-8 en lugar de índices mágicos en el código.

## Capabilities

### New Capabilities
- `procedural-map`: Generación, renderizado y propiedades del mapa de juego; incluye el algoritmo de excavación, colocación de metal y posicionamiento de bases.

### Modified Capabilities
- `game-flow`: Se amplían las transiciones de partida para incluir victoria al destruir la base enemiga y derrota al destruir la base aliada, además de la derrota por salud actual.
- `projectiles`: Las balas ahora interactúan con tiles del mapa (destruyen ladrillos, desaparecen al impactar metal, detonan bases).
- `player-movement`: El movimiento del jugador ahora respeta tiles sólidos del mapa, no solo los bordes de la pantalla.

## Impact

- Nuevo módulo `map.lua` para generación y consulta del mapa.
- Cambios en `_draw()` para renderizar el mapa antes de las entidades.
- Cambios en `player.lua` para colisionar con tiles sólidos.
- Cambios en `bullet.lua` para destruir ladrillos y detectar impactos con bases.
- Cambios en `states.lua` para las nuevas condiciones de victoria/derrota.
- Cambios en la inicialización de posiciones de jugador y enemigos.
- Uso de `fget()`/`fset()` para flags de sprite y `mget()`/`mset()`/`map()` para manipular el mapa (`pico8.api.fget`, `pico8.api.mget`, `pico8.api.mset`, `pico8.api.map`).
- Presupuesto afectado: tiles de mapa (16×16), sprites 11-14, y CPU en `_init` para la generación (pico8.constraint.map-size, pico8.constraint.sprite-count, pico8.constraint.cpu-throughput).
