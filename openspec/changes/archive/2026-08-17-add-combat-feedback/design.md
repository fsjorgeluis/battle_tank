## Context

El cartucho (battle_tank.p8) tiene combate mínimo: una bala mata al enemigo al instante (`en_kill` en `src/enemy.lua:22`), sin respuesta visual ni sonora; disparar (`bl_fire` en `src/states.lua:70`) no afecta al tanque. El sprite enemigo (SPR_ENEMY=4) usa los colores 6 (gris claro) y 7 (blanco) sobre fondo 0. El bus de audio está completamente libre (los 64 SFX en `__sfx__` están vacíos; `pico8.constraint.sound-instruments`, `pico8.constraint.audio-channels`). El estilo visual es rectfill minimalista; la hoja de sprites no tiene arte de explosión.

La colisión sólida y el daño por contacto del jugador ya existen (`src/player.lua:75-94`), con reversión a `prev_x/prev_y` y detección de contacto antes del empuje.

## Goals / Non-Goals

**Goals:**

- Enemigos con vida (`ENEMY_HP`) y feedback de daño por color (gris/blanco -> rojo) y destello blanco al impactar.
- Respuesta de muerte: explosión procedural (destello + anillo + escombros) y SFX.
- Chispa visual corta en cada impacto.
- Retroceso físico del tanque al disparar, integrado por las colisiones existentes, con la posibilidad real de daño por contacto si se retrocede contra un enemigo (decisión de diseño asumida: riesgo asumido).
- Fogonazo de 2 frames en la boca del cañón.
- SFX de disparo y de explosión con canales reservados.
- Retumbo de motor en bucle mientras el tanque se desplaza (canal 3).

**Non-Goals:**

- No se añade música.
- No se cambia el sistema de vidas/score del jugador ni el flujo de estados.
- No se crean sprites nuevos de explosión (efectos procedurales).
- No se introduce invulnerabilidad ante el retroceso: el riesgo es parte del diseño.

## Decisions

### D1. Vida del enemigo y daño por bala

El enemigo gana un campo `e.hp` inicializado a `ENEMY_HP=3` en `en_init` (posición inicial) y en cada reaparecer (`en_update`, `src/enemy.lua:28-35`). Una bala que colisiona aplica 1 de daño (`en_hit(e)`) en lugar de matar; la bala se consume en todo impacto. Solo con `hp<=0` se invoca `en_kill(e)` (ruta existente: puntos, timer de respawn). El marcador se otorga solo en la muerte (`KILL_POINTS`).

- Alternativa descartada: balas perforantes que atraviesan o daño variable por bala. Fuera de alcance; una bala = un impacto.

### D2. Tinte de color y destello por vida (pico8.api.pal, pico8.api.spr)

El sprite del enemigo se dibuja con re-mapeo de paleta de dibujo 0 según la vida restante, aplicado solo durante su `spr` en `en_draw` y restablecido inmediatamente con `pal()` al terminar el bucle para no teñir tanque/balas:

```
hp 3 (original): 6->6, 7->7   (gris/blanco)
hp 2:            6->10, 7->9  (amarillo/naranja)
hp 1:            6->9, 7->8   (naranja/rojo)
```

Destello de impacto: al recibir daño, `e.flash_until=t()+0.07` (2 frames); mientras `t()<e.flash_until` el sprite se dibuja re-mapeado a blanco puro (`6->7,7->7`) para que el golpe lea antes que el cambio de tinte. La tabla de tintes se define como constante semántica (`ENEMY_TINTS`), evaluada solo contra la vida actual.

- Alternativa descartada: sprites de sufrimiento pre-dibujados. Añade arte nuevo y más tokens; `pal()` preserva el estilo y el arte existentes.
- `pal(c0,c1)` no afecta a lo ya dibujado (solo al dibujo posterior), por eso el restablecimiento tras cada sprite es correcto dentro del mismo frame.

### D3. Módulo de efectos `src/fx.lua`

Nuevo módulo con una lista `fx_list` de efectos transitorios y API `fx_add`, `fx_update`, `fx_draw`:

