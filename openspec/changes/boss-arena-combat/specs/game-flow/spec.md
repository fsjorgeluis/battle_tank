# game-flow Delta

## MODIFIED Requirements

### Requirement: Transición de partida a victoria
La máquina SHALL pasar al estado de nivel completado cuando una bala del jugador destruye la base enemiga o cuando se elimina a todos los enemigos de la oleada actual, excepto en el nivel 8 donde la máquina SHALL pasar al estado de victoria final. En los niveles 4 y 8, el estado de nivel completado se alcanza al derrotar al boss.

#### Scenario: Victoria por destrucción de base enemiga
- **WHEN** en estado partida una bala impacta la base enemiga en un nivel menor a 4 o entre 5 y 7
- **THEN** el estado pasa a nivel completado

#### Scenario: Victoria por oleada eliminada
- **WHEN** en estado partida se elimina al último enemigo de la oleada actual en un nivel menor a 4 o entre 5 y 7
- **THEN** el estado pasa a nivel completado

#### Scenario: Victoria final en nivel 8
- **WHEN** en estado partida del nivel 8 se derrota al boss
- **THEN** el estado pasa a victoria final
- **THEN** se muestra una pantalla de victoria indicando que se completó la campaña

#### Scenario: Victoria por derrota del boss en nivel 4
- **WHEN** en estado partida del nivel 4 se derrota al boss
- **THEN** el estado pasa a nivel completado

#### Scenario: Reinicio desde victoria
- **WHEN** en estado victoria final se pulsa X (btnp(5))
- **THEN** el estado vuelve a partida
- **THEN** el nivel actual es 1
- **THEN** se regenera el mapa, se reinician vidas, posiciones, balas y marcador

## ADDED Requirements

### Requirement: Estado de combate de boss
El sistema SHALL mantener un subestado de combate de boss dentro del estado partida cuando el nivel actual sea 4 u 8. En este subestado, el juego actualiza y renderiza al boss, sus componentes y las balas enemigas.

#### Scenario: Entrada a combate de boss
- **WHEN** el nivel actual es 4 u 8 y el estado es partida
- **THEN** el sistema entra en subestado combate de boss
- **THEN** se actualiza la lógica del boss en cada frame

#### Scenario: Salida del combate de boss
- **WHEN** el boss es derrotado o el jugador pierde todas sus vidas
- **THEN** el subestado de combate de boss termina
- **THEN** el sistema pasa a nivel completado o game over según corresponda

### Requirement: El jugador puede perder durante el combate de boss
El sistema SHALL aplicar las mismas reglas de game over del resto del juego durante el combate de boss: si el jugador pierde todas sus vidas, el estado pasa a game over.

#### Scenario: Game over en arena
- **WHEN** en combate de boss el jugador pierde su última vida
- **THEN** el estado pasa a game over
- **THEN** se muestra la pantalla de game over con opción de reintentar
