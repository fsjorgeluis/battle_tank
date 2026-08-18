## Context

El sprite 0 del jugador es un tanque unificado con canon integrado mirando
hacia arriba en la hoja de sprites. Se necesita un modelo de control donde
cada flecha apunta Y mueve en esa direccion (modelo 4-direcciones), no el
modelo previo de "rotar + acelerar".

**Conversion de angulos PICO-8:**
```
         0.25 (arriba)
           ↑
           |
0.5 ←─────+─────→ 0.0 (derecha)
           |
           ↓
         0.75 (abajo)
```

**Mapeo de flechas (PICO-8: btn(2)=↑, btn(3)=↓):**
```
← (btn0) → body_a = 0.5  (izquierda)
→ (btn1) → body_a = 0    (derecha)
↑ (btn2) → body_a = 0.25 (arriba)
↓ (btn3) → body_a = 0.75 (abajo)
```

**Sprites y flip:**
```
sprite 0 (arriba)        sprite 1 (izquierda)
  ...BB...               ........
  ...BB...               ..111111
  .131131.               ..333333
  .13BB31.               BB1BB331
  .13BB31.               BB1BB331
  .133331.               ..333333
  .133331.               ..111111
  .131131.               ........
```

**APIs PICO-8 relevantes:**
- `spr(n,x,y,1,1,flip_x,flip_y)` — dibuja sprite con flip horizontal/vertical
  (pico8.api.spr)
- `cos(a)` / `sin(a)` — trigonometria con 0..1, Y invertida
  (pico8.api.cos, pico8.api.sin)

## Goals / Non-Goals

**Goals:**
- Modelo 4-direcciones: flechas = direccion cardinal fija
- Renderizado con `spr()` + flip (sin `ut_rspr`, sin rotacion de pixels)
- Aceleracion con inercia (aceleracion + friccion)
- Fogonazo con tabla `MUZZLE` precalculada
- Eliminar variables obsoletas: `turret_a`, `TURRET_OFFSET`, `ROT_SPEED`,
  `BARREL_LEN`

**Non-Goals:**
- Cambiar el diseno del sprite
- Modificar el enemigo
- Rotacion suave a grados arbitrarios
- Movimiento diagonal
- 8 direcciones o rotacion libre

## Decisions

### D1: Modelo 4-direcciones

**Decision:** Cada flecha establece `body_a` directamente a la direccion
cardinal correspondiente. Sin snapping intermedio — la direccion es la
tecla presionada.

**Razon:** El modelo "rotar + acelerar" no produce "presionar derecha → ir
a la derecha". Con 4 direcciones fijas, el control es intuitivo y directo.

### D2: Renderizado con spr() + flip

**Decision:** Usar dos sprites estaticos con `spr()` y flip en vez de
`ut_rspr()` con rotacion de pixels.

```
direccion   body_a   sprite   spr(...,flip_x,flip_y)
  ↑ arriba   0.25        0      spr(0, x-4, y-4)
  ↓ abajo    0.75        0      spr(0, x-4, y-4, 1,1, false, true)
  ← izq      0.5         1      spr(1, x-4, y-4)
  → der      0           1      spr(1, x-4, y-4, 1,1, true, false)
```

**Razon:** Elimina `ut_rspr()` (64 sget/pset por frame → desaparece). Cero
trigonometria en renderizado. Sprites sin deformacion de pixels. `spr()` ya
se usa por todo el codigo.

### D3: Sin modo apuntado

**Decision:** btn(4) ya no tiene funcion. El canon siempre sigue la
direccion del cuerpo. Se elimina `turret_a`.

**Razon:** En el modelo 4-direcciones, el canon ya apunta donde se mueve.
El modo apuntado era necesario en el modelo "rotar + acelerar" pero no
tiene sentido aqui.

### D4: Aceleracion con inercia

**Decision:** Mantener aceleracion (`SPEED_ACCEL`) y friccion (`SPEED_FRICTION`).
Sin tecla → fricciona hacia 0. Con tecla → acumula velocidad.

**Razon:** El usuario prefirio mantener inercia en vez de movimiento
instantaneo. La transicion entre direcciones es suave.

### D5: Fogonazo con tabla MUZZLE

**Decision:** Tabla precalculada `MUZZLE` con offsets por `body_a`:

```lua
MUZZLE={[0]={3,0},[0.25]={0,-3.5},[0.5]={-3,0},[0.75]={0,3.5}}
```

Offsets derivados de la geometria real de cada sprite:
- Arriba/abajo: `(0, ±3.5)` — sprite 0 (canon centrado)
- Izquierda/derecha: `(±3, 0)` — sprite 1 (canon en columnas 0-1)

**Razon:** Coordenadas polares con `cos/sin*BARREL_LEN` eran incorrectas
por la orientacion invertida de `sin` en PICO-8. La tabla elimina
trigonometria del fogonazo y del spawn de bala.

## Risks / Trade-offs

- **[Sin diagonales]** → El jugador no puede moverse en diagonal.
  Mitigacion: decision intencional para control simple.

- **[Sin retroceso]** → ↓ es "abajo", no "atras". Mitigacion: el jugador
  puede girar y avanzar en cualquier direccion.

- **[4 direcciones fijas]** → Sin rotacion libre ni 8 direcciones.
  Mitigacion: suficiente para el diseno actual; se puede extender despues
  si es necesario.

## Open Questions

Ninguno.
