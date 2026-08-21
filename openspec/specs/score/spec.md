## Purpose

Define el marcador de puntos del jugador: se incrementa por cada enemigo
eliminado, se muestra en el HUD durante la partida y en la pantalla de game
over, y se reinicia con cada partida.

## Requirements

### Requirement: Marcador por eliminación
El juego SHALL mantener un marcador acumulativo que se incremente en
`KILL_POINTS` cada vez que una bala elimina a un enemigo (ver capability
`projectiles`). El marcador SHALL empezar en 0 al iniciar cada partida.

#### Scenario: Eliminación suma puntos
- **WHEN** una bala elimina a un enemigo
- **THEN** el marcador se incrementa en `KILL_POINTS`

#### Scenario: Sin puntuación sin eliminación
- **WHEN** el jugador dispara y no elimina a ningún enemigo
- **THEN** el marcador no cambia

### Requirement: Marcador visible durante la partida
Durante la partida, el HUD SHALL mostrar el marcador actual de forma visible en
pantalla.

#### Scenario: HUD muestra puntos
- **WHEN** el jugador está en estado partida y el marcador tiene un valor n
- **THEN** el HUD muestra el texto indicando el marcador n

#### Scenario: Marcador se actualiza en pantalla
- **WHEN** el jugador elimina un enemigo durante la partida
- **THEN** el marcador mostrado en el HUD pasa a n + `KILL_POINTS`

### Requirement: Marcador visible en game over
La pantalla de game over SHALL mostrar el marcador final de la partida
terminada.

#### Scenario: Game over muestra puntos
- **WHEN** la partida termina y el estado pasa a game over
- **THEN** la pantalla de game over muestra el marcador acumulado de la partida

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
