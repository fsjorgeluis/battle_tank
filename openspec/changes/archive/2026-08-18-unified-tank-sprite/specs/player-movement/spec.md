## MODIFIED Requirements

### Requirement: Rotación y desplazamiento del tanque
El tanque del jugador SHALL estar definido por una posicion (x, y) y un angulo
de cuerpo (`body_a`). El sprite del tanque SHALL ser unico sprite de 8x8
pixeles que incluye el canon integrado, con dos sprites en la hoja: sprite 0
(canon arriba) y sprite 1 (canon izquierda). El sprite SHALL dibujarse con
`spr()` usando `flip_x`/`flip_y` segun `body_a` (ver spec `player-rendering`).
La direccion de movimiento SHALL calcularse con `body_a` directo (sin offset).
Cada flecha SHALL establecer `body_a` directamente a la direccion cardinal
correspondiente. Sin retroceso (↓ no es "atras").

**Mapeo de flechas (PICO-8: btn(2)=↑, btn(3)=↓):**
```
← (btn0) → body_a = 0.5  (izquierda)
→ (btn1) → body_a = 0    (derecha)
↑ (btn2) → body_a = 0.25 (arriba)
↓ (btn3) → body_a = 0.75 (abajo)
```

#### Scenario: Establecer direccion cardinal
- **WHEN** se presiona una flecha
- **THEN** `body_a` se establece directamente a la direccion cardinal
  correspondiente

#### Scenario: Sin rotacion a diagonales
- **WHEN** el jugador presiona una flecha
- **THEN** el cuerpo solo apunta en 4 direcciones fijas (arriba, derecha,
  abajo, izquierda), sin angulos intermedios

#### Scenario: Acelerar en la direccion
- **WHEN** se mantiene una flecha presionada
- **THEN** el tanque acelera en la direccion de `body_a` con inercia
  (aceleracion + friccion)

#### Scenario: Sin retroceso
- **WHEN** se presiona ↓ (abajo)
- **THEN** el tanque se mueve hacia abajo, NO retrocede sobre el mismo eje

#### Scenario: Sin entrada
- **WHEN** no se presiona ninguna flecha
- **THEN** el tanque frena suavemente por friccion, conservando posicion

#### Scenario: Sprite unificado del tanque
- **WHEN** se inspecciona la hoja de sprites del cartucho
- **THEN** el tanque del jugador ocupa dos sprites: sprite 0 (canon arriba)
  y sprite 1 (canon izquierda)

### Requirement: Límites de la arena
El tanque SHALL quedar contenido dentro del area de juego de la pantalla
completa (128x128). Al alcanzar un borde, el tanque SHALL detenerse sin
salirse del area y solo podra separarse del borde rotando o invirtiendo la
marcha.

#### Scenario: Los cuatro bordes
- **WHEN** el tanque intenta salir por cualquiera de los cuatro bordes de la
  arena
- **THEN** se detiene en el borde correspondiente sin traspasarlo
