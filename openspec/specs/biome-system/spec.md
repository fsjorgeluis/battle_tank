# biome-system Specification

## Purpose
Define los 8 biomas del juego, su mapeo de tiles de revestimiento sobre el laberinto base y su paleta de colores sutil aplicada únicamente al mundo.

## Requirements

### Requirement: El juego define 8 biomas distintos
El sistema SHALL mantener una tabla de 8 biomas, cada uno con un nombre único, una configuración de revestimiento de tiles y un mapeo de paleta.

#### Scenario: Lista de biomas
- **WHEN** se consulta la tabla de biomas
- **THEN** existen exactamente 8 entradas
- **THEN** cada entrada tiene nombre, tiles de revestimiento y paleta

### Requirement: Cada bioma define una mezcla de tiles de revestimiento
Cada bioma SHALL definir qué proporción de tiles vacíos o ladrillos del laberinto base se reemplazan por bosque, hielo, arena o agua, respetando los flags de comportamiento ya definidos.

#### Scenario: Mezcla de tiles
- **WHEN** se aplica el revestimiento de un bioma
- **THEN** los tiles del mapa reflejan la mezcla definida por ese bioma
- **THEN** los tiles de borde exterior y las zonas de base permanecen intactas

### Requirement: El revestimiento no altera la geometría ni la conectividad del laberinto base
El sistema SHALL aplicar el revestimiento sin eliminar paredes estructurales ni bloquear caminos previamente transitables.

#### Scenario: Conectividad preservada
- **WHEN** se compara el laberinto base con el laberinto revestido
- **THEN** los tiles sólidos del laberinto base siguen siendo sólidos o se reemplazan por tiles sólidos del mismo comportamiento
- **THEN** los tiles transitables del laberinto base siguen siendo transitables

### Requirement: Cada bioma define un mapeo sutil de paleta aplicado solo al mundo
Cada bioma SHALL definir un remapeo de índices de color (`pico8.api.pal`) que altere sutilmente la apariencia de los tiles sin afectar a entidades ni HUD (`pico8.constraint.palette-color-count`).

#### Scenario: Paleta aplicada a tiles
- **WHEN** se dibuja el mapa con un bioma activo
- **THEN** los colores de los tiles se muestran según el mapeo de paleta del bioma

#### Scenario: Entidades no afectadas
- **WHEN** se dibuja el jugador, un enemigo, una bala o el HUD
- **THEN** sus colores no son alterados por la paleta del bioma

### Requirement: La paleta del bioma se restaura antes de dibujar entidades y HUD
El sistema SHALL aplicar la paleta del bioma inmediatamente antes de dibujar el mundo y SHALL restaurar la paleta por defecto antes de dibujar entidades y HUD.

#### Scenario: Restauración de paleta
- **WHEN** se ejecuta el ciclo de dibujo de partida
- **THEN** el mundo se renderiza con la paleta del bioma
- **THEN** las entidades y el HUD se renderizan con la paleta por defecto
