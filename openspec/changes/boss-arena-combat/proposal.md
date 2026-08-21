# Propuesta: Arena y combate contra boss

## Why

Los niveles 4 y 8 del juego actualmente se generan como biomas procedurales normales, sin un evento diferenciador que cierre la progresión de cada bloque de niveles. Agregar una arena de boss con una entidad modular de 32×32 px introduce un pico de tensión jugable, recompensa el manejo posicional y evita que los niveles avancen únicamente como repeticiones de dificultad creciente.

## What Changes

- Reemplazar la generación procedural normal de los niveles 4 y 8 por un **layout fijo de arena de boss** con obstáculos ligeramente asimétricos.
- Introducir una **entidad boss de 32×32 px** compuesta por múltiples componentes editables individualmente en el sprite editor de PICO-8.
- Implementar un **sistema de daño por componentes**: cuerpo invulnerable, orugas vulnerables que afectan movilidad, torretas y cañones que se destruyen individualmente.
- Implementar un **sistema de balas enemigas** con límite de 4–6 proyectiles simultáneos.
- Definir una **máquina de estados de 3 fases** para el boss: móvil, lesionado e inmóvil.
- Implementar **telegrafiado visual** para los disparos de los cañones principales.
- Ajustar `level-progression` para detectar niveles 4 y 8 y cargar la arena especial en lugar de la generación procedural.
- Mostrar un banner de **HUD** distinto al iniciar los niveles 4 y 8: en lugar
  del nombre de bioma (usado en niveles normales), mostrar "NIVEL X - JEFE"
  para reflejar que el nivel usa arena fija en vez de generación procedural.
- No se implementan efectos ambientales, iluminación, ni sprites definitivos en este cambio.

## Capabilities

### New Capabilities

- `boss-entity`: Estructura, renderizado, geometría y estado de los componentes del boss. Incluye el layout de sprites 4×4 editable a mano y las hitboxes por componente.
- `boss-combat`: Lógica de combate del boss: fases, transiciones, daño por componentes, patrones de ataque y telegrafiado de cañones.
- `enemy-projectiles`: Sistema de proyectiles enemigos, incluyendo balas dirigidas y patrones de abanico.
- `boss-arena`: Layout fijo del mapa para niveles 4 y 8, obstáculos asimétricos y condiciones de inicio/fin del combate.

### Modified Capabilities

- `level-progression`: Se modifica para distinguir niveles 4 y 8 como niveles de boss y cargar la arena fija en lugar del generador procedural.
- `game-flow`: Se agrega el estado de combate de boss y la transición de victoria/derrota dentro de la arena.
- - `hud`: Se agrega una variante de banner para niveles de boss ("NIVEL X - JEFE")
  que reemplaza el banner de nombre de bioma en los niveles 4 y 8.

## Impact

- Código: nuevo módulo `boss.lua` (o tab equivalente), módulo `enemy_projectiles.lua`, modificación del generador/selector de niveles.
- Sprites: reserva de un bloque 4×4 (16 sprites) para el boss, más 1–2 sprites para balas enemigas y 1–2 para efectos de destrucción.
- Mapa: dos layouts fijos de arena para niveles 4 y 8.
- Tokens: estimación inicial de 1000–1500 tokens adicionales.
- CPU/frame: update del boss, componentes y balas enemigas; debe mantenerse dentro del presupuesto de ~133k instrucciones/frame a 30fps.
- Audio: se reservarán canales para telegrafiado, disparos de cañón, torretas y explosión de componentes (detalle en `design.md`).
