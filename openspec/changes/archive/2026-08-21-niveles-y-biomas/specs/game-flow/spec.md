## MODIFIED Requirements

### Requirement: Transición de partida a victoria
La máquina SHALL pasar al estado de nivel completado cuando una bala del jugador destruye la base enemiga o cuando se elimina a todos los enemigos de la oleada actual, excepto en el nivel 8 donde la máquina SHALL pasar al estado de victoria final.

#### Scenario: Victoria por destrucción de base enemiga
- **WHEN** en estado partida una bala impacta la base enemiga en un nivel menor a 8
- **THEN** el estado pasa a nivel completado

#### Scenario: Victoria por oleada eliminada
- **WHEN** en estado partida se elimina al último enemigo de la oleada actual en un nivel menor a 8
- **THEN** el estado pasa a nivel completado

#### Scenario: Reinicio desde victoria
- **WHEN** en estado victoria final se pulsa X (btnp(5))
- **THEN** el estado vuelve a partida
- **THEN** el nivel actual es 1
- **THEN** se regenera el mapa, se reinician vidas, posiciones, balas y marcador

#### Scenario: Victoria final en nivel 8
- **WHEN** en estado partida del nivel 8 se cumple cualquiera de las condiciones de completitud
- **THEN** el estado pasa a victoria final
- **THEN** se muestra una pantalla de victoria indicando que se completó la campaña

### Requirement: Reinicio limpio con balas y marcador
Al empezar una partida (desde el menú o al reintentar desde game over), la partida SHALL reiniciarse por completo: nivel 1, balas vacías, enemigos re-sembrados, marcador a 0, jugador reinicializado y el estado pasa a partida. No SHALL arrastrarse balas ni estado de enemigos de la partida anterior.

#### Scenario: Reintento con partida limpia
- **WHEN** desde game over se pulsa X para reintentar
- **THEN** no queda ninguna bala del round anterior en vuelo
- **THEN** el enemigo reaparece en su posición inicial de la oleada del nivel 1
- **THEN** el marcador vuelve a 0
- **THEN** el jugador recupera vidas, posición y ángulos iniciales
- **THEN** el nivel actual es 1

## ADDED Requirements

### Requirement: Transición de nivel completado al siguiente nivel
Estando en estado nivel completado, el sistema SHALL avanzar automáticamente al siguiente nivel tras un breve intervalo de transición, regenerando el mapa con el bioma correspondiente y reposicionando al jugador.

#### Scenario: Avance automático al siguiente nivel
- **WHEN** el estado está en nivel completado
- **THEN** tras el intervalo de transición el nivel actual se incrementa en 1
- **THEN** el estado vuelve a partida
- **THEN** el mapa se regenera con el bioma del nuevo nivel
- **THEN** el jugador spawnea cerca de la nueva base aliada

#### Scenario: Último nivel completo
- **WHEN** el estado está en nivel completado y el nivel actual era 8
- **THEN** el estado pasa a victoria final
- **THEN** no se genera un nivel 9
