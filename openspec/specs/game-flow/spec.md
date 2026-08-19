## Purpose

Define la máquina de estados del cartucho (menú, partida, game over, victoria) y sus transiciones explícitas, incluyendo el reinicio limpio de la partida.

## Requirements

### Requirement: Menú inicial con opciones Jugar y Salir
Al arrancar el cartucho, el juego SHALL mostrar un menú con dos opciones seleccionables: "Jugar" y "Salir". La selección visible SHALL alternar entre ambas con arriba/abajo y confirmarse con X. "Jugar" SHALL iniciar una partida en el estado partida; "Salir" SHALL detener la ejecución del cartucho. Las opciones SHALL ser navegables de forma circular (de Salir, arriba lleva a Jugar; de Jugar, abajo lleva a Salir).

#### Scenario: Navegar las opciones
- **WHEN** el cartucho está en el menú y se presiona arriba o abajo (btnp(2)/btnp(3))
- **THEN** la opción seleccionada cambia de forma visible entre "Jugar" y "Salir"

#### Scenario: Jugar confirmado
- **WHEN** estando en el menú se pulsa X (btnp(5)) con "Jugar" seleccionado
- **THEN** el estado pasa a partida
- **THEN** el mundo se inicia con estado fresco (posiciones, ángulos, vidas y enemigo inicializados)

#### Scenario: Salir confirmado
- **WHEN** estando en el menú se pulsa X (btnp(5)) con "Salir" seleccionado
- **THEN** la ejecución del cartucho se detiene

### Requirement: Transición de partida a game over
La máquina SHALL pasar al estado game over cuando la salud del jugador llega a cero durante la partida o cuando una bala destruye la base aliada, y mostrar la pantalla de game over.

#### Scenario: Salud agotada
- **WHEN** en estado partida el jugador pierde su última vida
- **THEN** el estado pasa a game over
- **THEN** se dibuja la pantalla de game over indicando el número de toques recibidos durante la partida y mostrando la instrucción de pulsar X para reintentar

#### Scenario: Base aliada destruida
- **WHEN** en estado partida una bala impacta la base aliada
- **THEN** el estado pasa a game over inmediatamente
- **THEN** se dibuja la pantalla de game over indicando que la base fue destruida y mostrando la instrucción de pulsar X para reintentar

### Requirement: Transición de partida a victoria
La máquina SHALL pasar al estado victoria cuando una bala del jugador destruye la base enemiga.

#### Scenario: Victoria por destrucción de base enemiga
- **WHEN** en estado partida una bala impacta la base enemiga
- **THEN** el estado pasa a victoria
- **THEN** se muestra una pantalla de victoria indicando que se destruyó la base enemiga y la instrucción de pulsar X para reintentar

#### Scenario: Reinicio desde victoria
- **WHEN** en estado victoria se pulsa X (btnp(5))
- **THEN** el estado vuelve a partida
- **THEN** se regenera el mapa, se reinician vidas, posiciones, balas y marcador

### Requirement: Reintentar desde game over
Estando en game over, pulsar X SHALL devolver el juego al estado partida con una partida re-inicializada de forma limpia.

#### Scenario: Reintento
- **WHEN** en game over se pulsa X (btnp(5))
- **THEN** el estado vuelve a partida
- **THEN** el jugador recupera 3 vidas, el tanque vuelve a su posición y ángulo iniciales, el enemigo recupera su estado inicial y el contador de toques recibidos se reinicia

### Requirement: Reinicio de cartucho
Al volver a ejecutar el cartucho (reinicio de PICO-8), el juego SHALL comenzar siempre en el menú inicial, sin arrastrar estado de partidas anteriores.

#### Scenario: Carga del cartucho
- **WHEN** el cartucho se ejecuta de nuevo desde cero
- **THEN** el juego arranca en el estado menú con la opción "Jugar" seleccionada

#### Scenario: Estados previos no persisten
- **WHEN** se interrumpe una partida y se vuelve a cargar el cartucho
- **THEN** no se conservan vidas, posiciones ni toques de la partida anterior: el juego empieza en el menú

### Requirement: Disparo en estado partida
El estado partida SHALL aceptar la entrada de disparo (X / btnp(5)) para crear balas (ver capability `projectiles`) mientras el jugador tiene vidas.

#### Scenario: Disparo permitido en partida
- **WHEN** el juego está en estado partida y el jugador pulsa X
- **THEN** se dispara una bala por la mecánica de `projectiles`

#### Scenario: Sin disparo fuera de partida
- **WHEN** el juego no está en estado partida (menú o game over) y se pulsa X
- **THEN** no se dispara ninguna bala

### Requirement: Reinicio limpio con balas y marcador
Al empezar una partida (desde el menú o al reintentar desde game over), la partida SHALL reiniciarse por completo: balas vacías, enemigos re-sembrados, marcador a 0, jugador reinicializado y el estado pasa a partida. No SHALL arrastrarse balas ni estado de enemigos de la partida anterior.

#### Scenario: Reintento con partida limpia
- **WHEN** desde game over se pulsa X para reintentar
- **THEN** no queda ninguna bala del round anterior en vuelo
- **THEN** el enemigo reaparece en su posición inicial
- **THEN** el marcador vuelve a 0
- **THEN** el jugador recupera vidas, posición y ángulos iniciales
