# Tareas de implementación: Arena y combate contra boss

## 1. Preparación de assets y estructura

- [ ] 1.1 Reservar bloque de sprites 4×4 contiguos para el boss y ubicaciones para balas enemigas y efectos de destrucción.
- [ ] 1.2 Crear placeholders visuales de los componentes del boss (cuerpo, 4 torretas, 2 cañones, 2 orugas) en el bloque 4×4 del sprite editor.
- [ ] 1.3 Crear placeholders de bala enemiga y efecto de impacto/destrucción de componente.
- [ ] 1.4 Definir dos layouts fijos de arena (nivel 4 y nivel 8) en el mapa de PICO-8, con zona central abierta y obstáculos ligeramente asimétricos.
- [ ] 1.5 Crear tab de código `boss.lua` con constantes de balance y estructura base de la entidad `boss`.

## 2. Entidad boss y renderizado

- [ ] 2.1 Implementar la tabla `boss` con posición, fase, cañón activo y lista de componentes.
- [ ] 2.2 Definir cada componente con `cells`, `hitbox`, `hp`, `alive` y `type` según la cuadrícula 4×4.
- [ ] 2.3 Implementar función `boss_draw()` que recorre componentes vivos y dibuja sus celdas usando `spr()`.
- [ ] 2.4 Implementar versión destruida opcional para orugas (sprite roto) y ocultamiento para torretas/cañones destruidos.
- [ ] 2.5 Verificar visualmente que el boss de 32×32 px se renderiza completo y alineado a la cuadrícula.

## 3. Colisiones y daño por componentes

- [ ] 3.1 Calcular hitboxes mundiales de cada componente vivo a partir de la posición del boss.
- [ ] 3.2 Detectar colisión entre balas del jugador y componentes del boss.
- [ ] 3.3 Aplicar daño al componente impactado y marcarlo como destruido al llegar a cero HP.
- [ ] 3.4 Hacer que el cuerpo central sea invulnerable (no recibe daño).
- [ ] 3.5 Implementar feedback visual breve (flash) al recibir daño un componente.
- [ ] 3.6 Verificar que balas del jugador no atraviesen componentes y que los destruidos dejen de colisionar.

## 4. Movilidad y fases del boss

- [ ] 4.1 Implementar movimiento del boss en 4 direcciones cardinales hacia el jugador en fase 1.
- [ ] 4.2 Implementar transición a fase 2 al destruir la primera oruga, reduciendo velocidad a `BOSS_SPEED_PHASE2`.
- [ ] 4.3 Implementar transición a fase 3 al destruir la segunda oruga, inmovilizando al boss.
- [ ] 4.4 Agregar lógica de giro más lento hacia el lado de la oruga destruida en fase 2.
- [ ] 4.5 Verificar que el boss no atraviesa paredes ni obstáculos de la arena.

## 5. Sistema de balas enemigas

- [ ] 5.1 Crear tabla `enemy_bullets` con límite de 6 entradas y campos `x, y, vx, vy, ttl`.
- [ ] 5.2 Implementar función `enemy_bullet_spawn(x, y, angle, speed)` con reutilización de slots.
- [ ] 5.3 Implementar `enemy_bullet_update()` para mover balas y eliminarlas al expirar TTL o salir del mundo.
- [ ] 5.4 Implementar `enemy_bullet_draw()` para renderizar balas activas.
- [ ] 5.5 Detectar colisión AABB entre balas enemigas y el jugador, aplicando regla de daño de `player-health`.
- [ ] 5.6 Verificar que nunca existen más de 6 balas enemigas simultáneas.

## 6. Cañones principales

- [ ] 6.1 Implementar máquina de estados por cañón: idle → telegraph → fire → cooldown.
- [ ] 6.2 Dibujar línea de mira durante `CANNON_TELEGRAPH` (18 frames) apuntando al jugador.
- [ ] 6.3 Disparar una bala dirigida al jugador al finalizar el telegrafiado.
- [ ] 6.4 Alternar turnos entre cañón superior e inferior, respetando `CANNON_COOLDOWN` (60 frames).
- [ ] 6.5 Cancelar ciclo de un cañón si es destruido durante telegrafiado o cooldown.
- [ ] 6.6 Verificar que el jugador puede esquivar si reacciona durante el telegrafiado.

## 7. Torretas y patrón de abanico

- [ ] 7.1 Implementar disparo simple dirigido al jugador por parte de las torretas en fases 1 y 2.
- [ ] 7.2 Implementar patrón de abanico de 3 balas con 60° de apertura para fase 3.
- [ ] 7.3 Coordinar secuencia alternada entre torretas activas en fase 3 para evitar patrones imposibles.
- [ ] 7.4 Desactivar torretas destruidas en todos los patrones.
- [ ] 7.5 Verificar que siempre existe al menos un hueco por donde el jugador pueda esquivar el abanico.

## 8. Arena fija e integración de nivel

- [ ] 8.1 Modificar `level-progression` para detectar niveles 4 y 8 como niveles de boss.
- [ ] 8.2 Cargar layout de arena fijo en lugar de generar mapa procedural en niveles 4 y 8.
- [ ] 8.3 Posicionar al jugador en la fila inferior de la arena al inicio.
- [ ] 8.4 Posicionar al boss en la zona central superior de la arena.
- [ ] 8.5 Suspender generación de enemigos de oleada y bases enemigas durante niveles de boss.
- [ ] 8.6 Verificar que la arena respeta las mismas reglas de tile sólido que niveles normales.

## 9. Flujo de juego y condiciones de victoria

- [ ] 9.1 Modificar `game-flow` para agregar subestado de combate de boss dentro del estado partida.
- [ ] 9.2 Implementar condición de victoria del boss: ambas orugas + 4 torretas + 2 cañones destruidos.
- [ ] 9.3 Transicionar a `nivel completado` al derrotar al boss en nivel 4.
- [ ] 9.4 Transicionar a `victoria final` al derrotar al boss en nivel 8.
- [ ] 9.5 Aplicar game over si el jugador pierde todas sus vidas durante el combate.
- [ ] 9.6 Verificar que al completar nivel 4 se avanza correctamente al nivel 5.

## 10. Balanceo y verificación final

- [ ] 10.1 Ajustar parámetros de balance (`BOSS_SPEED_PHASE1`, `BOSS_SPEED_PHASE2`, HP de componentes, cadencias).
- [ ] 10.2 Ejecutar cartucho y verificar caso normal: derrotar al boss en nivel 4.
- [ ] 10.3 Verificar caso de borde: destruir componentes en orden diferente (orugas primero, torretas primero).
- [ ] 10.4 Verificar regresión: niveles 1–3 y 5–7 siguen generándose proceduralmente.
- [ ] 10.5 Medir tokens con `info` y confirmar que no se excede el presupuesto.
- [ ] 10.6 Medir CPU/frame con `stat(1)` o CTRL-P y confirmar estabilidad a 30fps.
