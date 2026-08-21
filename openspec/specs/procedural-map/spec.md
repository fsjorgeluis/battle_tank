## Purpose

Define la generacion procedural del mapa de juego, sus tiles (ladrillo rompible, metal irrompible y bases), el renderizado con `map()` y la consulta de propiedades mediante flags de sprite, garantizando que todos los caminos esten conectados para que ningun tanque quede atrapado.

## Requirements

### Requirement: El mapa se genera proceduralmente al iniciar cada partida
El sistema SHALL generar un mapa nuevo de **16x14 tiles** al iniciar cada partida y al completar cada nivel, usando el bioma activo del nivel siguiente para aplicar el revestimiento de tiles. El mapa SHALL ocupar un área de 128x112 píxeles, renderizándose debajo de la franja de 16 píxeles reservada para el HUD (`pico8.constraint.display-resolution`, `pico8.constraint.sprite-size`).

#### Scenario: Nueva partida, nuevo mapa
- **WHEN** el jugador inicia una partida desde el menu o reintenta desde game over
- **THEN** el mapa se regenera con una disposicion diferente de paredes y caminos
- **THEN** el mapa generado tiene 16 columnas y 14 filas de tiles
- **THEN** el mapa usa el bioma del nivel 1

#### Scenario: Nuevo nivel, nuevo mapa
- **WHEN** el jugador completa un nivel menor a 8
- **THEN** el mapa se regenera para el siguiente nivel
- **THEN** el mapa usa el bioma correspondiente al nuevo nivel

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

### Requirement: El laberinto conecta ambas bases sin corredores rectos
El sistema SHALL garantizar que ambas bases pertenecen a la misma region conectada del laberinto generado por division recursiva. Las camaras de base se marcaran como zonas protegidas antes de la generacion del laberinto, de modo que la division recursiva y la erosion no coloquen paredes dentro de ellas. El sistema NO SHALL tallar un corredor recto entre las bases; la conectividad SHALL surgir del laberinto natural. Opcionalmente, el sistema puede verificar con un BFS ligero que existe un camino desde un tile adyacente a la base aliada hasta un tile adyacente a la base enemiga, y regenerar el mapa si la verificacion falla.

#### Scenario: Camino sin linea de vision directa
- **WHEN** se genera el mapa
- **THEN** no existe un pasillo recto y despejado desde la base aliada hasta la base enemiga
- **THEN** el jugador debe atravesar el laberinto para llegar a la base enemiga

#### Scenario: Conectividad garantizada
- **WHEN** se inspecciona cualquier partida generada
- **THEN** existe al menos un camino a traves del laberinto que permite acercarse a ambas bases

### Requirement: La division recursiva genera un laberinto perfecto
El sistema SHALL llenar el interior del mapa de vacio, dejando solo el borde exterior como ladrillo, y ejecutar un algoritmo de division recursiva. En cada division el sistema SHALL trazar una pared horizontal o vertical a traves de la zona y abrir exactamente una puerta (tile vacio) en dicha pared. El proceso SHALL repetirse recursivamente hasta que las subzonas sean demasiado pequenas. El resultado SHALL ser un laberinto perfecto donde existe exactamente un camino entre cualquier par de puntos.

#### Scenario: Laberinto perfecto
- **WHEN** se inspecciona el mapa generado
- **THEN** las paredes forman un patron de laberinto con pasillos de 1 tile
- **THEN** no hay camaras grandes ni espacios abiertos

### Requirement: La erosion de paredes crea rutas alternativas
Despues de generar el laberinto perfecto, el sistema SHALL recorrer las paredes interiores y eliminar cada una con una probabilidad del 10 %. El sistema SHALL respetar el borde exterior y las zonas de base definidas por `map_is_base_zone(tx,ty)`. El resultado SHALL ser un campo de batalla con esquinas tacticas y algunas rutas alternativas, sin perder la sensacion de laberinto denso.

#### Scenario: Rutas alternativas
- **WHEN** se inspecciona el mapa erosionado
- **THEN** existen ciclos y atajos ademas del camino principal del laberinto
- **THEN** ninguna pared del borde exterior ni de las zonas de base fue eliminada

### Requirement: El borde exterior es metal irrompible
El sistema SHALL reemplazar todos los tiles del anillo exterior (fila 0, fila 13, columna 0, columna 15) por metal (sprite 12). Estos tiles SHALL ser irrompibles.