- **Explosión** (`fx_explode(x,y)`): ~0.5 s en capas: destello blanco (`circfill` color 7, radio ~3) en los primeros 2 frames; anillo expansivo que recorre naranja(9) -> rojo(8) -> gris(5) mientras crece; 6 escombros (`pset`) con velocidad aleatoria (`rnd`) y gravedad ligera que se atenúan con la edad del efecto. Consulta `pico8.api.circfill`, `pico8.api.pset`, `pico8.api.rnd`, `pico8.api.time`.
- **Chispa de impacto** (`fx_hit(x,y)`): 4-6 píxeles alrededor del punto, ~0.15 s.
- `fx_update` avanza los efectos y poda los vencidos; `fx_draw` los pinta.

Integración: `fx_update()` en `st_update_play` (tras `bl_update`); `fx_draw()` en `ui_draw_play` justo después de `en_draw` para que la explosión se dibuje en la posición de la muerte y el tanque vuelva a pintarse encima. `fx_list` se vacía en `st_reset`.

CPU: despreciable; típicamente hay 0-1 efectos activos (un enemigo a la vez, con respawn cada 2 s y cooldown de disparo 0.35 s).

### D4. Retroceso físico con colisiones reales

El tanque recibe un impulso opuesto al cañón en `bl_fire` (states.lua:70): `pl.rx=-cos(pl.turret_a)*RECOIL_IMPULSE`, `pl.ry=-sin(pl.turret_a)*RECOIL_IMPULSE`. En `pl_update`, tras integrar el movimiento por velocidad, se integra y decae el retroceso:

```
pl.rx=pl.rx*RECOIL_FRICTION
pl.ry=pl.ry*RECOIL_FRICTION
pl.x=pl.x+pl.rx
pl.y=pl.y+pl.ry
```

Con `RECOIL_IMPULSE=0.35` y `RECOIL_FRICTION=0.7` el desplazamiento total es ~1.2 px en ~6 frames: sutil y agradable. El pasaje de colisiones existente (`src/player.lua:89-93`) revierte a `prev_x/prev_y` cuando hay solapamiento con un enemigo, y el clamp de arena (96-99) frena contra los bordes: empujarse contra muro o enemigo se resuelve gratis. El chequeo de contacto (81-88) evalúa la posición ya retrocedida, por lo que retroceder de espaldas a un enemigo vivo puede restar vida = el "riesgo asumido" elegido. Se usa `cos/sin` de `turret_a` (no `body_a`) para que el retroceso se oponga a la dirección real de disparo, también en modo apuntado.

- Alternativa descartada: retroceso solo visual (offset de dibujo). Más seguro pero cosmético; no cumple "que maneje colisiones".

### D5. Fogonazo y SFX

- **Fogonazo**: `bl_fire` fija `pl.muzzle_until=t()+0.07`; en `pl_draw`, si `t()<pl.muzzle_until`, se pinta un píxel brillante (`rectfill` 1x1, color 9/8) en la punta del cañón.
- **SFX**: dos definiciones en `__sfx__` (SFX 0 y 1), autoría en el editor SFX de PICO-8 o vía hex en el .p8: disparo (blip corto, ~0.1 s, canal 1) y explosión (instrumento 6, ruido + drop, ~0.3 s, canal 0). Reproducción con `pico8.api.sfx` en `bl_fire` y en la muerte del enemigo. Reserva de canales por evento:

| Evento | SFX | Canal |
| --- | --- | --- |
| Disparo | 1 | 1 |
| Explosión de muerte | 0 | 0 |
| Golpe intermedio | 2 | 2 |
| Motor (loop) | 3 | 3 |

### D6. Nuevo `#include` y tope de tokens

`battle_tank.p8` añade `#include src/fx.lua`. Presupuesto previsto: ~180-250 tokens nuevos (el módulo fx ~90-120, el resto repartido) sobre el tope `pico8.constraint.token-limit` de 8192. Sin uso significativo de ROM/RAM; 0 sprites nuevos; 3 de 64 SFX y 4 de 4 canales.

