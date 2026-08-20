# tile-behaviour Specification

## Purpose
Define los tipos de tile del juego por su comportamiento frente a tanques y balas, codificados mediante flags de sprite de PICO-8, de modo que el mapa pueda ofrecer variedad táctica sin depender de la generación procedural.

## Requirements

### Requirement: La física de movimiento de cada tile se clasifica por flags de sprite
El sistema SHALL usar los flags de sprite (`fget`/`fset`) para determinar las propiedades binarias de movimiento de cada tile, en lugar de comparar índices de sprite directamente (`pico8.api.fget`, `pico8.api.fset`). El sistema SHALL reconocer los siguientes flags semánticos: `SOLID` (bloquea tanques), `BREAKABLE` (se destruye con balas), `SLOW` (ralentiza al tanque), `SLIDE` (hace deslizar al tanque) y `OVERLAY` (se dibuja sobre entidades).

#### Scenario: Configuración de flags en la inicialización
- **WHEN** se ejecuta `_init()`
- **THEN** cada tile especial tiene configurados sus flags correspondientes mediante `fset()`
- **THEN** el ladrillo tiene `SOLID` y `BREAKABLE`
- **THEN** el metal tiene `SOLID`
- **THEN** las bases tienen `SOLID`
- **THEN** el bosque tiene `OVERLAY`
- **THEN** el hielo tiene `SLIDE`
- **THEN** la arena tiene `SLOW`
- **THEN** el agua tiene `SOLID`

### Requirement: La interacción bala↔tile se define mediante una tabla de lookup
El sistema SHALL usar una tabla en código (`BULLET_TILE_ACT`) que mapea cada tile relevante a una acción de bala. Las acciones posibles SHALL ser: `BULLET_PASS` (la bala atraviesa), `BULLET_DESTROY` (la bala destruye el tile y desaparece), `BULLET_BOUNCE` (la bala desaparece sin destruir el tile), `BULLET_VICTORY` (la bala desaparece y activa el estado de victoria) y `BULLET_GAMEOVER` (la bala desaparece y activa el estado de game over).

#### Scenario: Configuración de la tabla
- **WHEN** se inspecciona `src/const.lua`
- **THEN** existe `BULLET_TILE_ACT` con una entrada para cada tile que interactúa con balas
- **THEN** el ladrillo se mapea a `BULLET_DESTROY`
- **THEN** el metal se mapea a `BULLET_BOUNCE`
- **THEN** el bosque se mapea a `BULLET_PASS`
- **THEN** el agua se mapea a `BULLET_PASS`
- **THEN** la base enemiga se mapea a `BULLET_VICTORY`
- **THEN** la base aliada se mapea a `BULLET_GAMEOVER`

### Requirement: El bosque no bloquea ni destruye balas
El bosque SHALL ser transitable para el tanque. Las balas SHALL atravesar el bosque sin destruirlo ni desaparecer. El bosque SHALL tener el flag `OVERLAY` para ser renderizado después de las entidades.

#### Scenario: Tanque bajo el bosque
- **WHEN** el jugador se mueve sobre un tile de bosque
- **THEN** el tanque puede atravesarlo libremente
- **THEN** la bala también atraviesa el bosque sin colisionar

#### Scenario: Bosque como capa superior
- **WHEN** se renderiza un frame con el tanque sobre un tile de bosque
- **THEN** el sprite del bosque se dibuja después del tanque, ocultando parcialmente al tanque

### Requirement: El hielo es transitable y hace deslizar al tanque
El hielo SHALL ser transitable. El tile SHALL tener el flag `SLIDE` para que la física de movimiento aplique baja fricción y conserve el vector de velocidad aunque el jugador suelte la tecla o gire el cañón.

#### Scenario: Entrar en hielo
- **WHEN** el tanque se mueve desde tierra firme hacia un tile de hielo
- **THEN** el tanque entra al tile de hielo sin bloquearse
- **THEN** al soltar la tecla, el tanque sigue deslizando en la dirección previa

### Requirement: La arena es transitable y ralentiza al tanque
La arena SHALL ser transitable. El tile SHALL tener el flag `SLOW` para que la física de movimiento reduzca la velocidad máxima y la aceleración efectivas.

#### Scenario: Cruzar arena
- **WHEN** el tanque se mueve sobre un tile de arena
- **THEN** el tanque avanza más lento que sobre tierra firme
- **THEN** el tanque alcanza una velocidad máxima menor

### Requirement: El agua bloquea tanques pero no balas
El agua SHALL bloquear el movimiento del tanque (tiene `SOLID`). Las balas SHALL atravesar el agua sin colisionar. La distinción para balas SHALL estar en la tabla `BULLET_TILE_ACT`, no en un flag adicional.

#### Scenario: Tanque frente al agua
- **WHEN** el jugador intenta mover el tanque hacia un tile de agua
- **THEN** el tanque se detiene antes de ocupar el tile de agua

#### Scenario: Bala sobre agua
- **WHEN** una bala cruza un tile de agua
- **THEN** la bala no desaparece
- **THEN** la bala no altera el tile de agua

### Requirement: Los nuevos tiles tienen sprites placeholder distinguibles
El sistema SHALL incluir al menos un sprite placeholder distinguible para cada nuevo comportamiento: bosque, hielo, arena y agua. El sistema puede incluir variantes visuales adicionales mientras se mantengan 6-7 sprites nuevos como máximo en este cambio (`pico8.constraint.sprite-count`).

#### Scenario: Identificación visual de tiles
- **WHEN** se inspecciona la hoja de sprites
- **THEN** existen sprites distintos para bosque, hielo, arena y agua
- **THEN** cada sprite es visualmente distinguible de los tiles existentes (ladrillo, metal, bases)
