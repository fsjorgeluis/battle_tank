## ADDED Requirements

### Requirement: Disparo en estado partida
El estado partida SHALL aceptar la entrada de disparo (X / btnp(5)) para crear
balas (ver capability `projectiles`) mientras el jugador tiene vidas.

#### Scenario: Disparo permitido en partida
- **WHEN** el juego está en estado partida y el jugador pulsa X
- **THEN** se dispara una bala por la mecánica de `projectiles`

#### Scenario: Sin disparo fuera de partida
- **WHEN** el juego no está en estado partida (menú o game over) y se pulsa X
- **THEN** no se dispara ninguna bala

### Requirement: Reinicio limpio con balas y marcador
Al empezar una partida (desde el menú o al reintentar desde game over), la
partida SHALL reiniciarse por completo: balas vacías, enemigos re-sembrados,
marcador a 0, jugador reinicializado y el estado pasa a partida. No SHALL
arrastrarse balas ni estado de enemigos de la partida anterior.

#### Scenario: Reintento con partida limpia
- **WHEN** desde game over se pulsa X para reintentar
- **THEN** no queda ninguna bala del round anterior en vuelo
- **THEN** el enemigo reaparece en su posición inicial
- **THEN** el marcador vuelve a 0
- **THEN** el jugador recupera vidas, posición y ángulos iniciales