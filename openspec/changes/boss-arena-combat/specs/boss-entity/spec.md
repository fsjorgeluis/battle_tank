# boss-entity Specification

## Purpose

Define la representación visual, la geometría y el estado de una entidad boss compuesta por múltiples componentes editables directamente en el sprite editor de PICO-8.

## ADDED Requirements

### Requirement: El boss es una entidad lógica única compuesta por componentes independientes
El sistema SHALL representar al boss como una única tabla `boss` con propiedades globales (posición, fase, timers) y una lista de componentes. Cada componente SHALL tener su propio estado, hitbox y referencia a las celdas de sprite que lo renderizan.

#### Scenario: Estructura del boss
- **WHEN** se inicializa el combate de boss
- **THEN** existe una entidad `boss` con posición, fase y una lista de componentes
- **THEN** cada componente tiene identificador, tipo, vida, estado vivo/destruido y referencia a celdas de sprite

### Requirement: La composición visual del boss ocupa un bloque fijo de 4×4 sprites de 8×8
El sistema SHALL reservar un bloque contiguo de 4×4 sprites en la hoja de sprites para el boss completo. Cada celda del bloque SHALL corresponder a una posición fija del boss: cuerpo central, torretas, cañones u orugas. El artista SHALL poder ver y editar el boss completo abriendo ese bloque en el sprite editor.

#### Scenario: Bloque visible en el sprite editor
- **WHEN** se abre el sprite editor en el bloque reservado para el boss
- **THEN** se visualiza la silueta completa del boss de 32×32 píxeles
- **THEN** cada componente ocupa celdas predecibles del bloque 4×4

#### Scenario: Componentes sin offsets arbitrarios
- **WHEN** se define un componente del boss
- **THEN** su posición visual se expresa como fila y columna dentro del bloque 4×4
- **THEN** no se requieren offsets numéricos ad-hoc para reconstruir la apariencia

### Requirement: Cada componente tiene una hitbox propia relativa al boss
El sistema SHALL definir una hitbox rectangular por componente, expresada en píxeles relativos al origen del boss. Las hitboxes de componentes destruidos SHALL dejar de participar en colisiones.

#### Scenario: Colisión con bala del jugador
- **WHEN** una bala del jugador intersecta la hitbox de un componente vivo
- **THEN** el componente recibe daño
- **THEN** una vez destruido, la hitbox de ese componente no genera más colisiones

### Requirement: El cuerpo central del boss es invulnerable
El sistema SHALL marcar el cuerpo central como de tipo `body` con vida infinita. Las balas del jugador que impacten la hitbox del cuerpo central SHALL no producir daño ni efecto de destrucción.

#### Scenario: Disparo al cuerpo central
- **WHEN** una bala del jugador impacta la hitbox del cuerpo central
- **THEN** la bala se destruye o rebota según la mecánica existente
- **THEN** el cuerpo central no muestra daño ni cambio de estado

### Requirement: El renderizado dibuja solo los componentes vivos
El sistema SHALL recorrer los componentes del boss y dibujar únicamente las celdas de aquellos cuyo estado sea vivo. Un componente destruido puede dejar de dibujarse o mostrar un sprite alternativo destruido si se definió.

#### Scenario: Torreta destruida desaparece
- **WHEN** una torreta pasa a estado destruido
- **THEN** en el siguiente frame deja de renderizarse su celda en el bloque 4×4
- **THEN** el resto del boss sigue renderizándose normalmente

### Requirement: El boss no rota libremente
El sistema SHALL mover el boss únicamente en las cuatro direcciones cardinales (arriba, abajo, izquierda, derecha) sin rotación. La orientación visual del boss SHALL mantenerse fija; las torretas y cañones apuntan según su posición en el bloque 4×4.

#### Scenario: Movimiento del boss
- **WHEN** el boss avanza hacia el jugador
- **THEN** se desplaza en línea recta sobre uno de los ejes cardinales
- **THEN** la orientación de los sprites del boss no cambia
