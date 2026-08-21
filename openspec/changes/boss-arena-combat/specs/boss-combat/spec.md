# boss-combat Specification

## Purpose

Define la lógica de combate del boss: daño por componentes, fases de comportamiento, patrones de ataque y condiciones de victoria, sin depender de un HP global.

## ADDED Requirements

### Requirement: El boss no posee HP global
El sistema SHALL determinar el estado del combate únicamente a partir del estado de los componentes del boss. No SHALL existir un contador de vida global que, al llegar a cero, derrote al boss.

#### Scenario: Destrucción progresiva
- **WHEN** el jugador destruye componentes del boss
- **THEN** cada componente tiene su propia vida y estado
- **THEN** no aparece una barra ni contador de HP global del boss

### Requirement: Las orugas son los puntos vulnerables que determinan la fase de movilidad
El sistema SHALL tener dos orugas, izquierda y derecha. Destruir una oruga SHALL reducir la velocidad y capacidad de giro del boss. Destruir ambas orugas SHALL inmovilizar al boss y activar la fase de combate estático.

#### Scenario: Primera oruga destruida
- **WHEN** una oruga es destruida
- **THEN** el boss pasa a fase lesionada
- **THEN** su velocidad se reduce a la mitad aproximadamente
- **THEN** el giro hacia el lado de la oruga destruida es más lento

#### Scenario: Ambas orugas destruidas
- **WHEN** la segunda oruga es destruida
- **THEN** el boss pasa a fase inmóvil
- **THEN** el boss deja de desplazarse
- **THEN** los patrones de ataque cambian a abanicos por parte de las torretas

### Requirement: Las torretas y cañones se destruyen individualmente
El sistema SHALL permitir destruir cada una de las cuatro torretas y cada uno de los dos cañones de forma independiente. Un componente destruido SHALL dejar de disparar y renderizarse.

#### Scenario: Cañón destruido
- **WHEN** un cañón es destruido
- **THEN** deja de apuntar y disparar
- **THEN** el otro cañón continúa su ciclo alternado si está vivo

#### Scenario: Torreta destruida
- **WHEN** una torreta es destruida
- **THEN** deja de participar en los patrones de ataque
- **THEN** las torretas restantes mantienen su comportamiento

### Requirement: El combate se divide en tres fases
El sistema SHALL mantener una máquina de estados de tres fases para el boss: fase 1 móvil, fase 2 lesionado y fase 3 inmóvil. Cada fase SHALL tener comportamientos de movimiento y ataque distintos.

#### Scenario: Fase 1
- **WHEN** ambas orugas están vivas
- **THEN** el boss está en fase móvil
- **THEN** se desplaza siguiendo al jugador y usa cañones alternados y torretas simples

#### Scenario: Fase 2
- **WHEN** exactamente una oruga está destruida
- **THEN** el boss está en fase lesionada
- **THEN** se mueve más lento y mantiene presión ofensiva

#### Scenario: Fase 3
- **WHEN** ambas orugas están destruidas
- **THEN** el boss está en fase inmóvil
- **THEN** las torretas activas disparan en patrones de abanico

### Requirement: Los dos cañones principales disparan de forma alternada con telegrafiado
El sistema SHALL alternar el disparo entre el cañón superior y el cañón inferior. Antes de cada disparo, el cañón activo SHALL mostrar una línea de mira visible durante 0.6 segundos. Tras el disparo, el cañón SHALL entrar en cooldown de 2 segundos antes de que el otro cañón comience su telegrafiado.

#### Scenario: Ciclo de cañón
- **WHEN** un cañón comienza su ciclo
- **THEN** aparece una línea de mira durante 18 frames (0.6s a 30fps)
- **THEN** al terminar el telegrafiado dispara una bala dirigida al jugador
- **THEN** el cañón entra en cooldown de 60 frames (2s a 30fps)
- **THEN** el otro cañón comienza su ciclo si está vivo

#### Scenario: Cañón destruido durante cooldown
- **WHEN** un cañón está en cooldown o telegrafiando
- **THEN** si es destruido, cancela su ciclo inmediatamente
- **THEN** el otro cañón toma el turno si está vivo

### Requirement: Las torretas en fase 3 disparan patrones de abanico esquivables
El sistema SHALL hacer que las torretas activas disparen ráfagas de 3 balas con un ángulo total de 60 grados. Las torretas SHALL disparar en secuencia alternada para evitar patrones imposibles de esquivar.

#### Scenario: Abanico de torreta
- **WHEN** una torreta activa dispara en fase 3
- **THEN** genera 3 balas separadas 30 grados entre sí
- **THEN** deja un espacio entre las balas por donde el jugador puede pasar

#### Scenario: Secuencia alternada
- **WHEN** dos torretas están activas en fase 3
- **THEN** no disparan exactamente al mismo tiempo
- **THEN** entre una ráfaga y la siguiente existe una ventana de esquive

### Requirement: La condición de victoria es la destrucción de todos los sistemas críticos
El sistema SHALL considerar derrotado al boss cuando ambas orugas, las cuatro torretas y ambos cañones han sido destruidos. El cuerpo central no requiere destrucción.

#### Scenario: Victoria por neutralización
- **WHEN** el jugador destruye ambas orugas, las 4 torretas y los 2 cañones
- **THEN** el boss se considera derrotado
- **THEN** se dispara la transición de nivel completado o victoria final según corresponda

### Requirement: El jugador puede elegir libremente el orden de ataque
El sistema SHALL no imponer un orden obligatorio para destruir componentes. Destruir torretas o cañones reduce la presión ofensiva; destruir orugas desbloquea la fase inmóvil y acerca la victoria.

#### Scenario: Estrategia ofensiva
- **WHEN** el jugador destruye primero todas las torretas y cañones
- **THEN** el boss sigue móvil mientras las orugas estén vivas
- **THEN** el combate continúa hasta destruir las orugas

#### Scenario: Estrategia de movilidad
- **WHEN** el jugador destruye primero ambas orugas
- **THEN** el boss queda inmóvil
- **THEN** el jugador puede atacar torretas y cañones con mayor facilidad