#### Scenario: Marco indestructible
- **WHEN** una bala impacta contra el borde exterior
- **THEN** el tile no se destruye
- **THEN** la bala desaparece

### Requirement: Bloques de metal aleatorios en el interior
El sistema SHALL esparcir de 5 a 10 bloques de metal en el interior del mapa, reemplazando ladrillos existentes. Ningun bloque de metal SHALL aparecer en un tile vacio ni dentro de las zonas de base protegidas por `map_is_base_zone(tx,ty)`.

#### Scenario: Metal disperso
- **WHEN** se inspecciona el mapa generado
- **THEN** hay entre 5 y 10 tiles de metal fuera del borde exterior
- **THEN** ninguno de esos tiles toca una base

### Requirement: Las propiedades de los tiles se definen por flags de sprite
El sistema SHALL usar los flags de sprite de PICO-8 (`fget`/`fset`) para determinar el comportamiento de cada tile: flag 0 indica solido, flag 1 indica rompible y flag 2 indica base. El codigo de juego SHALL consultar estos flags en lugar de comparar indices de sprite directamente.

#### Scenario: Consulta de colision
- **WHEN** el jugador intenta moverse hacia un tile
- **THEN** el sistema consulta `fget(mget(tx, ty), 0)` para decidir si esta bloqueado

#### Scenario: Consulta de rompible
- **WHEN** una bala impacta un tile
- **THEN** el sistema consulta `fget(mget(tx, ty), 1)` para decidir si lo destruye

### Requirement: El mapa se renderiza antes que las entidades
El sistema SHALL llamar `map(0, 0, 0, 0, 16, 14)` al inicio de `_draw` antes de dibujar balas, enemigos y jugador, con la cámara desplazada para que el mapa quede debajo de la franja del HUD (`pico8.api.map`, `pico8.api.camera`).

#### Scenario: Orden de render
- **WHEN** se dibuja un frame de partida
- **THEN** el fondo del mapa aparece detras de todas las entidades
- **THEN** el mapa ocupa solo el area debajo del HUD

### Requirement: El jugador spawnea cerca de la base aliada
El sistema SHALL posicionar al jugador en el centro del tile (`BASE_ALLY_X`, 10), dos tiles por encima de la base aliada, al iniciar la partida y al comenzar cada nivel.

#### Scenario: Spawn del jugador
- **WHEN** comienza la partida o un nuevo nivel
- **THEN** el tanque del jugador aparece en la columna `BASE_ALLY_X`, dos tiles debajo de la base aliada
- **THEN** el jugador no aparece dentro de la camara sellada de la base aliada

### Requirement: Los enemigos spawnean en el borde superior aleatorio
El sistema SHALL colocar a los enemigos en posiciones aleatorias del borde superior (fila 1 o 2), asegurando que el tile elegido este vacio y que no pertenezca a la camara sellada de la base enemiga.

#### Scenario: Spawn enemigo aleatorio
- **WHEN** se inicializa un enemigo
- **THEN** su posicion de spawn es un tile vacio de las filas 1 o 2
- **THEN** el enemigo no aparece dentro de la camara sellada de la base enemiga

### Requirement: El revestimiento de bioma se aplica tras generar el laberinto base
El sistema SHALL ejecutar el algoritmo de generación del laberinto base (división recursiva, erosión, cámaras de base) antes de aplicar el revestimiento de tiles definido por el bioma activo.

#### Scenario: Orden de generación
- **WHEN** se genera un mapa
- **THEN** primero se crea el laberinto base con ladrillo, metal y vacíos
- **THEN** se aplican las reglas de revestimiento del bioma activo sobre los tiles elegibles
- **THEN** se conservan la conectividad y la estructura de las cámaras de base

### Requirement: El revestimiento de bioma respeta tiles estructurales
El sistema NO SHALL reemplazar el borde exterior de metal, las cámaras de base, ni los tiles que forman parte de la conectividad garantizada del laberinto.

#### Scenario: Protección de estructura
- **WHEN** se aplica el revestimiento de un bioma
- **THEN** el anillo exterior sigue siendo metal
- **THEN** las cámaras de base siguen selladas
- **THEN** existe al menos un camino desde la base aliada hasta la base enemiga