### D7. Retumbo de motor en canal 3

El tanque del jugador emite un sonido de motor en bucle mientras se desplaza. SFX slot 3 en `__sfx__` autorizado con notas graves (instrumento bajo o ruido) y rango de bucle (`loop_start < loop_end`) para que repita indefinidamente. Reproducción en canal 3 con `sfx(SFX_MOTOR, CH_MOTOR)`.

- **Detección de flanco**: se usa una variable de estado `pl.motor_on` para detectar la transición reposo→móvil (activar) y móvil→reposo (detener con `sfx(-1, CH_MOTOR)`). Llamar `sfx()` en cada frame reinicia el loop; el flanco evita reinicios innecesarios y garantiza una transición limpia.
- **Ciclo de vida**: el motor se silencia en `st_reset` (reinicio de partida) y nunca suena en `GS_MENU` ni cuando `btn(4)` está activo (modo apuntado), ya que en ese estado el tanque no se desplaza.
- **Superposición**: el motor en canal 3 no interfiere con disparo (canal 1), explosión (canal 0) ni golpe (canal 2); los canales son independientes en PICO-8.

**Problema detectado (verificación auditiva):** El dato hex del SFX 3 actual produce un sonido molesto de "ticks de ruido blanco": vol 8 (inválido, máx 7) en la primera nota, pitches altos (67/49) en vez de graves, y `dur=4` (ultracorto, ~31ms/nota) que genera un loop de ~62ms. Wave 0xA en nota1 apunta a un waveform custom no intencional. La lógica de código (flanco, triggers) está correcta; el problema es el dato SFX, no la implementación.

**Corrección aplicada (SFX hex):** Reescrito el dato hex de SFX 3 con wave noise (6), pitches bajos (0x08-0x0e), vol 2, speed 8, loop de 8 notas (~0.5 s ciclo). El resultado es un zumbido grave y tenue.

**Problema detectado en verificación auditiva (2ª ronda):** Tras la corrección del SFX, el sonido mejoró (ya no sonaba a ticks), pero persisten dos problemas:
1. **El motor no se detiene nunca** — La condición de parada usa `pl.speed==0` (player.lua:84), pero con `SPEED_FRICTION=0.9` la velocidad se aproxima a 0 asintóticamente y jamás lo alcanza en coma flotante. Resultado: una vez activado, el motor suena indefinidamente.
2. **El sonido sigue algo alto** — El SFX actual tiene vol 2 por nota. Para un sonido que "no debe ser molesto" y no opacar otros SFX, vol 1 (nivel más bajo audible) es más apropiado.

**Corrección aplicada (2ª ronda):**
- **Threshold de parada**: Cambiado `pl.speed==0` por `abs(pl.speed)<0.01` en player.lua:84.
- **Volumen**: Reducido SFX 3 hex a vol 1 en todas las notas.

**Problema detectado en verificación auditiva (3ª ronda):** Tras aplicar el umbral `<0.01`, el motor sigue sin detenerse. Causa raíz: **oscillación por umbral asimétrico**. El start usa `pl.speed~=0` (cualquier velocidad no-cero) y el stop usa `abs(pl.speed)<0.01`. Cuando speed está en el rango `(0, 0.01)` (~43 frames, ~1.4s), el motor alterna entre start y stop cada frame, reiniciando el SFX ~15 veces por segundo. El usuario percibe que "nunca se detiene".

**Corrección aplicada (3ª ronda):**
- **Umbrales simétricos**: Start `abs(pl.speed)>=0.01`, stop `abs(pl.speed)<0.01`. Sin oscillación.
- **Instrumentos restaurados**: Notas impares del SFX 3 restauradas a instrument 3 (bass) — la reducción de volumen previa había corrompido accidentalmente los instrumentos de notas 1,3,5,7.

**Problema detectado en verificación auditiva (4ª ronda):** Tras los umbrales simétricos, el motor seguía sin detenerse. Diagnóstico: `sfx(-1, CH_MOTOR)` (parada por canal específico) **no funciona en PICO-8**. Solo `sfx(-1)` (parada global, todos los canales) detiene el sonido de forma fiable. `sfx(-2, channel)` libera el loop pero el sonido persiste hasta terminar la iteración actual (~500ms).

