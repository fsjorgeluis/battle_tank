## MODIFIED Requirements

### Requirement: El mapa se genera proceduralmente al iniciar cada partida
El sistema SHALL generar un mapa nuevo de **16x14 tiles** en `_init` de cada partida usando un algoritmo hibrido: division recursiva para crear un laberinto perfecto con pasillos de 1 tile, seguido de una erosion aleatoria de paredes internas para crear rutas alternativas. El mapa SHALL ocupar un área de 128x112 píxeles, renderizándose debajo de la franja de 16 píxeles reservada para el HUD (`pico8.constraint.display-resolution`, `pico8.constraint.sprite-size`).

#### Scenario: Nueva partida, nuevo mapa
- **WHEN** el jugador inicia una partida desde el menu o reintenta desde game over
- **THEN** el mapa se regenera con una disposicion diferente de paredes y caminos
- **THEN** el mapa generado tiene 16 columnas y 14 filas de tiles

### Requirement: Las bases ocupan posiciones aleatorias y estan completamente selladas por ladrillos
El sistema SHALL elegir una columna aleatoria `BASE_ENEMY_X` en el rango [2, 13] para la base enemiga (fila 1) y una columna aleatoria `BASE_ALLY_X` en el rango [2, 13] para la base aliada (fila 12), seleccionando ambas posiciones antes de generar el laberinto. El sistema SHALL construir una camara de 3x2 tiles alrededor de cada base: la base ocupa el tile central de la fila trasera; los tiles laterales y el muro frontal de la camara SHALL ser ladrillos rompibles (sprite 11). Si una pared lateral cae sobre la columna 1 o 14, el sistema SHALL usar metal irrompible (sprite 12) en esos tiles, extendiendo el borde del mapa. La retaguardia de cada base SHALL quedar protegida por el borde exterior de metal. La unica forma de acceder a una base SHALL ser destruyendo al menos un ladrillo de su camara.

#### Scenario: Posicion de bases
- **WHEN** se genera el mapa
- **THEN** la base enemiga aparece en la fila 1 con una columna entre 2 y 13
- **THEN** la base aliada aparece en la fila 12 con una columna entre 2 y 13
- **THEN** las posiciones son diferentes en partidas distintas

#### Scenario: Camara completamente sellada
- **WHEN** se inspecciona el area alrededor de una base
- **THEN** todos los lados accesibles de la base estan cubiertos por ladrillos rompibles o metal irrompible
- **THEN** no existe ninguna apertura permanente hacia el interior de la camara
- **THEN** el jugador debe destruir al menos un ladrillo para poder disparar a la base

#### Scenario: Proteccion reforzada en extremos
- **WHEN** una base aparece en la columna 2 o 13
- **THEN** la pared lateral que toca el borde del mapa es metal irrompible
- **THEN** la base cuenta con metal en dos lados (retaguardia + lateral)

### Requirement: El borde exterior es metal irrompible
El sistema SHALL reemplazar todos los tiles del anillo exterior (fila 0, fila 13, columna 0, columna 15) por metal (sprite 12). Estos tiles SHALL ser irrompibles.

#### Scenario: Marco indestructible
- **WHEN** una bala impacta contra el borde exterior
- **THEN** el tile no se destruye
- **THEN** la bala desaparece

### Requirement: El mapa se renderiza antes que las entidades
El sistema SHALL llamar `map(0, 0, 0, 0, 16, 14)` al inicio de `_draw` antes de dibujar balas, enemigos y jugador, con la cámara desplazada para que el mapa quede debajo de la franja del HUD (`pico8.api.map`, `pico8.api.camera`).

#### Scenario: Orden de render
- **WHEN** se dibuja un frame de partida
- **THEN** el fondo del mapa aparece detras de todas las entidades
- **THEN** el mapa ocupa solo el area debajo del HUD

### Requirement: El jugador spawnea cerca de la base aliada
El sistema SHALL posicionar al jugador en el centro del tile (`BASE_ALLY_X`, 10), dos tiles por encima de la base aliada, al iniciar la partida.

#### Scenario: Spawn del jugador
- **WHEN** comienza la partida
- **THEN** el tanque del jugador aparece en la columna `BASE_ALLY_X`, dos tiles debajo de la base aliada
- **THEN** el jugador no aparece dentro de la camara sellada de la base aliada
