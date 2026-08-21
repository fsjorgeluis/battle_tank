## REMOVED Requirements

### Requirement: El enemigo reaparece en otra zona tras morir
**Reason**: Reemplazado por el sistema de oleadas finitas por nivel; el avance de nivel requiere eliminar a todos los enemigos de la oleada actual.
**Migration**: Los enemigos se sembrarán en oleadas al inicio de cada nivel mediante `LEVEL_WAVES[level]`; no habrá respawn dentro de un nivel.

## ADDED Requirements

### Requirement: Cada nivel define una oleada finita de enemigos
El sistema SHALL mantener una tabla con la cantidad de enemigos por oleada para cada uno de los 8 niveles. Al iniciar un nivel se SHALL sembrar exactamente esa cantidad de enemigos.

#### Scenario: Oleada del nivel 1
- **WHEN** comienza el nivel 1
- **THEN** aparece la cantidad de enemigos configurada para el nivel 1

#### Scenario: Oleada de nivel superior
- **WHEN** comienza un nivel n (donde 2 ≤ n ≤ 8)
- **THEN** aparece la cantidad de enemigos configurada para el nivel n
- **THEN** la cantidad puede ser igual o mayor que la del nivel 1

### Requirement: La oleada se marca como completada cuando no quedan enemigos vivos
Cuando todos los enemigos de la oleada actual han sido eliminados, el sistema SHALL considerar la oleada completada y notificar al capability `level-progression` para el avance de nivel.

#### Scenario: Oleada completada
- **WHEN** el último enemigo vivo de la oleada actual es eliminado
- **THEN** no aparece un nuevo enemigo tras el retardo de respawn
- **THEN** el sistema marca el nivel como completado (ver capability `level-progression`)

#### Scenario: Oleada sembrada al inicio de nivel
- **WHEN** comienza un nuevo nivel
- **THEN** aparecen los enemigos de la oleada de ese nivel en posiciones de spawn válidas
- **THEN** todos los enemigos sembrados están vivos y sujetos a las reglas de contacto y eliminación

### Requirement: Los enemigos de una oleada se gestionan como una lista
El estado de los enemigos de una partida SHALL mantenerse como una lista de enemigos, donde cada elemento modela su posición y su estado (vivo o no). La lista se reinicia al comenzar cada nivel.

#### Scenario: Lista reiniciada por nivel
- **WHEN** comienza un nuevo nivel
- **THEN** la lista de enemigos contiene solo los enemigos de la oleada del nuevo nivel
- **THEN** no quedan enemigos muertos ni estados heredados del nivel anterior
