# boss-arena Specification

## Purpose

Define el layout, las condiciones de inicio y fin, y las propiedades de la arena especial para los niveles 4 y 8 del juego.

## ADDED Requirements

### Requirement: Los niveles 4 y 8 usan un layout de arena fijo
El sistema SHALL cargar un mapa predefinido para el nivel 4 y otro para el nivel 8 en lugar de generarlos proceduralmente. Ambos layouts SHALL estar diseñados como arenas de boss.

#### Scenario: Nivel 4
- **WHEN** comienza el nivel 4
- **THEN** el mapa cargado es el layout fijo de arena de boss 4
- **THEN** no se ejecuta el generador procedural de biomas

#### Scenario: Nivel 8
- **WHEN** comienza el nivel 8
- **THEN** el mapa cargado es el layout fijo de arena de boss 8
- **THEN** no se ejecuta el generador procedural de biomas

### Requirement: La arena tiene suficiente espacio abierto para esquivar
El sistema SHALL garantizar una zona central abierta de al menos 12×8 tiles (96×64 px) donde pueda moverse tanto el boss de 32×32 px como el jugador.

#### Scenario: Espacio de maniobra
- **WHEN** el jugador entra a la arena
- **THEN** existe un área central sin tiles sólidos que ocupa al menos 12×8 tiles
- **THEN** el boss de 32×32 px cabe dentro de esa zona sin quedar encajonado

### Requirement: La arena es ligeramente asimétrica
El sistema SHALL disponer obstáculos de forma que no exista una posición simétrica desde la cual el jugador pueda atacar indefinidamente sin riesgo. Los obstáculos deben romper líneas de visión pero no bloquear completamente el movimiento.

#### Scenario: Obstáculos asimétricos
- **WHEN** se observa el layout de la arena
- **THEN** los obstáculos no forman un patrón perfectamente simétrico respecto al eje vertical u horizontal
- **THEN** desde cualquier posición del jugador al menos un componente del boss puede responder

### Requirement: El jugador spawnea en la parte inferior de la arena
El sistema SHALL colocar al jugador en la parte inferior de la arena al iniciar el nivel, lejos del boss. El boss SHALL spawnear en la zona central superior.

#### Scenario: Posiciones iniciales
- **WHEN** comienza el nivel 4 o 8
- **THEN** el jugador aparece en la fila inferior de tiles jugables
- **THEN** el boss aparece en la zona central de la arena

### Requirement: Los obstáculos no permiten exploits de camping
El sistema SHALL colocar obstáculos de modo que el jugador no pueda quedar completamente a cubierto de todos los ataques del boss indefinidamente ni disparar al boss sin que este pueda responder.

#### Scenario: Sin esquina segura
- **WHEN** el jugador se posiciona detrás de un obstáculo
- **THEN** al menos una torreta o cañón activo tiene línea de visión hacia el jugador
- **THEN** el jugador no puede disparar continuamente a un componente sin exponerse

### Requirement: La arena sigue las reglas de tile y física del resto del juego
El sistema SHALL usar los mismos tipos de tile sólido y las mismas reglas de colisión que en niveles procedurales. El jugador y el boss SHALL respetar las paredes y obstáculos de la arena.

#### Scenario: Colisión con paredes
- **WHEN** el jugador o el boss se mueve hacia un tile sólido
- **THEN** la entidad se detiene o desliza según las reglas de `tile-physics`

### Requirement: Al derrotar al boss se completa el nivel
El sistema SHALL considerar completado el nivel 4 o 8 cuando se cumpla la condición de victoria del boss. Tras la victoria, el sistema SHALL ejecutar la transición de nivel definida por `game-flow`.

#### Scenario: Victoria en arena
- **WHEN** el jugador destruye todos los sistemas críticos del boss
- **THEN** el nivel actual se marca como completado
- **THEN** se inicia la transición al siguiente nivel o a pantalla de victoria final
