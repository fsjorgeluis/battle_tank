# level-progression Specification

## Purpose
Define la progresión de la partida a través de 8 niveles lineales, las condiciones de completitud de cada nivel, la persistencia de estado entre niveles y la presentación del bioma al inicio de cada nivel.

## Requirements

### Requirement: La partida consta de 8 niveles lineales
El sistema SHALL mantener un contador de nivel actual que comienza en 1 al iniciar una partida nueva y avanza secuencialmente hasta 8. El sistema SHALL considerar la partida completada al terminar el nivel 8.

#### Scenario: Inicio de partida
- **WHEN** el jugador inicia una partida desde el menú
- **THEN** el nivel actual es 1

#### Scenario: Secuencia de niveles
- **WHEN** el jugador completa el nivel 1
- **THEN** el nivel actual pasa a 2
- **THEN** el proceso continúa hasta alcanzar el nivel 8

### Requirement: Cada nivel está asociado a un bioma
El sistema SHALL asignar un bioma a cada uno de los 8 niveles según una tabla fija de nivel → bioma.

#### Scenario: Bioma por nivel
- **WHEN** el nivel actual es n (donde 1 ≤ n ≤ 8)
- **THEN** el sistema utiliza el bioma correspondiente a ese nivel para generar el mapa y aplicar la paleta

### Requirement: El jugador completa un nivel al eliminar todos los enemigos de la oleada o al destruir la base enemiga
El sistema SHALL considerar completado el nivel actual cuando no queden enemigos vivos en la oleada del nivel o cuando una bala del jugador destruya la base enemiga.

#### Scenario: Avance por oleada eliminada
- **WHEN** en estado partida el último enemigo de la oleada actual es eliminado
- **THEN** el nivel actual se marca como completado

#### Scenario: Avance por base destruida
- **WHEN** en estado partida una bala impacta la base enemiga
- **THEN** el nivel actual se marca como completado

#### Scenario: Nivel 8 como victoria final
- **WHEN** se completa el nivel 8 por cualquiera de las condiciones válidas
- **THEN** el sistema pasa al estado de victoria final

### Requirement: Al completar un nivel se conservan vidas y puntaje
El sistema SHALL conservar el número de vidas y el marcador de puntos al pasar de un nivel al siguiente.

#### Scenario: Vidas persisten
- **WHEN** el jugador completa un nivel con v vidas
- **THEN** el siguiente nivel comienza con v vidas

#### Scenario: Puntaje persiste
- **WHEN** el jugador completa un nivel con p puntos
- **THEN** el siguiente nivel comienza con p puntos

### Requirement: Al completar un nivel se resetean posición, enemigos, balas, efectos y toques recibidos
El sistema SHALL reiniciar la posición del jugador, el estado de los enemigos, la lista de balas, los efectos visuales y el contador de toques recibidos al comenzar un nuevo nivel.

#### Scenario: Reset de posición
- **WHEN** comienza un nuevo nivel
- **THEN** el jugador spawnea en la posición inicial correspondiente a la nueva base aliada

#### Scenario: Reset de enemigos y balas
- **WHEN** comienza un nuevo nivel
- **THEN** no quedan balas del nivel anterior
- **THEN** los enemigos se inicializan según la oleada del nuevo nivel

#### Scenario: Reset de toques
- **WHEN** comienza un nuevo nivel
- **THEN** el contador de toques recibidos vuelve a 0

### Requirement: Al completar un nivel se regenera el mapa para el siguiente bioma
El sistema SHALL generar un nuevo mapa procedural usando el bioma del siguiente nivel.

#### Scenario: Mapa nuevo
- **WHEN** se completa un nivel
- **THEN** el mapa se regenera con el bioma del nivel siguiente
- **THEN** la disposición de tiles difiere del nivel anterior

### Requirement: Se muestra un banner con el nombre del bioma al iniciar cada nivel
El sistema SHALL mostrar brevemente en pantalla el nombre del bioma al comenzar cada nivel, antes de que el jugador pueda moverse.

#### Scenario: Banner visible
- **WHEN** comienza un nivel
- **THEN** aparece en pantalla un banner con el nombre del bioma asociado

#### Scenario: Banner desaparece
- **WHEN** transcurre el tiempo de visualización del banner o el jugador pulsa X
- **THEN** el banner desaparece y el jugador puede controlar el tanque
