## Purpose

Control rotatorio del tanque del jugador: rotar el cuerpo, acelerar y retroceder, apuntar el cañón de forma independiente y mantenerse dentro de la arena.

## Requirements

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

### Requirement: Límites de la arena
El tanque SHALL quedar contenido dentro del área de juego de la pantalla completa (128x128). Al alcanzar un borde, el tanque SHALL detenerse sin salirse del área y solo podrá separarse del borde rotando o invirtiendo la marcha.

#### Scenario: Borde superior
- **WHEN** el tanque avanza hasta tocar el borde superior de la arena
- **THEN** no puede avanzar más allá del borde y queda detenido en él
- **THEN** puede separarse rotando hacia otra dirección o retrocediendo

#### Scenario: Los cuatro bordes
- **WHEN** el tanque intenta salir por cualquiera de los cuatro bordes de la arena
- **THEN** se detiene en el borde correspondiente sin traspasarlo

### Requirement: Apuntado del cañón desacoplado del cuerpo
El tanque SHALL mantener un ángulo de cañón (`turret_a`) separado del ángulo de cuerpo. Manteniendo O (btn(4)) el modo de apuntado SHALL activarse: entonces izquierda/derecha rota SOLO el cañón, mientras cuerpo y posición permanecen fijos. Al soltar O, izquierda/derecha vuelven a rotar el cuerpo y el cañón SHALL seguir el ángulo del cuerpo hasta que se vuelva a usar el modo apuntado.

#### Scenario: Modo apuntado activo
- **WHEN** se mantiene O (btn(4)) y se presiona btn(0)/btn(1)
- **THEN** rota el ángulo del cañón y el cuerpo del tanque no rota ni se desplaza

#### Scenario: Vuelta al control del cuerpo
- **WHEN** se suelta O (btn(4))
- **THEN** btn(0)/btn(1) vuelven a rotar el cuerpo del tanque
- **THEN** el cañón conserva el último ángulo apuntado hasta que el cuerpo rote

#### Scenario: Cañón sigue al cuerpo en modo normal
- **WHEN** sin mantener O, el cuerpo rota con btn(0)/btn(1)
- **THEN** el cañón acompaña al cuerpo (sigue apuntando hacia delante), de modo que el ángulo relativo entre ambos es cero

#### Scenario: Si cuerpo y cañón se desincronizan
- **WHEN** el jugador apunta el cañón a un ángulo distinto del cuerpo y luego rota el cuerpo en modo normal
- **THEN** el cañón se realinea con el cuerpo (el ángulo de cañón SHALL coincidir con el de cuerpo al terminar la rotación del cuerpo)