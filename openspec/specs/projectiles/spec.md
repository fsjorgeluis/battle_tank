## Purpose

Define el disparo de balas desde el canon del jugador: entrada de disparo,
movimiento de la bala, despawn, colision con el enemigo e interacción con
tiles del mapa, en el estado partida.

## Requirements

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

### Requirement: La bala avanza y desaparece al salir de la arena, por tiempo o al impactar un tile sólido
Toda bala SHALL moverse a velocidad constante por frame en su direccion de
disparo. La bala SHALL desaparecer cuando sale de los limites de la arena
(128x128), cuando supera su vida maxima o cuando impacta un tile sólido del
mapa.

#### Scenario: Bala fuera de arena
- **WHEN** una bala sale de los limites de la arena
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala por tiempo de vida
- **WHEN** una bala supera su tiempo de vida maximo
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Bala impacta muro
- **WHEN** una bala impacta un tile sólido (ladrillo, metal o base)
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

### Requirement: La bala interactúa con tiles del mapa
Una bala SHALL detectar el tile que ocupa su centro en cada frame. Si el
tile tiene el flag 1 (rompible) la bala SHALL destruirlo (convertirlo a tile
vacío con `mset`) y desaparecer. Si el tile tiene el flag 0 (sólido) pero no
el flag 1 (rompible) la bala SHALL desaparecer sin alterar el tile. Si el
tile tiene el flag 2 (base) la bala SHALL desaparecer y notificar al sistema
de estado para la condición de victoria o derrota.

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
