## Purpose

Define el disparo de balas desde el cañón del jugador: entrada de disparo,
movimiento de la bala, despawn y colisión con el enemigo, en el estado partida.

## Requirements

### Requirement: Disparar balas con X
En el estado partida, pulsar X (btnp(5)) SHALL disparar una bala que nace en la
boca del cañón y avanza en la dirección en que apunta el cañón en ese momento
(`pl.turret_a`). El disparo SHALL funcionar tanto en modo normal como en modo
apuntado (btn(4) mantenido). La cadencia SHALL estar limitada por un cooldown:
no se dispara una bala nueva hasta pasado el retardo mínimo desde el disparo
anterior.

#### Scenario: Disparo en modo normal
- **WHEN** el jugador está en estado partida y pulsa X (btnp(5)) con el cañón
  alineado con el cuerpo
- **THEN** aparece una bala en la boca del cañón y avanza en la dirección
  `pl.turret_a`

#### Scenario: Disparo en modo apuntado
- **WHEN** el jugador mantiene btn(4), apunta el cañón con izquierda/derecha y
  pulsa X
- **THEN** la bala nace y avanza en la dirección del cañón apuntado,
  independiente del cuerpo

#### Scenario: Cooldown entre disparos
- **WHEN** el jugador pulsa X dos veces en un intervalo menor al cooldown
- **THEN** solo se spawnea una bala; la segunda pulsación no crea bala hasta
  pasado el retardo

### Requirement: La bala avanza y desaparece al salir de la arena o por tiempo
Toda bala SHALL moverse a velocidad constante por frame en su dirección de
disparo. La bala SHALL desaparecer cuando sale de los límites de la arena
(128x128) o cuando supera su vida máxima.

#### Scenario: Bala fuera de arena
- **WHEN** una bala avanza y su posición sale de los límites de la arena
- **THEN** la bala deja de dibujarse y desaparece de la lista de balas

#### Scenario: Bala por tiempo de vida
- **WHEN** una bala no alcanza ningún objetivo y supera su tiempo de vida máximo
- **THEN** la bala desaparece de la lista de balas

#### Scenario: Distintas orientaciones
- **WHEN** se dispara hacia arriba, abajo, izquierda o derecha
- **THEN** la bala se mueve en la dirección correspondiente a `turret_a` y
  desaparece al salir de la arena en ese lado

### Requirement: La bala mata al enemigo al colisionar
Una bala SHALL colisionar con el enemigo vivo cuando su caja AABB se solapa con
la del enemigo. Al colisionar, la bala SHALL desaparecer, el enemigo SHALL
morir (dejar de estar en la lista de enemigos vivos) y el marcador SHALL
incrementarse en `KILL_POINTS`.

#### Scenario: Tiro al enemigo
- **WHEN** una bala en movimiento solapa el área del enemigo vivo
- **THEN** la bala desaparece
- **THEN** el enemigo deja de estar vivo (ver capability `enemies`)
- **THEN** el marcador de puntos suma `KILL_POINTS`

#### Scenario: Bala sin impacto
- **WHEN** una bala cruza la arena sin solapar a ningún enemigo vivo
- **THEN** ni el marcador cambia ni el enemigo resulta afectado; la bala
  desaparece por límite de arena o tiempo de vida