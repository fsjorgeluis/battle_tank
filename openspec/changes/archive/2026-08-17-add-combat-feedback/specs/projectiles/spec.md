## MODIFIED Requirements

### Requirement: La bala mata al enemigo al colisionar
Una bala SHALL colisionar con el enemigo vivo cuando su caja AABB se solapa con la del enemigo. Al colisionar, la bala SHALL desaparecer y el enemigo SHALL recibir 1 de daño (ver capability `enemies`): reduce su vida en uno y genera la chispa de impacto (ver capability `combat-feedback`). Cuando la vida del enemigo llega a 0, el enemigo SHALL morir (dejar de estar en la lista de enemigos vivos, ver capability `enemies`), se dispara la explosión de muerte (ver capability `combat-feedback`) y el marcador SHALL incrementarse en `KILL_POINTS`.

#### Scenario: Tiro que mata al enemigo
- **WHEN** una bala en movimiento solapa el área de un enemigo vivo cuya vida es 1
- **THEN** la bala desaparece
- **THEN** el enemigo reduce su vida a 0 y deja de estar vivo (ver capability `enemies`)
- **THEN** se muestra la explosión de muerte y el marcador de puntos suma `KILL_POINTS`

#### Scenario: Tiro parcial a enemigo con vida
- **WHEN** una bala en movimiento solapa el área de un enemigo vivo cuya vida es mayor que 1
- **THEN** la bala desaparece
- **THEN** la vida del enemigo se reduce en 1 y el enemigo sigue vivo
- **THEN** se muestra la chispa de impacto y el marcador de puntos no cambia

#### Scenario: Bala sin impacto
- **WHEN** una bala cruza la arena sin solapar a ningún enemigo vivo
- **THEN** ni el marcador cambia ni el enemigo resulta afectado; la bala desaparece por límite de arena o tiempo de vida