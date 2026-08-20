## MODIFIED Requirements

### Requirement: La bala avanza y desaparece al salir de la arena, por tiempo o al impactar un tile sólido
Toda bala SHALL moverse a velocidad constante por frame en su direccion de disparo. La bala SHALL desaparecer cuando sale de los limites de la arena, cuando supera su vida maxima o cuando impacta un tile cuya entrada en `BULLET_TILE_ACT` sea distinta de `BULLET_PASS`. Los tiles de agua y bosque tienen acción `BULLET_PASS`, por lo que las balas los atraviesan.

#### Scenario: Bala fuera de arena
- **WHEN** una bala sale de los limites de la arena
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala por tiempo de vida
- **WHEN** una bala supera su tiempo de vida maximo
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala impacta muro
- **WHEN** una bala impacta un tile cuya acción es `BULLET_DESTROY` o `BULLET_BOUNCE` (ladrillo, metal o base)
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala cruza agua
- **WHEN** una bala cruza un tile de agua
- **THEN** la bala no desaparece
- **THEN** la bala no altera el tile de agua

### Requirement: La bala interactúa con tiles del mapa
Una bala SHALL detectar el tile que ocupa su centro en cada frame y consultar `BULLET_TILE_ACT[mget(tx,ty)]`. Si la acción es `BULLET_DESTROY`, la bala SHALL destruir el tile (convertirlo a tile vacío con `mset`) y desaparecer. Si la acción es `BULLET_BOUNCE`, la bala SHALL desaparecer sin alterar el tile. Si la acción es `BULLET_VICTORY`, la bala SHALL desaparecer y activar el estado de victoria. Si la acción es `BULLET_GAMEOVER`, la bala SHALL desaparecer y activar el estado de game over. Si la acción es `BULLET_PASS`, la bala SHALL continuar sin alterar el tile.

#### Scenario: Bala destruye ladrillo
- **WHEN** una bala impacta un tile de ladrillo (sprite 11)
- **THEN** el tile cambia a vacío
- **THEN** la bala desaparece

#### Scenario: Bala impacta metal
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

#### Scenario: Bala atraviesa bosque
- **WHEN** una bala cruza un tile de bosque
- **THEN** el bosque permanece intacto
- **THEN** la bala continúa su trayectoria

#### Scenario: Bala atraviesa agua
- **WHEN** una bala cruza un tile de agua
- **THEN** el agua permanece intacta
- **THEN** la bala continúa su trayectoria
