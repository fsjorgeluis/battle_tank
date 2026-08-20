## Purpose

Define la franja fija superior de 16 píxeles para el HUD y el uso de la cámara de PICO-8 para separar las coordenadas del mundo de las coordenadas de pantalla, evitando que el HUD se solape con los tiles del mapa.

## ADDED Requirements

### Requirement: El HUD ocupa una franja fija de 16 píxeles en la parte superior de la pantalla
El sistema SHALL reservar los primeros 16 píxeles de la pantalla (screen y=0..15) exclusivamente para el HUD. Ningún tile del mundo ni entidad del juego SHALL renderizarse dentro de esa franja (`pico8.constraint.display-resolution`, `pico8.constraint.sprite-size`).

#### Scenario: Franja libre de tiles
- **WHEN** se dibuja un frame de partida
- **THEN** la franja superior de 16 píxeles contiene solo los elementos del HUD
- **THEN** no se ven tiles del borde de metal ni ninguna otra entidad solapando el HUD

### Requirement: El mundo se dibuja con la cámara desplazada y el HUD con la cámara reseteada
El sistema SHALL aplicar un desplazamiento de cámara de `-HUD_H` píxeles en el eje Y antes de dibujar el mundo, de modo que el área jugable se renderice completamente debajo de la franja del HUD. Inmediatamente antes de dibujar el HUD, el sistema SHALL llamar `camera()` para restablecer el origen de dibujo a `(0, 0)` (`pico8.api.camera`).

#### Scenario: Orden de cámara en el ciclo de dibujo
- **WHEN** se ejecuta el ciclo de dibujo de partida
- **THEN** el mundo y las entidades se dibujan con `camera(0, -HUD_H)`
- **THEN** el HUD se dibuja con `camera(0, 0)`
- **THEN** el HUD permanece en la misma posición de pantalla en todos los frames

### Requirement: El HUD muestra vidas, toques y puntos en coordenadas de pantalla fijas
El sistema SHALL dibujar los indicadores de vidas, toques recibidos y puntaje usando coordenadas de pantalla absolutas, independientes del desplazamiento de cámara del mundo.

#### Scenario: Posición fija del HUD
- **WHEN** comienza una partida
- **THEN** los corazones aparecen en la parte superior izquierda de la pantalla
- **THEN** los textos "toques" y "puntos" aparecen en la parte superior derecha de la pantalla
- **THEN** ningún elemento del HUD cambia de posición durante la partida
