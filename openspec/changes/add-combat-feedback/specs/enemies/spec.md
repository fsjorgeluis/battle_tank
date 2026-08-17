## ADDED Requirements

### Requirement: El enemigo tiene vida y comunica daño por color
Todo enemigo vivo SHALL tener una vida máxima definida (`ENEMY_HP`). Al recibir daño de una bala, su vida SHALL decrecer en 1. Mientras la vida restante sea menor que la máxima, el sprite del enemigo SHALL representarse con un tinte que migra desde su paleta original (gris/blanco) hacia rojo (pico8.api.pal) en función de la vida restante; al recibir daño sin morir, el enemigo SHALL destellar en blanco durante aproximadamente 2 frames. Un enemigo reaparecido SHALL aparecer con la vida completa.

#### Scenario: Enemigo recién aparecido
- **WHEN** un enemigo aparece en la arena (inicio de partida o respawn)
- **THEN** su vida es `ENEMY_HP` y su sprite se dibuja con su paleta original (gris/blanco)

#### Scenario: Tinte intermedio tras impactos parciales
- **WHEN** un enemigo con `ENEMY_HP` mayor que 1 recibe uno o más impactos sin morir
- **THEN** su sprite se dibuja con un tinte que avanza hacia el rojo conforme baja su vida restante (por ejemplo amarillo/naranja y después naranja/rojo)

#### Scenario: Destello al recibir daño
- **WHEN** un enemigo recibe un impacto de bala y sobrevive
- **THEN** el enemigo destella en blanco durante aproximadamente 2 frames

#### Scenario: Reaparición con vida completa
- **WHEN** un enemigo reaparece tras haber muerto
- **THEN** su vida vuelve a ser `ENEMY_HP` y su sprite vuelve a la paleta original

## MODIFIED Requirements

### Requirement: El enemigo puede ser eliminado por una bala
El enemigo SHALL reducir su vida en 1 cuando una bala del jugador colisiona con él (ver capability `projectiles`) y SHALL dejar de estar vivo únicamente cuando su vida llega a 0; en ese momento SHALL dispararse la explosión de muerte (ver capability `combat-feedback`), se incrementa el marcador (ver capability `score`) y se programa el respawn. Un enemigo eliminado SHALL NO seguir bloqueando el paso del jugador ni causar daño por contacto (ver capability `player-health`); SHALL NO dibujarse en la arena.

#### Scenario: Bala reduce vida sin matar
- **WHEN** una bala solapa a un enemigo vivo con vida mayor que 1
- **THEN** el enemigo permanece vivo, se dibuja con el tinte correspondiente a su vida restante y el marcador no cambia

#### Scenario: Bala final elimina al enemigo
- **WHEN** una bala solapa a un enemigo vivo con vida 1
- **THEN** el enemigo deja de estar vivo y desaparece de la arena
- **THEN** se muestra la explosión de muerte y el marcador se incrementa (ver capabilities `combat-feedback` y `score`)

#### Scenario: Enemigo muerto no bloquea ni daña
- **WHEN** el jugador pasa por la posición que ocupaba un enemigo eliminado
- **THEN** el jugador no recibe daño por contacto y no queda bloqueado en esa posición