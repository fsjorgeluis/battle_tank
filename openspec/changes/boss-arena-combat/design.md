# Diseño técnico: Arena y combate contra boss

## Context

El juego actual tiene niveles procedurales de 16×14 tiles, jugador/enemigos de 8×8, colisiones AABB y una máquina de estados simple. No existe aún una entidad compuesta, balas enemigas ni fases de combate. Ver `proposal.md` para la motivación de introducir una arena de boss en los niveles 4 y 8.

## Goals / Non-Goals

**Goals:**
- Representar un boss de 32×32 px como una entidad lógica única compuesta por componentes editables en el sprite editor de PICO-8.
- Implementar daño por componentes con tres fases de combate y telegrafiado en cañones.
- Agregar balas enemigas con límite de 6 simultáneas.
- Cargar layouts fijos de arena para niveles 4 y 8.
- Mantener la arquitectura existente sin refactorizar el resto del juego.

**Non-Goals:**
- Efectos ambientales, iluminación o partículas avanzadas.
- Rotación libre del boss.
- IA de pathfinding compleja.
- Sprites definitivos ni SFX finales.
- Cambiar la resolución, paleta o mecánicas base del jugador.

## Decisions

### 1. Boss representado como bloque 4×4 de sprites contiguos

**Elegido:** Reservar un bloque fijo de 4×4 sprites en la hoja para el boss completo. Cada componente se direcciona por fila/columna dentro del bloque.

**Alternativas consideradas:**
- **Sprites únicos por componente dispersos:** más económico en slots, pero obliga a memorizar offsets arbitrarios y dificulta la edición visual.
- **Matriz de tiles en código:** editable pero sigue requiriendo una tabla de offsets numéricos.

**Razón:** El requisito explícito es que un humano pueda editar el boss en el sprite editor sin offsets arbitrarios. Un bloque 4×4 visible cumple eso y solo consume 16 sprites (`pico8.constraint.sprite-count`).

### 2. Sin rotación libre del boss

**Elegido:** El boss se mueve en 4 direcciones cardinales sin rotar. Las torretas y cañones apuntan según su posición fija en el bloque 4×4.

**Alternativa considerada:** Rotación libre con celdas rotadas. Rechazada porque complica hitboxes, renderizado por celdas y cálculo de ángulos de disparo en PICO-8, aumentando tokens y CPU por frame (`pico8.constraint.token-limit`, `pico8.constraint.cpu-throughput`).

### 3. Daño por componentes sin HP global

**Elegido:** Cada componente tiene HP propia. La victoria requiere destruir orugas, torretas y cañones.

**Alternativa considerada:** HP global + destrucción de componentes como bonus. Rechazada porque reproduce el patrón "esponja de daño" que se quiere evitar.

### 4. Cañones alternados con telegrafiado

**Elegido:** Un solo cañón en ciclo a la vez: 0.6s de línea de mira + disparo + 2s de cooldown.

**Alternativas consideradas:**
- **Independientes:** más impredecible, puede saturar la pantalla y crear patrones injustos.
- **Coordinados simultáneos:** alto impacto visual pero más difícil de esquivar en 128×128.

**Razón:** Alternados da un ritmo claro, mantiene 4–6 balas enemigas dentro del límite y permite telegrafiado consistente.

### 5. Sistema de balas enemigas separado de las balas del jugador

**Elegido:** Tabla independiente `enemy_bullets` con límite de 6 entradas.

**Razón:** Reutilizar la tabla de balas del jugador mezclaría propietarios, velocidades y reglas de colisión, complicando depuración. Una tabla separada es más tokens pero más clara para PICO-8.

### 6. Arena fija en lugar de procedural para niveles 4 y 8

**Elegido:** Layout predefinido con obstáculos ligeramente asimétricos.

**Alternativa considerada:** Generar la arena proceduralmente con restricciones de boss. Rechazada porque un boss fight requiere control preciso de espacio, spawn y obstáculos para evitar exploits.

## Risks / Trade-offs

