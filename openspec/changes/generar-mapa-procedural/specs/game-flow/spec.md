## ADDED Requirements

### Requirement: Transición de partida a victoria
La máquina SHALL pasar al estado victoria cuando una bala del jugador destruye la base enemiga.

#### Scenario: Victoria por destrucción de base enemiga
- **WHEN** en estado partida una bala impacta la base enemiga
- **THEN** el estado pasa a victoria
- **THEN** se muestra una pantalla de victoria indicando que se destruyó la base enemiga y la instrucción de pulsar X para reintentar

#### Scenario: Reinicio desde victoria
- **WHEN** en estado victoria se pulsa X (btnp(5))
- **THEN** el estado vuelve a partida
- **THEN** se regenera el mapa, se reinician vidas, posiciones, balas y marcador

## MODIFIED Requirements

### Requirement: Transición de partida a game over
La máquina SHALL pasar al estado game over cuando la salud del jugador llega a cero durante la partida o cuando una bala destruye la base aliada, y mostrar la pantalla de game over.

#### Scenario: Salud agotada
- **WHEN** en estado partida el jugador pierde su última vida
- **THEN** el estado pasa a game over
- **THEN** se dibuja la pantalla de game over indicando el número de toques recibidos durante la partida y mostrando la instrucción de pulsar X para reintentar

#### Scenario: Base aliada destruida
- **WHEN** en estado partida una bala impacta la base aliada
- **THEN** el estado pasa a game over inmediatamente
- **THEN** se dibuja la pantalla de game over indicando que la base fue destruida y mostrando la instrucción de pulsar X para reintentar
