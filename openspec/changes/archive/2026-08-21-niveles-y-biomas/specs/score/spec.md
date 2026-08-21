## MODIFIED Requirements

### Requirement: Marcador reiniciado en cada partida
Al empezar una partida nueva (desde el menú o al reintentar desde game over), el marcador SHALL reiniciarse a 0 y no arrastrar puntuación de partidas anteriores. Al completar un nivel y pasar al siguiente, el marcador SHALL conservarse.

#### Scenario: Reintento limpia marcador
- **WHEN** desde game over se pulsa X para reintentar
- **THEN** la nueva partida comienza con el marcador en 0

#### Scenario: Marcador conservado entre niveles
- **WHEN** el jugador completa un nivel con un marcador mayor a 0
- **THEN** el siguiente nivel comienza con el mismo marcador

#### Scenario: Nueva partida desde menú reinicia marcador
- **WHEN** el jugador inicia una partida desde el menú inicial
- **THEN** el marcador comienza en 0
