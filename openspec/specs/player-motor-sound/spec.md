### Requirement: Motor continuo acoplado a la velocidad
El motor del tanque SHALL sonar de forma continua mientras el tanque se mueve,
y su tono SHALL derivarse de la velocidad real del tanque
(`pl.speed`) en cada frame del juego. El sonido SHALL usar un unico slot SFX
(slot 3) y un unico canal (`CH_MOTOR`, canal 3) del bus de 4 canales
(pico8.constraint.audio-channels), sin colisionar con los efectos de disparo,
impacto o explosion. Mover un regular unico slot SFX reiniciandolo a una nota
de inicio (offset 0..31) segun velocidad (pico8.api.sfx.claim.1), porque
PICO-8 no permite variar el tono de un sonido en reproduccion.

#### Scenario: Motor en reposo
- **WHEN** `pl.speed` es 0
- **THEN** el motor no suena (canal `CH_MOTOR` libre)

#### Scenario: Motor en movimiento
- **WHEN** `pl.speed` supera el umbral de arranque (`ENGINE_FLOOR`)
- **THEN** el slot SFX 3 se reproduce en bucle en `CH_MOTOR`

#### Scenario: Arranque por flanco bajo
- **WHEN** `pl.speed` pasa de 0 a un valor por encima de `ENGINE_FLOOR`
- **THEN** el motor arranca una unica vez en ese cruce de umbral

#### Scenario: Parada por debajo del umbral
- **WHEN** `pl.speed` cae por debajo de `ENGINE_FLOOR`
- **THEN** el canal `CH_MOTOR` se detiene (`sfx(-1, CH_MOTOR)`)

### Requirement: Tono del motor segun velocidad
El tono del motor SHALL subir cuando el tanque acelera y bajar cuando frena,
en escalones discretos dentro de un barrido de 8..16 notas (semitonos). El
tono SHALL mapearse a un `offset` de nota de inicio del bucle mediante
`engine_offset = f(pl.speed)`, cuantizado para evitar re-arranques crepitados
por frame. Un mayor `pl.speed` SHALL corresponder a un `offset` mayor.

#### Scenario: Acelerando el tono sube
- **WHEN** el jugador mantiene una flecha presionada y `pl.speed` aumenta
- **THEN** el motor re-arranca en un `offset` mas alto que el anterior

#### Scenario: Bajo umbral de arranque el tono es el minimo
- **WHEN** `pl.speed` es ligeramente superior a `ENGINE_FLOOR`
- **THEN** el motor suena en el extremo grave del barrido

#### Scenario: Velocidad maxima el tono es el mas alto
- **WHEN** `pl.speed` alcanza `SPEED_MAX`
- **THEN** el motor suena en el extremo agudo del barrido (sin superar el rango de 8..16 notas)

#### Scenario: Velocidad constante el tono no cambia
- **WHEN** `pl.speed` se mantiene estable
- **THEN** el `offset` de nota se mantiene estable y no hay re-arranques espurios

### Requirement: Desaceleracion fisica-acoplada
Al soltar la tecla de movimiento, el motor SHALL reducir el tono siguiendo el
mismo decaimiento de `pl.speed` por friccion (`SPEED_FRICTION`) que sufre el
tanque: el sonido SHALL "spool down" junto con el deslizamiento visible, sin
timers independientes ni secuencias pre-grabadas.
El motor SHALL dejar de sonar cuando `pl.speed` cae por debajo del umbral
`ENGINE_FLOOR`.

#### Scenario: Soltar la tecla en movimiento
- **WHEN** el jugador suelta la flecha de movimiento con `pl.speed > ENGINE_FLOOR`
- **THEN** el tono desciende en cada frame de friccion, en sincronia con `pl.speed`

#### Scenario: Deriva final
- **WHEN** `pl.speed` decrece por friccion pero aun es positiva
- **THEN** el motor sigue sonando grave hasta el corte por umbral

#### Scenario: Silencio al detenerse
- **WHEN** `pl.speed` alcanza `ENGINE_FLOOR` durante la friccion
- **THEN** el canal `CH_MOTOR` se detiene y no vuelve a sonar sin nueva entrada

### Requirement: Silencio del motor en reinicio y game over
El motor SHALL estar silenciado al inicio de cada partida y al pasar al estado
de game over, garantizando que ningun bucle del motor siga sonando cuando el
jugador ya no controla el tanque (pico8.api.sfx.claim.6 para liberar el canal).

#### Scenario: Reinicio de partida
- **WHEN** se inicia (o reinicia) una partida con `st_reset()`
- **THEN** el canal `CH_MOTOR` esta libre y no emite sonido

#### Scenario: Transicion a game over
- **WHEN** `pl.lifes` llega a 0 y el juego pasa a `GS_GAMEOVER`
- **THEN** el canal `CH_MOTOR` se detiene en la transicion, incluso si el motor estaba sonando

#### Scenario: De game over a nueva partida
- **WHEN** desde game over se reinicia a una nueva partida
- **THEN** el motor arranca desde el estado de reposo (no hereda tono de la partida anterior)