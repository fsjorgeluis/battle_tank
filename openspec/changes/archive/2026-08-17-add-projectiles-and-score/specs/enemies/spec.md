## MODIFIED Requirements

### Requirement: Enemigo estático
Al iniciar una partida SHALL aparecer al menos un enemigo en una posición
definida de la arena, con un sprite propio que lo distinga visualmente del
jugador. Los enemigos vivos SHALL permanecer inmóviles mientras están en la
arena: no se mueven, no cambian de orientación ni de animación.

#### Scenario: Presente al inicio
- **WHEN** una partida comienza
- **THEN** se dibuja un enemigo vivo en su posición inicial con su sprite
  característico

#### Scenario: Permanece inmóvil
- **WHEN** el jugador se desplaza por la arena sin tocarlo ni dispararle
- **THEN** el enemigo conserva su posición y su aspecto sin cambios

### Requirement: El enemigo puede ser eliminado por una bala
El enemigo SHALL dejar de estar vivo cuando una bala del jugador colisiona con
él (ver capability `projectiles`). Un enemigo eliminado SHALL NO seguir
bloqueando el paso del jugador ni causar daño por contacto (ver capability
`player-health`); SHALL NO dibujarse en la arena.

#### Scenario: Bala elimina al enemigo
- **WHEN** una bala solapa a un enemigo vivo
- **THEN** el enemigo deja de estar vivo y desaparece de la arena
- **THEN** el marcador se incrementa (ver capability `score`)

#### Scenario: Enemigo muerto no bloquea ni daña
- **WHEN** el jugador pasa por la posición que ocupaba un enemigo eliminado
- **THEN** el jugador no recibe daño por contacto y no queda bloqueado en esa
  posición

### Requirement: Contacto causa daño
Un enemigo vivo SHALL causar daño al jugador si los cuerpos de ambos colisionan
(colisión de cajas de contacto). El enemigo SHALL NO ser empujado por el
jugador y el jugador SHALL NO atravesarlo: la colisión es sólida en ambos
sentidos.

#### Scenario: Colisión jugador-enemigo vivo
- **WHEN** el cuerpo del tanque del jugador solapa el área de un enemigo vivo
  mientras el jugador es vulnerable
- **THEN** el jugador pierde una vida (ver player-health) y el enemigo permanece
  en su lugar

#### Scenario: Empuje impedido
- **WHEN** el jugador presiona lateralmente contra un enemigo vivo
- **THEN** el enemigo no se desplaza

#### Scenario: Bloqueo de paso
- **WHEN** el jugador intenta avanzar a través de la posición de un enemigo vivo
- **THEN** el tanque no lo atraviesa y queda detenido contra él
- **THEN** el jugador puede rodearlo girando y avanzando por otro lado

## ADDED Requirements

### Requirement: El enemigo reaparece en otra zona tras morir
Cuando no queda ningún enemigo vivo, el juego SHALL reaparecer un enemigo en una
posición definida de la arena distinta de la que ocupaba el enemigo eliminado,
después de un retardo de respawn. El enemigo reaparecido SHALL estar vivo y
sujeto a las reglas de contacto y eliminación anteriores.

#### Scenario: Reaparición tras eliminación
- **WHEN** el último enemigo vivo es eliminado y transcurre el retardo de respawn
- **THEN** aparece un enemigo vivo en una posición de respawn distinta de la
  anterior

#### Scenario: Sin reaparición inmediata
- **WHEN** un enemigo es eliminado y aún no ha transcurrido el retardo de respawn
- **THEN** no aparece ningún enemigo nuevo en la arena

#### Scenario: El reaparecido es un enemigo normal
- **WHEN** un enemigo reaparece en la arena
- **THEN** puede ser eliminado por una bala y causa daño y bloqueo por contacto
  como el resto de enemigos

### Requirement: Los enemigos se gestionan como una lista
El estado de los enemigos de una partida SHALL mantenerse como una lista de
enemigos, donde cada elemento modela su posición y su estado (vivo o no).
Cualquier regla de contacto, bloqueo o eliminación SHALL considerar todos los
elementos de la lista, no una única entidad.

#### Scenario: Varios enemigos coexisten
- **WHEN** la partida contiene más de un enemigo vivo
- **THEN** todos se dibujan y cada uno bloquea, daña y puede ser eliminado por
  separado