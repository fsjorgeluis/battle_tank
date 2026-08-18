## Purpose

Permite que las entidades móviles del juego (jugador y enemigos) dejen un rastro de oruga visible sobre el terreno que se desvanece con el tiempo, mejorando la sensación de movimiento y la ambientación del campo de batalla.

## ADDED Requirements

### Requirement: Rastro se genera solo en movimiento
El sistema SHALL crear nuevos puntos de rastro únicamente cuando una entidad se está desplazando a una velocidad igual o superior a un umbral configurable.

#### Scenario: Tanque acelerando
- **WHEN** el jugador mantiene presionada una flecha de dirección
- **THEN** el tanque emite nuevos puntos de rastro en cada frame de movimiento

#### Scenario: Tanque deslizando por inercia
- **WHEN** el jugador suelta la flecha pero la velocidad del tanque sigue siendo mayor o igual al umbral de rastro
- **THEN** el tanque sigue emitiendo puntos de rastro hasta que la velocidad cae por debajo del umbral

#### Scenario: Tanque detenido
- **WHEN** el tanque tiene velocidad cero o por debajo del umbral
- **THEN** no se generan nuevos puntos de rastro

### Requirement: Dos puntos de oruga por posición
El sistema SHALL generar dos puntos de rastro por entidad en cada emisión, situados a ambos lados del centro del tanque y perpendiculares a su dirección, simulando las marcas de las cadenas.

#### Scenario: Tanque moviéndose en línea recta
- **WHEN** el tanque avanza en cualquiera de las cuatro direcciones cardinales
- **THEN** aparecen dos líneas paralelas de puntos a la izquierda y derecha del centro del sprite

#### Scenario: Tanque girando en esquina
- **WHEN** el tanque cambia de dirección en un ángulo de 90 grados
- **THEN** los dos puntos de cada frame dibujan la esquina del giro, manteniendo la separación perpendicular a la nueva dirección

### Requirement: Rastro envejece y desaparece gradualmente
El sistema SHALL asignar un tiempo de vida a cada punto de rastro y reducirlo en cada frame; el punto dejará de dibujarse cuando su vida llegue a cero o menos.

#### Scenario: Punto recién creado
- **WHEN** un punto de rastro se acaba de emitir
- **THEN** se dibuja con máxima probabilidad/opacidad visual

#### Scenario: Punto a punto de desaparecer
- **WHEN** un punto de rastro tiene muy poca vida restante
- **THEN** se dibuja con muy baja probabilidad u opacidad, o no se dibuja

#### Scenario: Punto expirado
- **WHEN** un punto de rastro alcanza vida cero o negativa
- **THEN** se elimina de la tabla y no vuelve a dibujarse

### Requirement: Rastro se dibuja bajo las entidades con `pset`
El sistema SHALL dibujar todos los puntos de rastro usando `pset()` con color gris oscuro, después de limpiar la pantalla con `cls()` y antes de dibujar cualquier entidad, de forma que el tanque y los enemigos cubran visualmente el rastro.

#### Scenario: Orden de render en partida
- **WHEN** se renderiza un frame de juego
- **THEN** el orden de dibujo es: fondo limpio → rastros → entidades → balas/HUD

#### Scenario: Representación de cada punto
- **WHEN** un punto de rastro está visible
- **THEN** se dibuja como un píxel individual de color gris oscuro

### Requirement: Soportar jugador y enemigos
El sistema SHALL permitir que cualquier entidad móvil registre puntos de rastro, incluyendo al jugador y a los tanques enemigos, sin duplicar la estructura de datos ni la lógica de dibujo.

#### Scenario: Enemigo estacionario
- **WHEN** un enemigo no se mueve
- **THEN** no emite rastro

#### Scenario: Enemigo en movimiento
- **WHEN** un enemigo se desplaza a velocidad igual o superior al umbral
- **THEN** emite rastro con la misma lógica que el jugador

### Requirement: Limpieza al reiniciar partida
El sistema SHALL vaciar la tabla de puntos de rastro al iniciar o reiniciar una partida, evitando que reaparezcan marcas de partidas anteriores.

#### Scenario: Reinicio de cartucho
- **WHEN** se reinicia el juego o se inicia una nueva partida
- **THEN** la tabla de rastros está vacía y no se dibuja ningún punto residual