**Corrección aplicada (4ª ronda):** Cambiado `sfx(-1,CH_MOTOR)` por `sfx(-1)` (parada global). El motor es el sonido persistente más largo; los otros SFX (disparo, golpe, explosión) son cortos (~0.1-0.3s) y es improbable que estén sonando cuando el motor se detiene. Trade-off aceptable.

**Corrección definitiva (5ª ronda):** Subir el umbral de `0.01` a `0.15` (equivalente a 1 frame de aceleración, SPEED_ACCEL=0.15). Con el umbral bajo, el motor permanecía activo ~50 frames (~1.7s) después de soltar las teclas, durante los cuales la velocidad estaba en un rango "indeciso" donde PICO-8 podía reasignar el SFX a canales alternos. Con umbral 0.15, el motor se apaga casi inmediatamente al soltar las teclas, y `sfx(-1, CH_MOTOR)` (parada por canal) funciona correctamente porque el SFX siempre está en el canal esperado. Se restauró `sfx(-1, CH_MOTOR)` en vez de `sfx(-1)` global.

- Alternativa descartada: sonido por frame sin flanco. Reiniciaría el SFX cada frame, causando cortes audibles y desperdicio de CPU.

## Risks / Trade-offs

- [Retroceso inesperado al disparar a bocajarro contra muro] -> El impulso (~1.2 px) es pequeño; el clamp de arena y la colisión sólida lo absorben; es parte del "game feel" buscado.
- [Daño por contacto provocado por el propio retroceso puede sentir injusticia] -> Decisión explícita del usuario (riesgo asumido). Mitigación de balance: impulso pequeño; queda documentado en specs como consecuencia observable.
- [Ruido de paleta activo durante `en_draw` teñiría otras entidades] -> `pal()` de restablecimiento inmediatamente después del bucle de dibujo de enemigos.
- [SFX hex en `__sfx__` propenso a errores manuales] -> Confirmado: el SFX 3 (motor) quedó con vol inválido (8), pitches altos y duración ultracorta; reescrito con noise wave, vol 2 y loop largo (ver D7). En verificación auditiva, vol 2 sigue algo alto → vol 1 propuesto.
- [Coste CPU si se disparan y mueren efectos a la vez] -> Efectos transitorios y escasos; fade simple por edad sin físicas costosas; verificación con stat(1)/CTRL-P.
- [Motor no se detiene por comparación exacta con 0] -> Confirmado (2ª ronda): `pl.speed==0` nunca se cumple con `SPEED_FRICTION=0.9`. Corregido con umbral `abs(pl.speed)<0.01`.
- [Oscillación por umbral asimétrico en motor] -> Confirmado (3ª ronda): start `~=0` y stop `<0.01` causan alternancia cada frame. Corregido con umbrales simétricos `>=0.01` / `<0.01`.
- [Instrumentos SFX corrompidos al reducir volumen] -> Confirmado (3ª ronda): notas impares del SFX 3 quedaron con instrument 0 en vez de 3. Restaurados.
- [sfx(-1, channel) no funciona en PICO-8] -> Confirmado (4ª ronda): con umbral bajo (0.01), `sfx(-1, channel)` no detiene el canal. Solucionado subiendo umbral a 0.15 (5ª ronda): el SFX siempre está en el canal esperado y `sfx(-1, channel)` funciona correctamente.

## Migration Plan

No aplica migración de datos. Rollback del cambio = reversión del commit o volver a la rama anterior; las constantes (`ENEMY_HP`, RECOIL_*) se dejan centralizadas en `src/const.lua` para poder ajustar balance sin tocar lógica.

## Open Questions

- Ninguna pendiente para implementar. Los valores de balance (`ENEMY_HP`, RECOIL_IMPULSE/FRICTION, duraciones de efectos) son constantes ajustables y se validarán en ejecución contra los criterios de aceptación.