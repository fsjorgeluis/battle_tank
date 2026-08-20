## Purpose

Definir la capa de render de tiles que deben dibujarse después de las entidades para producir efectos visuales como el tanque ocultándose bajo el follaje, sin afectar la lógica de colisión ni de balas.

## ADDED Requirements

### Requirement: Los tiles con flag OVERLAY se dibujan después de todas las entidades
El sistema SHALL identificar los tiles que tienen el flag `OVERLAY` y dibujarlos en una pasada posterior a todas las entidades (rastros, enemigos, efectos, jugador y balas) en el ciclo de render de partida (`pico8.api.spr`).

#### Scenario: Orden de capas en partida
- **WHEN** se ejecuta el ciclo de dibujo de partida
- **THEN** primero se dibuja la capa base del mapa con `map()`
- **THEN** se dibujan rastros, enemigos, efectos, jugador y balas
- **THEN** se dibujan los tiles con `OVERLAY` usando `spr()`

### Requirement: El bosque se renderiza como tile OVERLAY
El tile de bosque SHALL tener el flag `OVERLAY`. Al renderizarse, el sprite del bosque SHALL aparecer por encima del jugador y de cualquier otra entidad que se encuentre sobre ese tile.

#### Scenario: Tanque parcialmente oculto por bosque
- **WHEN** el jugador se mueve sobre un tile de bosque
- **THEN** el sprite del tanque se dibuja primero
- **THEN** el sprite del bosque se dibuja después, cubriendo parcial o totalmente al tanque

### Requirement: La pasada de overlay respeta la cámara desplazada del HUD
La pasada de overlay SHALL usar las mismas coordenadas de mundo que el resto del render del mundo, respetando el desplazamiento de cámara `camera(0, -HUD_H)` aplicado antes de dibujar el mundo (`pico8.api.camera`).

#### Scenario: Overlay alineado con el mapa
- **WHEN** se dibuja un frame de partida con el HUD visible
- **THEN** los tiles de overlay aparecen alineados con sus correspondientes tiles del mapa base
- **THEN** los tiles de overlay no se desplazan respecto al HUD ni al resto del mundo

### Requirement: La pasada de overlay cubre todo el mapa visible
La función de dibujo de overlay SHALL recorrer todos los tiles del área jugable (16×14) y dibujar únicamente aquellos con flag `OVERLAY`.

#### Scenario: Bosques dispersos en el mapa
- **WHEN** hay varios tiles de bosque en distintas posiciones del mapa
- **THEN** todos ellos se dibujan en la pasada de overlay
- **THEN** ningún tile sin `OVERLAY` se dibuja dos veces

### Requirement: El overlay no afecta la lógica de colisión ni de balas
Aunque el bosque se dibuje sobre las entidades, el sistema SHALL seguir tratando el bosque como transitable y atravesable por balas. El render overlay SHALL ser puramente visual.

#### Scenario: Bala bajo el bosque
- **WHEN** una bala cruza un tile de bosque
- **THEN** el bosque se dibuja sobre la bala
- **THEN** la bala continúa su trayectoria sin destruir el bosque
