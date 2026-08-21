## ADDED Requirements

### Requirement: El HUD muestra el nivel actual
El sistema SHALL dibujar el número de nivel actual en la franja superior del HUD, junto a los indicadores de vidas, toques y puntos, usando coordenadas de pantalla absolutas.

#### Scenario: HUD muestra nivel al inicio
- **WHEN** comienza una partida
- **THEN** el HUD muestra el nivel 1

#### Scenario: HUD actualiza el nivel
- **WHEN** el jugador avanza de nivel
- **THEN** el indicador de nivel en el HUD muestra el nuevo valor

#### Scenario: Posición fija del indicador de nivel
- **WHEN** se dibuja un frame de partida
- **THEN** el indicador de nivel permanece en la misma posición de pantalla
- **THEN** el indicador de nivel no se desplaza con la cámara del mundo
