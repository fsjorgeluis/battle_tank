# level-progression Delta

## MODIFIED Requirements

### Requirement: El jugador completa un nivel al eliminar todos los enemigos de la oleada o al destruir la base enemiga
El sistema SHALL considerar completado el nivel actual cuando no queden enemigos vivos en la oleada del nivel o cuando una bala del jugador destruya la base enemiga, excepto en los niveles 4 y 8 donde la condición de completitud es la derrota del boss.

#### Scenario: Avance por oleada eliminada
- **WHEN** en estado partida el último enemigo de la oleada actual es eliminado y el nivel no es 4 ni 8
- **THEN** el nivel actual se marca como completado

#### Scenario: Avance por base destruida
- **WHEN** en estado partida una bala impacta la base enemiga y el nivel no es 4 ni 8
- **THEN** el nivel actual se marca como completado

#### Scenario: Avance por derrota del boss
- **WHEN** en estado partida del nivel 4 o 8 se cumple la condición de victoria del boss
- **THEN** el nivel actual se marca como completado

#### Scenario: Nivel 8 como victoria final
- **WHEN** se completa el nivel 8 por derrota del boss
- **THEN** el sistema pasa al estado de victoria final

### Requirement: Al completar un nivel se regenera el mapa para el siguiente bioma
El sistema SHALL generar un nuevo mapa procedural usando el bioma del siguiente nivel, excepto cuando el siguiente nivel sea 4 u 8, en cuyo caso SHALL cargar el layout fijo de arena de boss correspondiente.

#### Scenario: Mapa nuevo
- **WHEN** se completa un nivel cuyo siguiente nivel no es 4 ni 8
- **THEN** el mapa se regenera con el bioma del nivel siguiente
- **THEN** la disposición de tiles difiere del nivel anterior

#### Scenario: Carga de arena de boss
- **WHEN** se completa el nivel 3 o 7
- **THEN** el siguiente nivel carga el layout fijo de arena de boss
- **THEN** no se ejecuta el generador procedural

## ADDED Requirements

### Requirement: Los niveles 4 y 8 se identifican como niveles de boss
El sistema SHALL detectar que el nivel actual es 4 o 8 y activar el modo de combate de boss, incluyendo la carga de la arena fija, la aparición del boss y la suspensión de las reglas normales de oleada/base enemiga.

#### Scenario: Nivel 4 detectado
- **WHEN** el nivel actual pasa a 4
- **THEN** el sistema marca el nivel como nivel de boss
- **THEN** se carga la arena de boss 4
- **THEN** no se generan enemigos de oleada ni bases enemigas

#### Scenario: Nivel 8 detectado
- **WHEN** el nivel actual pasa a 8
- **THEN** el sistema marca el nivel como nivel de boss
- **THEN** se carga la arena de boss 8
- **THEN** no se generan enemigos de oleada ni bases enemigas
