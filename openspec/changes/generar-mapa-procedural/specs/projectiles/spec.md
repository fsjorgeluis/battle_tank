## ADDED Requirements

### Requirement: La bala interactúa con tiles del mapa
Una bala SHALL detectar el tile que ocupa su centro en cada frame. Si el tile tiene el flag 1 (rompible) la bala SHALL destruirlo (convertirlo a tile vacío con `mset`) y desaparecer. Si el tile tiene el flag 0 (sólido) pero no el flag 1 (rompible) la bala SHALL desaparecer sin alterar el tile. Si el tile tiene el flag 2 (base) la bala SHALL desaparecer y notificar al sistema de estado para la condición de victoria o derrota.

#### Scenario: Bala destruye ladrillo
- **WHEN** una bala impacta un tile de ladrillo (sprite 11)
- **THEN** el tile cambia a vacío
- **THEN** la bala desaparece

#### Scenario: Bala rebota en metal
- **WHEN** una bala impacta un tile de metal (sprite 12)
- **THEN** el tile permanece intacto
- **THEN** la bala desaparece

#### Scenario: Bala impacta base enemiga
- **WHEN** una bala del jugador impacta la base enemiga (sprite 14)
- **THEN** la bala desaparece
- **THEN** el sistema activa el estado de victoria

#### Scenario: Bala impacta base aliada
- **WHEN** una bala impacta la base aliada (sprite 13)
- **THEN** la bala desaparece
- **THEN** el sistema activa el estado de game over

## MODIFIED Requirements

### Requirement: La bala avanza y desaparece al salir de la arena, por tiempo o al impactar un tile sólido
Toda bala SHALL moverse a velocidad constante por frame en su direccion de disparo. La bala SHALL desaparecer cuando sale de los limites de la arena (128x128), cuando supera su vida maxima o cuando impacta un tile sólido del mapa.

#### Scenario: Bala fuera de arena
- **WHEN** una bala sale de los limites de la arena
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala por tiempo de vida
- **WHEN** una bala supera su tiempo de vida maximo
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala impacta muro
- **WHEN** una bala impacta un tile sólido (ladrillo, metal o base)
- **THEN** la bala desaparece de la lista de balas