| Risk | Mitigación |
|---|---|
| **Presupuesto de tokens** | Estimación de 1000–1500 tokens adicionales. Se minimiza rehusando funciones entre componentes y evitando generalizar la entidad boss. |
| **CPU/frame con balas y componentes** | Limitar a 6 balas enemigas. Actualizar solo componentes vivos. Medir con `stat(1)` o CTRL-P (`pico8.concept.game-loop`). |
| **Pantalla saturada en fase 3** | Abanicos de 3 balas por torreta, secuencia alternada. Máximo 6 balas totales. |
| **Hitboxes confusas** | Hitboxes ligeramente más pequeñas que el sprite (6×6). Feedback visual de daño por componente. |
| **Exploit de esquina segura** | Arena asimétrica con obstáculos que no permiten cobertura total. |
| **Kiteo infinito** | Boss móvil con velocidad suficiente para acortar distancias en fase 1. |
| **Sprite sheet limitada** | Bloque 4×4 (16 sprites) + 2 para balas/efectos. Total ~18–24 sprites, dentro de los 128 dedicados (`pico8.constraint.sprite-count`). |

## Estructuras de datos propuestas

```lua
-- constantes de balance
BOSS_SPEED_PHASE1 = 0.8
BOSS_SPEED_PHASE2 = 0.5
CANNON_TELEGRAPH = 18   -- 0.6s a 30fps
CANNON_COOLDOWN = 60    -- 2s a 30fps
TRACK_HP = 8
TURRET_HP = 6
CANNON_HP = 8
MAX_ENEMY_BULLETS = 6
ENEMY_BULLET_SPEED = 1.75

-- boss
boss = {
  x = 48, y = 32,
  phase = 1,          -- 1=móvil, 2=lesionado, 3=inmóvil
  active_cannon = 0,  -- 0=superior, 1=inferior
  parts = {}
}

-- componente ejemplo
-- parts.track_l = {
--   id = "track_l", type = "track",
--   cells = {{3,0}},
--   hb = {x=0, y=24, w=8, h=8},
--   hp = 8, max_hp = 8, alive = true
-- }

-- bala enemiga
-- {x, y, vx, vy, ttl}
```

## Máquina de estados del boss

```
FASE 1 (móvil)
  └── ambas orugas vivas
  └── movimiento hacia jugador
  └── cañones alternados con telegrafiado
  └── torretas disparan dirigido

       ↓ destruir 1 oruga

FASE 2 (lesionado)
  └── 1 oruga viva
  └── velocidad reducida
  └── giro más lento hacia lado dañado
  └── cañones y torretas mantienen presión

       ↓ destruir 2ª oruga

FASE 3 (inmóvil)
  └── 0 orugas vivas
  └── boss no se mueve
  └── torretas activas disparan abanicos
  └── cañones vivos mantienen ciclo alternado
```

## Ciclo de cañón

```
IDLE ──(turno)──▶ TELEGRAPH (18 frames, línea de mira)
                     │
                     ▼
                  FIRE (1 frame, dispara bala dirigida)
                     │
                     ▼
                 COOLDOWN (60 frames)
                     │
                     ▼
                  IDLE (pasa turno al otro cañón)
```

## Presupuestos estimados

| Recurso | Uso estimado | Límite (constraint) |
|---|---|---|
| Sprites dedicados | ~18–24 | 128 (`pico8.constraint.sprite-count`) |
| Tokens adicionales | ~1000–1500 | 8192 (`pico8.constraint.token-limit`) |
| Balas enemigas | ≤6 | memoria y CPU (`pico8.constraint.cpu-throughput`) |
| CPU/frame | medir con `stat(1)` | ~133k instrucciones a 30fps |
| Mapa | 2 layouts fijos | 128×32 tiles (`pico8.constraint.map-size`) |

## Migración plan

No aplica migración de datos (sin persistencia de partida entre sesiones). El cambio consiste en:
1. Reservar sprites y mapa para el boss.
2. Agregar tabs de código para boss, balas enemigas y arena fija.
3. Modificar el selector de nivel para detectar niveles 4 y 8.
4. Validar con ejecución en PICO-8.

## Open Questions

1. ¿Se reservará un canal de audio específico para el telegrafiado del cañón? (Deferible, se define al implementar audio.)
2. ¿El cuerpo central mostrará animación de destrucción final una vez neutralizados todos los componentes, o simplemente desaparece? (Afecta sprites, no arquitectura ni specs.)
3. ¿Los layouts de arena 4 y 8 serán idénticos o tendrán variaciones? (Decisiones de diseño de nivel, no de arquitectura.)
