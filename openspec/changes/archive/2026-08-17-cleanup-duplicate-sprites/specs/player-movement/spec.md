## MODIFIED Requirements

### Requirement: Rotación y desplazamiento del tanque
El tanque del jugador SHALL estar definido por una posición (x, y) y un ángulo de cuerpo. El sprite del tanque SHALL ser de 8x8 píxeles con un cuerpo de 6x6 centrado en el sprite, y su cañón SHALL dibujarse de forma procedural desde el centro. Izquierda (btn(0)) SHALL rotar el cuerpo en sentido antihorario y derecha (btn(1)) en sentido horario. Arriba (btn(2)) SHALL acelerar el tanque en la dirección en que apunta el cuerpo y abajo (btn(3)) SHALL hacerlo retroceder. Sin entradas, el tanque SHALL permanecer inmóvil.

#### Scenario: Rotar el cuerpo
- **WHEN** se mantiene btn(0) (izquierda)
- **THEN** el cuerpo del tanque rota en sentido antihorario de forma continua
- **WHEN** se mantiene btn(1) (derecha)
- **THEN** el cuerpo del tanque rota en sentido horario de forma continua

#### Scenario: Acelerar y retroceder
- **WHEN** se mantiene btn(2) (arriba)
- **THEN** el tanque avanza linealmente en la dirección que apunta su cuerpo
- **WHEN** se mantiene btn(3) (abajo)
- **THEN** el tanque retrocede linealmente sobre el mismo eje del cuerpo

#### Scenario: Girar mientras se avanza
- **WHEN** se mantienen a la vez un botón de rotación (btn(0)/btn(1)) y btn(2)
- **THEN** el tanque rota y avanza simultáneamente describiendo una curva

#### Scenario: Sin entrada
- **WHEN** no se presiona ningún botón de movimiento
- **THEN** el tanque no se desplaza ni rota, conservando posición y ángulo

#### Scenario: Tope mínimo de velocidad
- **WHEN** el jugador alterna rápidamente adelante/atrás
- **THEN** el tanque solo cambia de dirección dentro de un rango estable sin volverse inestable (la velocidad se acerca a cero pero nunca invierte sin órdenes)

#### Scenario: Sprite único para el tanque
- **WHEN** se inspecciona la hoja de sprites del cartucho
- **THEN** el tanque del jugador ocupa un único sprite (índice `SPR_PLAYER`) y no existen copias duplicadas del mismo arte en otros slots