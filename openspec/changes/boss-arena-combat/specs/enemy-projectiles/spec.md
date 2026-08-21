# enemy-projectiles Specification

## Purpose

Define el comportamiento de los proyectiles disparados por el boss y sus componentes, incluyendo límites de cantidad, colisiones y patrones de disparo.

## ADDED Requirements

### Requirement: El sistema mantiene un límite estricto de balas enemigas simultáneas
El sistema SHALL permitir como máximo 6 balas enemigas activas al mismo tiempo. Si un nuevo disparo excedería el límite, el sistema SHALL descartar el disparo o reutilizar la bala más antigua según la política definida en el diseño.

#### Scenario: Límite alcanzado
- **WHEN** ya existen 6 balas enemigas activas
- **THEN** un nuevo disparo no crea una séptima bala
- **THEN** el comportamiento de descarte es determinista

#### Scenario: Reutilización de balas
- **WHEN** una bala enemiga sale de pantalla o impacta
- **THEN** su slot queda disponible para el siguiente disparo

### Requirement: Las balas enemigas colisionan con el jugador
El sistema SHALL detectar colisión AABB entre cada bala enemiga activa y el jugador. Al impactar, el sistema SHALL aplicar el daño o regla de muerte definida por `player-health` y destruir la bala.

#### Scenario: Impacto al jugador
- **WHEN** una bala enemiga activa intersecta la hitbox del jugador
- **THEN** la bala se destruye
- **THEN** se aplica la regla de daño del jugador

#### Scenario: Balas no colisionan entre sí
- **WHEN** dos balas enemigas se cruzan
- **THEN** ambas continúan su trayectoria

### Requirement: Las balas enemigas tienen tiempo de vida
El sistema SHALL asignar un TTL (time to live) a cada bala enemiga. Una bala que exceda su TTL o salga de los límites del mundo SHALL destruirse automáticamente.

#### Scenario: TTL expirado
- **WHEN** una bala enemiga supera su tiempo de vida máximo
- **THEN** se elimina de la lista de balas activas
- **THEN** deja de renderizarse

### Requirement: Las balas enemigas pueden ser dirigidas o en abanico
El sistema SHALL soportar al menos dos tipos de trayectoria inicial: balas dirigidas hacia la posición actual del jugador y balas en abanico con ángulos fijos alrededor de una dirección base.

#### Scenario: Bala dirigida
- **WHEN** un cañón dispara
- **THEN** la bala viaja en línea recta hacia la posición que ocupaba el jugador en el momento del disparo

#### Scenario: Bala en abanico
- **WHEN** una torreta dispara un abanico en fase 3
- **THEN** se generan 3 balas con ángulos separados 30 grados
- **THEN** cada bala viaja en línea recta desde su ángulo de salida

### Requirement: La velocidad de las balas enemigas permite reaccionar
El sistema SHALL hacer que las balas enemigas viajen a una velocidad menor o igual a 2 px/frame. La velocidad SHALL ser configurable para balanceo.

#### Scenario: Velocidad configurada
- **WHEN** el parámetro `enemy_bullet_speed` está en 1.75 px/frame
- **THEN** todas las balas enemigas nuevas usan esa velocidad
- **THEN** el jugador tiene tiempo suficiente para esquivar desde una distancia razonable
