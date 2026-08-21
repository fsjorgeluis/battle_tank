## MODIFIED Requirements

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

### Requirement: El jugador spawnea cerca de la base aliada
El sistema SHALL posicionar al jugador en el centro del tile (`BASE_ALLY_X`, 10), dos tiles por encima de la base aliada, al iniciar la partida y al comenzar cada nivel.

#### Scenario: Spawn del jugador
- **WHEN** comienza la partida o un nuevo nivel
- **THEN** el tanque del jugador aparece en la columna `BASE_ALLY_X`, dos tiles debajo de la base aliada
- **THEN** el jugador no aparece dentro de la camara sellada de la base aliada

## ADDED Requirements

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
