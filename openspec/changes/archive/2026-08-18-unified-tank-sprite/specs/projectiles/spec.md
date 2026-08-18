## MODIFIED Requirements

### Requirement: Disparar balas con X
En el estado partida, pulsar X (btnp(5)) SHALL disparar una bala que nace
en la punta del canon integrado y avanza en la direccion de `body_a` directo.
La posicion de nacimiento SHALL usar la tabla `MUZZLE[body_a]` con offsets
precalculados. La cadencia SHALL estar limitada por un cooldown.

**Tabla MUZZLE (offsets desde el centro del tanque):**
```lua
MUZZLE={[0]={3,0},[0.25]={0,-3.5},[0.5]={-3,0},[0.75]={0,3.5}}
```

#### Scenario: Disparo en cualquier direccion
- **WHEN** el jugador pulsa X
- **THEN** aparece una bala en la posicion `MUZZLE[body_a]` relativa al
  centro del tanque
- **THEN** la bala avanza en la direccion `body_a`

#### Scenario: Cooldown entre disparos
- **WHEN** el jugador pulsa X dos veces en un intervalo menor al cooldown
- **THEN** solo se spawnea una bala

#### Scenario: Posicion de nacimiento alineada con sprite
- **WHEN** se spawnea una bala
- **THEN** la posicion de nacimiento coincide con la punta visible del canon
  integrado (usando tabla `MUZZLE`)

### Requirement: La bala avanza y desaparece al salir de la arena o por tiempo
Toda bala SHALL moverse a velocidad constante por frame en su direccion de
disparo. La bala SHALL desaparecer cuando sale de los limites de la arena
(128x128) o cuando supera su vida maxima.

#### Scenario: Bala fuera de arena
- **WHEN** una bala sale de los limites de la arena
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala por tiempo de vida
- **WHEN** una bala supera su tiempo de vida maximo
- **THEN** la bala desaparece de la lista de balas

### Requirement: La bala mata al enemigo al colisionar
Una bala SHALL colisionar con el enemigo vivo cuando su caja AABB se solapa
con la del enemigo. Al colisionar, la bala SHALL desaparecer, el enemigo
SHALL morir y el marcador SHALL incrementarse en `KILL_POINTS`.

#### Scenario: Tiro al enemigo
- **WHEN** una bala en movimiento solapa el area del enemigo vivo
- **THEN** la bala desaparece, el enemigo muere y el marcador suma `KILL_POINTS`

#### Scenario: Bala sin impacto
- **WHEN** una bala cruza la arena sin solapar a ningun enemigo vivo
- **THEN** la bala desaparece por limite de arena o tiempo de vida
