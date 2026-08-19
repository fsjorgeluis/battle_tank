## Purpose

Define la generación procedural del mapa de juego, sus tiles (ladrillo rompible, metal irrompible y bases), el renderizado con `map()` y la consulta de propiedades mediante flags de sprite, garantizando que todos los caminos estén conectados para que ningún tanque quede atrapado.

## ADDED Requirements

### Requirement: El mapa se genera proceduralmente al iniciar cada partida
El sistema SHALL generar un mapa nuevo de 16×16 tiles en `_init` de cada partida usando un algoritmo híbrido: división recursiva para crear un laberinto perfecto con pasillos de 1 tile, seguido de una erosión aleatoria de paredes internas para crear rutas alternativas. El mapa SHALL cubrir exactamente el área visible de 128×128 píxeles (pico8.constraint.display-resolution, pico8.constraint.sprite-size).

#### Scenario: Nueva partida, nuevo mapa
- **WHEN** el jugador inicia una partida desde el menú o reintenta desde game over
- **THEN** el mapa se regenera con una disposición diferente de paredes y caminos

### Requirement: Las bases ocupan posiciones fijas y están protegidas por ladrillos
El sistema SHALL colocar la base aliada en el tile (7, 14) con sprite 13 y la base enemiga en el tile (7, 1) con sprite 14. El sistema SHALL limpiar un área de 4×3 tiles frente a cada base (x=6..9, y=12..14 para la aliada; x=6..9, y=1..3 para la enemiga) y colocar un escudo compacto de ladrillos rompibles (sprite 11) en los laterales y la retaguardia, dejando una apertura frontal de exactamente 2 tiles. Además, el sistema SHALL garantizar conectividad tallando un corto corredor de 1 tile desde la apertura frontal hacia el laberinto. El escudo SHALL ser visualmente distinguishable del resto del laberinto.

#### Scenario: Posición de bases
- **WHEN** se genera el mapa
- **THEN** la base aliada aparece en (7, 14) y la base enemiga en (7, 1)

#### Scenario: Escudo compacto y visible
- **WHEN** se inspecciona el área alrededor de una base
- **THEN** los laterales y la retaguardia de la base están cubiertos por ladrillos rompibles
- **THEN** la apertura frontal es de exactamente 2 tiles de ancho
- **THEN** el escudo se distingue claramente del laberinto circundante

### Requirement: La división recursiva genera un laberinto perfecto
El sistema SHALL llenar el interior del mapa de vacío, dejando solo el borde exterior como ladrillo, y ejecutar un algoritmo de división recursiva. En cada división el sistema SHALL trazar una pared horizontal o vertical a través de la zona y abrir exactamente una puerta (tile vacío) en dicha pared. El proceso SHALL repetirse recursivamente hasta que las subzonas sean demasiado pequeñas. El resultado SHALL ser un laberinto perfecto donde existe exactamente un camino entre cualquier par de puntos.

#### Scenario: Laberinto perfecto
- **WHEN** se inspecciona el mapa generado
- **THEN** las paredes forman un patrón de laberinto con pasillos de 1 tile
- **THEN** no hay cámaras grandes ni espacios abiertos

### Requirement: La erosión de paredes crea rutas alternativas
Después de generar el laberinto perfecto, el sistema SHALL recorrer las paredes interiores y eliminar cada una con una probabilidad del 10 %. El sistema SHALL respetar el borde exterior y las zonas de base. El resultado SHALL ser un campo de batalla con esquinas tácticas y algunas rutas alternativas, sin perder la sensación de laberinto denso.

#### Scenario: Rutas alternativas
- **WHEN** se inspecciona el mapa erosionado
- **THEN** existen ciclos y atajos además del camino principal del laberinto
- **THEN** ninguna pared del borde exterior ni de las zonas de base fue eliminada

### Requirement: El borde exterior es metal irrompible
El sistema SHALL reemplazar todos los tiles del anillo exterior (fila 0, fila 15, columna 0, columna 15) por metal (sprite 12). Estos tiles SHALL ser irrompibles.

#### Scenario: Marco indestructible
- **WHEN** una bala impacta contra el borde exterior
- **THEN** el tile no se destruye
- **THEN** la bala desaparece

### Requirement: Bloques de metal aleatorios en el interior
El sistema SHALL esparcir de 5 a 10 bloques de metal en el interior del mapa, reemplazando ladrillos existentes. Ningún bloque de metal SHALL aparecer en un tile vacío ni adyacente directamente a una base.

#### Scenario: Metal disperso
- **WHEN** se inspecciona el mapa generado
- **THEN** hay entre 5 y 10 tiles de metal fuera del borde exterior
- **THEN** ninguno de esos tiles toca una base

### Requirement: Las propiedades de los tiles se definen por flags de sprite
El sistema SHALL usar los flags de sprite de PICO-8 (`fget`/`fset`) para determinar el comportamiento de cada tile: flag 0 indica sólido, flag 1 indica rompible y flag 2 indica base. El código de juego SHALL consultar estos flags en lugar de comparar índices de sprite directamente.

#### Scenario: Consulta de colisión
- **WHEN** el jugador intenta moverse hacia un tile
- **THEN** el sistema consulta `fget(mget(tx, ty), 0)` para decidir si está bloqueado

#### Scenario: Consulta de rompible
- **WHEN** una bala impacta un tile
- **THEN** el sistema consulta `fget(mget(tx, ty), 1)` para decidir si lo destruye

### Requirement: El mapa se renderiza antes que las entidades
El sistema SHALL llamar `map(0, 0, 0, 0, 16, 16)` al inicio de `_draw` antes de dibujar balas, enemigos y jugador (`pico8.api.map`).

#### Scenario: Orden de render
- **WHEN** se dibuja un frame de partida
- **THEN** el fondo del mapa aparece detrás de todas las entidades

### Requirement: El jugador spawnea cerca de la base aliada
El sistema SHALL posicionar al jugador en el centro del tile (7, 12), dos tiles debajo de la base aliada, al iniciar la partida.

#### Scenario: Spawn del jugador
- **WHEN** comienza la partida
- **THEN** el tanque del jugador aparece cerca de la base aliada, no sobre ella

### Requirement: Los enemigos spawnean en el borde superior aleatorio
El sistema SHALL colocar a los enemigos en posiciones aleatorias del borde superior (fila 1 o 2), asegurando que el tile elegido esté vacío.

#### Scenario: Spawn enemigo aleatorio
- **WHEN** se inicializa un enemigo
- **THEN** su posición de spawn es un tile vacío de las filas 1 o 2
