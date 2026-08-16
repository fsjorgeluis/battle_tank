## Purpose

Define la entidad enemiga de esta iteración: un objeto estático que se coloca en la arena al iniciar la partida y causa daño por contacto al jugador.

## ADDED Requirements

### Requirement: Enemigo estático
Al iniciar una partida SHALL aparecer un enemigo en una posición definida de la arena, con un sprite propio que lo distinga visualmente del jugador. El enemigo SHALL permanecer inmóvil durante toda la partida: no se mueve, no cambia de orientación ni de animación.

#### Scenario: Presente al inicio
- **WHEN** una partida comienza
- **THEN** se dibuja un enemigo estático en su posición definida con su sprite característico

#### Scenario: Permanece inmóvil
- **WHEN** el jugador se desplaza por la arena sin tocarlo
- **THEN** el enemigo conserva su posición y su aspecto sin cambios

### Requirement: Contacto causa daño
El enemigo SHALL causar daño al jugador si los cuerpos de ambos colisionan (colisión de cajas de contacto). El enemigo SHALL NO ser empujado por el jugador y el jugador SHALL NO atravesarlo: la colisión es sólida en ambos sentidos.

#### Scenario: Colisión jugador-enemigo
- **WHEN** el cuerpo del tanque del jugador solapa el área del enemigo mientras el jugador es vulnerable
- **THEN** el jugador pierde una vida (ver player-health) y el enemigo permanece en su lugar

#### Scenario: Empuje impedido
- **WHEN** el jugador presiona lateralmente contra el enemigo
- **THEN** el enemigo no se desplaza

#### Scenario: Bloqueo de paso
- **WHEN** el jugador intenta avanzar a través de la posición del enemigo
- **THEN** el tanque no lo atraviesa y queda detenido contra él
- **THEN** el jugador puede rodearlo girando y avanzando por otro lado