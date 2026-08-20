## MODIFIED Requirements

### Requirement: Rotación y desplazamiento del tanque
El tanque del jugador SHALL estar definido por una posicion (x, y), un angulo de cuerpo (`body_a`) y un vector de velocidad (`vx`, `vy`). El sprite del tanque SHALL ser unico sprite de 8x8 pixeles que incluye el canon integrado, con dos sprites en la hoja: sprite 0 (canon arriba) y sprite 1 (canon izquierda). El sprite SHALL dibujarse con `spr()` usando `flip_x`/`flip_y` segun `body_a` (ver spec `player-rendering`). La direccion del canon y el sprite siguen determinadas por `body_a`, mientras que el movimiento SHALL estar gobernado por el vector de velocidad (`vx`, `vy`) calculado con `cos()` y `sin()` de `body_a` al acelerar. Cada flecha SHALL establecer `body_a` directamente a la direccion cardinal correspondiente. Sin retroceso (↓ no es "atras").

**Mapeo de flechas (PICO-8: btn(2)=↑, btn(3)=↓):**
```
← (btn0) → body_a = 0.5  (izquierda)
→ (btn1) → body_a = 0    (derecha)
↑ (btn2) → body_a = 0.25 (arriba)
↓ (btn3) → body_a = 0.75 (abajo)
```

#### Scenario: Establecer direccion cardinal
- **WHEN** se presiona una flecha
- **THEN** `body_a` se establece directamente a la direccion cardinal correspondiente
- **THEN** la aceleración se aplica al vector de velocidad en esa dirección

#### Scenario: Sin rotacion a diagonales
- **WHEN** el jugador presiona una flecha
- **THEN** el cuerpo solo apunta en 4 direcciones fijas (arriba, derecha, abajo, izquierda), sin angulos intermedios

#### Scenario: Acelerar en la direccion
- **WHEN** se mantiene una flecha presionada
- **THEN** el tanque acelera en la direccion de `body_a` agregando al vector de velocidad
- **THEN** la aceleración efectiva puede verse reducida si el tile bajo el tanque es de arena

#### Scenario: Sin retroceso
- **WHEN** se presiona ↓ (abajo)
- **THEN** el tanque se mueve hacia abajo, NO retrocede sobre el mismo eje

#### Scenario: Sin entrada
- **WHEN** no se presiona ninguna flecha
- **THEN** el vector de velocidad se reduce por fricción
- **THEN** sobre hielo la fricción es menor y el tanque desliza más distancia

#### Scenario: Sprite unificado del tanque
- **WHEN** se inspecciona la hoja de sprites del cartucho
- **THEN** el tanque del jugador ocupa dos sprites: sprite 0 (canon arriba) y sprite 1 (canon izquierda)

#### Scenario: Deslizamiento independiente del cañón
- **WHEN** el tanque desliza sobre hielo con velocidad hacia la derecha
- **THEN** el jugador puede presionar ↑ para apuntar el cañón arriba
- **THEN** el cañón apunta arriba mientras el cuerpo sigue deslizando hacia la derecha

### Requirement: Límites de la arena y colisión con tiles sólidos
El tanque SHALL quedar contenido dentro del area de juego y no SHALL atravesar tiles sólidos del mapa (ladrillo, metal, bases y agua). Al alcanzar un borde o un tile sólido, el tanque SHALL detenerse sin traspasarlo y solo podra separarse del borde o del tile rotando o invirtiendo la marcha. Al colisionar con un sólido, el vector de velocidad SHALL anularse para evitar quedar atascado.

#### Scenario: Los cuatro bordes
- **WHEN** el tanque intenta salir por cualquiera de los cuatro bordes de la arena
- **THEN** se detiene en el borde correspondiente sin traspasarlo

#### Scenario: Colisión con ladrillo
- **WHEN** el tanque se mueve hacia un tile de ladrillo
- **THEN** el tanque se detiene antes de ocupar ese tile

#### Scenario: Colisión con metal
- **WHEN** el tanque se mueve hacia un tile de metal
- **THEN** el tanque se detiene antes de ocupar ese tile

#### Scenario: Colisión con base
- **WHEN** el tanque se mueve hacia un tile de base
- **THEN** el tanque se detiene antes de ocupar ese tile

#### Scenario: Colisión con agua
- **WHEN** el tanque se mueve hacia un tile de agua
- **THEN** el tanque se detiene antes de ocupar ese tile
- **THEN** el vector de velocidad se anula

#### Scenario: Choque contra muro durante deslizamiento
- **WHEN** el tanque desliza sobre hielo e impacta un muro sólido
- **THEN** el tanque no atraviesa el muro
- **THEN** el tanque deja de deslizar
