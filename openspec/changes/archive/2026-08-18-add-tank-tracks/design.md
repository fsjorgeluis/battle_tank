## Context

El juego ya tiene un bucle de juego PICO-8 (`_init`/`_update`/`draw`) y una separación de responsabilidades por módulos (`pico8.concept.game-loop`, `pico8.concept.include-directive`). El render de la partida limpia la pantalla con `cls()` y luego dibuja entidades, efectos, balas y HUD en capas superpuestas. El tanque del jugador ya dispone de velocidad (`pl.speed`) y dirección en ángulos múltiplos de 90°, lo que permite calcular desplazamientos perpendiculares sin rotaciones arbitrarias. La motivación y el alcance están en `proposal.md`.

## Goals / Non-Goals

**Goals:**
- Añadir un módulo `track.lua` autocontenido que gestione la tabla de rastros.
- Emitir dos puntos de oruga por entidad móvil, perpendiculares a su dirección.
- Generar rastro por velocidad real (con inercia), no solo por botón pulsado.
- Aplicar fade difuminado por probabilidad proporcional a la vida restante.
- Dibujar el rastro en la capa de suelo, justo después de `cls()` (`pico8.api.cls`).
- Dibujar cada punto con `pset` (`pico8.api.pset`) y color gris oscuro.
- Dejar la puerta abierta para que enemigos emitan rastro con la misma API.

**Non-Goals:**
- No modificar la física ni el control del tanque.
- No añadir colisión entre rastro y entidades.
- No persistir rastros entre partidas.
- No usar sprites, mapa, SFX ni canales de audio.

## Decisions

### 1. Tabla Lua de puntos con `{x, y, life, max_life}`
**Rationale:** Es la estructura más simple y barata en PICO-8; `add()` (`pico8.api.add`) y `deli()` (`pico8.api.deli`) permiten insertar y podar en orden. Guardar `max_life` facilita el cálculo de intensidad sin constantes globales adicionales.

**Alternativas consideradas:**
- Array plano de cuatro valores consecutivos: ahorra unos pocos tokens pero dificulta la legibilidad y el mantenimiento.
- Corrutinas: innecesarias para una colección homogénea que se recorre cada frame.

### 2. Spawn por velocidad real (`speed >= TRACK_SPEED_THRESHOLD`)
**Rationale:** El tanque tiene fricción (`speed = speed * friction`) y sigue deslizándose tras soltar el botón. Detectar movimiento real en lugar de `btn()` hace que el rastro sea consistente con la física.

**Alternativas consideradas:**
- Spawn solo cuando `btn()` está activo: más simple pero ignora la inercia, lo que rompe la continuidad visual.

### 3. Dos puntos desplazados perpendicularmente a la dirección
**Rationale:** Un tanque real tiene dos cadenas. Con direcciones de 90°, el desplazamiento perpendicular se reduce a sumar/restar `offset` en `x` o `y`, sin necesidad de `sin`/`cos`.

**Alternativas consideradas:**
- Un solo punto central: menos tokens pero no evoca huellas de oruga.
- Cuatro puntos: demasiado denso para un sprite de 8×8.

### 4. Fade difuminado probabilístico
**Rationale:** PICO-8 no tiene transparencia por canal alfa. Usar `rnd(1) < life/max_life` (`pico8.api.rnd`) genera un desvanecimiento por "puntos perdidos" que es visualmente suave y muy barato en tokens.

**Alternativas consideradas:**
- Cambio de color 5 → 1 → 0: también barato, pero la paleta oscura de PICO-8 ofrece pocos pasos visibles.
- `fillp()` con patrón de trama: consume más tokens y puede interferir con otros usos del patrón de relleno.
- Desaparición binaria: aún más barata, pero el usuario pidió un fade difuminado.

### 5. Módulo separado `track.lua`
**Rationale:** El orden de dibujo del rastro es distinto al de las partículas de explosión/impacto (`fx.lua`), que normalmente se dibujan sobre las entidades. Un módulo propio evita mezclar responsabilidades y facilita que enemigos lo usen.

**Alternativas consideradas:**
- Extender `fx.lua`: obligaría a saber en `fx_draw()` si una partícula va bajo o sobre las entidades, complicando el diseño.

## Risks / Trade-offs

- **[Riesgo]** A 30 fps y velocidad alta, dos puntos por frame pueden generar una línea muy densa.  
  → **Mitigación:** Ajustar el umbral de velocidad y/o la vida de los puntos; si es necesario, añadir un submuestreo por distancia recorrida en una tarea posterior.

- **[Riesgo]** El rastro puede tapar elementos del fondo si se usa `cls()` con un color claro.  
  → **Mitigación:** El juego usa fondo oscuro y el rastro es gris oscuro (color 5), por lo que el contraste es bajo y no oculta el terreno.

- **[Trade-off]** Soportar enemigos desde el principio añade algunos tokens extra pero evita una refactorización posterior.

## Presupuestos previstos

- **Tokens:** ~60–90 tokens para el módulo `track.lua`, constantes, inicialización, update y draw. Dentro del límite de 8192 (`pico8.constraint.token-limit`).
- **CPU/frame:** recorrido de la tabla de puntos (~60–120 elementos en el peor caso) más dos operaciones de `rnd()` por punto. Muy por debajo del presupuesto de ~133k instrucciones por frame a 30fps (`pico8.constraint.cpu-throughput`).
- **Memoria:** tabla Lua de puntos con cuatro campos numéricos; despreciable frente a los 2MB de Lua RAM (`pico8.constraint.lua-ram-size`).
- **Sprites/mapas/audio:** 0.

## Open Questions

- (Ninguna: el usuario ya decidió todos los aspectos visuales y de alcance.)
