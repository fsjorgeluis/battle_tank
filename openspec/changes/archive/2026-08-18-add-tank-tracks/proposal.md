## Why

El tanque del jugador se desplaza por el campo de batalla sin dejar huella de su paso, lo que hace que el movimiento se sienta flotante y desconectado del terreno. Agregar un rastro visual dinámico que se desvanezca mejora la lectura de la velocidad y la dirección, y aumenta la ambientación del campo de batalla con un coste muy bajo en tokens y CPU.

## What Changes

- Nuevo módulo `track.lua` dedicado a gestionar, actualizar y dibujar rastros de oruga.
- Cada entidad móvil (jugador y enemigos) podrá emitir dos puntos de oruga paralelos al desplazarse, simulando las cadenas de un tanque real.
- El rastro solo se genera mientras la entidad se mueve (velocidad por encima de un umbral), incluyendo la inercia residual al soltar los controles.
- Los puntos de rastro tienen un tiempo de vida limitado y desaparecen gradualmente mediante un fade difuminado.
- El renderizado se sitúa inmediatamente después de `cls()` (`pico8.api.cls`) y antes del dibujo de entidades, de forma que el rastro queda "bajo" el tanque.
- Cada punto de rastro se dibuja con `pset` (`pico8.api.pset`) usando color gris oscuro.
- No se consumen sprites, mapa ni canales de audio.

## Capabilities

### New Capabilities
- `tank-tracks`: Gestión de rastros de oruga para entidades móviles del juego. Cubre la creación condicionada al movimiento, el envejecimiento de puntos, el fade difuminado y el dibujo en la capa de suelo.

### Modified Capabilities
- (Ninguna: este cambio añade una capa visual pura; no altera los requisitos de movimiento, colisión ni daño de entidades existentes.)

## Impact

- **Código:** nuevo archivo `src/track.lua` incluido vía `#INCLUDE` (`pico8.concept.include-directive`); puntos de enganche en el estado de partida, el update y el draw del juego.
- **APIs usadas:** `cls`, `pset`, `rnd`, `add`, `deli` (verificadas en `knowledge/`).
- **Recursos:**
  - Tokens: ~60–90 tokens adicionales, dentro del límite de 8192 (`pico8.constraint.token-limit`).
  - CPU/frame: baja; iterar unos 60–120 puntos por frame consume una fracción pequeña del presupuesto de ~133k instrucciones a 30fps (`pico8.constraint.cpu-throughput`, `pico8.concept.game-loop`).
  - Memoria: tabla Lua de puntos `{x,y,life}`, despreciable frente a los 2MB de Lua RAM (`pico8.constraint.lua-ram-size`).
  - Sprites/mapas/audio: 0.
  - Paleta: usa el color 5 (gris oscuro) de la paleta fija de 16 colores (`pico8.constraint.palette-color-count`).
