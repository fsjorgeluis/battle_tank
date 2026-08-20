# tile-physics Specification

## Purpose
Define cómo el tile sobre el que está parado el tanque altera su física de movimiento, incluyendo aceleración, fricción, velocidad máxima y el deslizamiento en hielo, separando la dirección del cañón del vector de velocidad.

## Requirements

### Requirement: El movimiento del tanque se representa como un vector de velocidad independiente de la dirección del cañón
El tanque del jugador SHALL almacenar su velocidad como un vector (`vx`, `vy`) separado de su ángulo de cuerpo (`body_a`). La dirección del cañón y el sprite SHALL seguir determinados por `body_a`, mientras que la posición se actualiza mediante el vector de velocidad (`pico8.api.cos`, `pico8.api.sin`).

#### Scenario: Giro en hielo sin cambiar la trayectoria
- **WHEN** el tanque desliza sobre hielo con velocidad hacia la derecha
- **THEN** el jugador presiona la flecha hacia arriba para apuntar el cañón arriba
- **THEN** el cañón apunta arriba
- **THEN** el tanque sigue deslizando principalmente hacia la derecha durante varios frames

### Requirement: El sistema consulta el tile bajo el centro del tanque para aplicar física
En cada frame, el sistema SHALL determinar el tipo de tile bajo el punto central del tanque (`flr(x/8)`, `flr(y/8)`) y aplicar los multiplicadores de física correspondientes. Si el tile central es especial, ese tipo SHALL gobernar la física de ese frame.

#### Scenario: Tanque mitad sobre arena y mitad sobre tierra
- **WHEN** el centro del tanque está sobre un tile de arena
- **THEN** el tanque se mueve con la física de arena
- **THEN** el borde del tanque sobre tierra firme no anula el efecto de arena

### Requirement: La tierra firme aplica fricción y velocidad máxima normales
Sobre un tile sin flags `SLOW` ni `SLIDE`, el sistema SHALL aplicar la fricción normal (`SPEED_FRICTION`) y la velocidad máxima normal (`SPEED_MAX`). La aceleración SHALL usar `SPEED_ACCEL` sin modificadores.

#### Scenario: Movimiento normal
- **WHEN** el jugador acelera sobre tierra firme
- **THEN** el tanque acelera a `SPEED_ACCEL` por frame
- **THEN** al soltar la tecla, la velocidad decae con `SPEED_FRICTION`
- **THEN** la velocidad nunca supera `SPEED_MAX`

### Requirement: El hielo reduce la fricción y conserva la inercia
Sobre un tile con flag `SLIDE`, el sistema SHALL aplicar una fricción menor que la normal (`SPEED_ICE_FRICTION`) y conservar el vector de velocidad. La velocidad máxima puede permanecer igual a `SPEED_MAX`.

#### Scenario: Deslizamiento prolongado en hielo
- **WHEN** el tanque alcanza velocidad máxima sobre tierra firme y entra a hielo
- **THEN** al soltar la tecla, el tanque sigue deslizando una distancia notablemente mayor que sobre tierra firme
- **THEN** al presionar otra dirección, el vector de velocidad gira gradualmente, no instantáneamente

### Requirement: La arena reduce la velocidad máxima y la aceleración
Sobre un tile con flag `SLOW`, el sistema SHALL reducir la velocidad máxima efectiva (`SPEED_MAX * SPEED_SAND_MAX_MULT`) y la aceleración efectiva (`SPEED_ACCEL * SPEED_SAND_ACCEL_MULT`). La fricción puede permanecer igual a la normal.

#### Scenario: Movimiento lento en arena
- **WHEN** el jugador acelera al máximo sobre arena
- **THEN** el tanque alcanza una velocidad máxima menor que `SPEED_MAX`
- **THEN** la aceleración por frame es menor que `SPEED_ACCEL`

### Requirement: La colisión con sólidos detiene el deslizamiento
Cuando el tanque colisiona con un tile sólido, el sistema SHALL revertir la posición al frame anterior y anular el vector de velocidad (`vx = 0`, `vy = 0`) para evitar que el tanque quede atascado contra la pared mientras desliza.

#### Scenario: Choque contra muro en hielo
- **WHEN** el tanque desliza sobre hielo hacia un muro de metal
- **THEN** al impactar el muro, el tanque no lo atraviesa
- **THEN** el tanque se detiene y deja de deslizar

### Requirement: La física de tiles es reusable para futuros enemigos
Las funciones y constantes que determinan el tipo de tile y sus efectos de física SHALL estar diseñadas para ser llamadas desde el futuro módulo de movimiento de enemigos, sin depender de variables globales del jugador.

#### Scenario: Consulta desde enemigo futuro
- **WHEN** un futuro sistema de IA de enemigo consulta `map_get_ground_type(tx, ty)`
- **THEN** recibe el mismo tipo de ground que usaría el jugador en esa posición
- **THEN** puede aplicar los mismos multiplicadores de velocidad y fricción
