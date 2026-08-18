## Purpose

Renderizado del tanque del jugador: sprite unificado con casco y canon integrado, usando `spr()` con flip para 4 direcciones, posicionamiento preciso del fogonazo en la punta del canon via tabla `MUZZLE`.

## MODIFIED Requirements

### Requirement: Tanque del jugador se dibuja con spr() + flip de 4 direcciones
El tanque del jugador SHALL dibujarse usando `spr()` con `flip_x`/`flip_y`
segun `body_a`. Sprite 0 (canon arriba) se usa para arriba/abajo con
`flip_y` para abajo. Sprite 1 (canon izquierda) se usa para
izquierda/derecha con `flip_x` para derecha. El color 0 SHALL ser
tratado como transparente.

**Tabla de renderizado:**
```
direccion   body_a   sprite   flip_x   flip_y
  ↑ arriba   0.25        0    false    false
  ↓ abajo    0.75        0    false     true
  ← izq      0.5         1    false    false
  → der      0           1     true    false
```

#### Scenario: Dibujado del tanque arriba
- **WHEN** `body_a` es 0.25
- **THEN** se dibuja `spr(0, x-4, y-4)` sin flip

#### Scenario: Dibujado del tanque abajo
- **WHEN** `body_a` es 0.75
- **THEN** se dibuja `spr(0, x-4, y-4, 1,1, false, true)`

#### Scenario: Dibujado del tanque izquierda
- **WHEN** `body_a` es 0.5
- **THEN** se dibuja `spr(1, x-4, y-4)` sin flip

#### Scenario: Dibujado del tanque derecha
- **WHEN** `body_a` es 0
- **THEN** se dibuja `spr(1, x-4, y-4, 1,1, true, false)`

#### Scenario: Sin deformacion de pixels
- **WHEN** el tanque se dibuja en cualquiera de las 4 direcciones
- **THEN** los pixels se dibujan sin deformacion (sprites estaticos)

#### Scenario: Transparencia del color 0
- **WHEN** `spr()` dibuja el sprite
- **THEN** los pixels con color 0 NO se dibujan (son transparentes)

### Requirement: Fogonazo visual al disparar
Al disparar una bala, el sistema SHALL dibujar un efecto visual de fogonazo
en la punta visible del canon integrado. La posicion del fogonazo SHALL
calcularse usando la tabla `MUZZLE` con offsets precalculados por `body_a`.
El fogonazo SHALL ser un circulo pequeno de color brillante.

**Tabla MUZZLE:**
```lua
MUZZLE={[0]={3,0},[0.25]={0,-3.5},[0.5]={-3,0},[0.75]={0,3.5}}
```

#### Scenario: Fogonazo en la punta del canon
- **WHEN** el jugador dispara una bala
- **THEN** aparece un circulo pequeno (radio ~1px) en la posicion
  `MUZZLE[body_a]` relativa al centro del tanque
- **THEN** el color del fogonazo es brillante (color 10)
- **THEN** el fogonazo se extingue automaticamente tras el cooldown

#### Scenario: Sin fogonazo sin disparo
- **WHEN** el jugador no ha disparado recientemente
- **THEN** no se dibuja ningun fogonazo
