## 1. Preparacion y verificacion de entorno

- [x] 1.1 Verificar que el binario `pico8` esta disponible e invocable desde la terminal (skill pico8-development, seccion "Entorno de ejecucion"); registrar el comando usado para ejecutar el cartucho
- [x] 1.2 Leer `knowledge/index.md` y confirmar que los documentos necesarios para este cambio estan en `status: verified` (`pico8.api.pal`, `pico8.api.spr`, `pico8.api.circfill`, `pico8.api.pset`, `pico8.api.rectfill`, `pico8.api.rnd`, `pico8.api.time`, `pico8.api.sfx`, `pico8.api.line`, `pico8.api.cos`, `pico8.api.sin`; `pico8.constraint.token-limit`, `audio-channels`, `sound-instruments`); registrar cualquier hueco como bloqueo antes de continuar

## 2. Vida del enemigo y dano por bala

- [x] 2.1 En `src/const.lua`, anadir constantes semanticas: `ENEMY_HP=3` (vida maxima), colores de tinte de dano a traves de `ENEMY_TINTS` (remapeo por vida restante sobre los colores 6 y 7 del sprite enemigo), y duracion de destello (p.ej. `ENEMY_FLASH_TIME=0.07`)
- [x] 2.2 En `src/enemy.lua`, crear el campo `hp` en `en_init` (vida completa) y en cada respawn de `en_update` (vida completa); crear `en_hit(e)` que decrementa `e.hp`, marca `e.flash_until=t()+ENEMY_FLASH_TIME` y devuelve si murio
- [x] 2.3 En `src/enemy.lua`, modificar `en_kill(e)` para que solo se invoque cuando `hp<=0` (puntos y timer de respawn existentes) y llamar desde el punto de dano al finalizar la vida
- [x] 2.4 En `src/bullet.lua`, cambiar la colision bala-enemigo de `en_kill(e)` a dano: aplicar `en_hit(e)`, disparar la chispa de impacto (fx_hit), reproducir el SFX de golpe y consumir la bala en todo impacto; si `en_hit` indica muerte, invocar `en_kill(e)` y disparar la explosion (fx_explode) y el SFX de explosion

## 3. Feedback de color del enemigo

- [x] 3.1 En `src/enemy.lua`, modificar `en_draw` para dibujar cada enemigo con re-mapeo de paleta de dibujo (`pico8.api.pal`) segun su vida restante: paleta original con vida maxima, tinte rojizo progresivo con vida menor; destello blanco mientras `t()<e.flash_until`; restaurar `pal()` inmediatamente tras el bucle para no tenir tanque, balas ni HUD
- [x] 3.2 Verificar en el cartucho: al danar un enemigo varias veces, el sprite muestra decrementos de color (gris/blanco -> amarillo/naranja -> naranja/rojo) y un destello blanco por impacto (pico8.api.pal)

## 4. Modulo de efectos visuales (src/fx.lua)

- [x] 4.1 Crear `src/fx.lua` con la lista `fx_list` y la API `fx_init` (vacia la lista), `fx_explode(x,y)`, `fx_hit(x,y)`, `fx_update(dt)` y `fx_draw`; usar `pico8.api.circfill`, `pico8.api.pset`, `pico8.api.rnd` y `pico8.api.time`
- [x] 4.2 Implementar la explosion: destello blanco inicial (~2 frames), anillo expansivo que cambia de naranja(9) a rojo(8) a gris(5), y 6 escombros con velocidad aleatoria y gravedad ligera que se desvanecen; duracion total ~0.5 s
- [x] 4.3 Implementar la chispa de impacto: 4-6 pixeles alrededor del punto, ~0.15 s
- [x] 4.4 Integrar en el bucle: `fx_update()` en `st_update_play` (tras `bl_update`) y `fx_draw()` en `ui_draw_play` justo despues de `en_draw`; limpiar la lista en `st_reset` (reinicio de partida)
- [x] 4.5 Anadir `#include src/fx.lua` en `battle_tank.p8` en el orden de dependencias correcto (tras modules de entidades)
- [x] 4.6 Verificar en el cartucho: al matar un enemigo se ve la explosion completa en su posicion; al impactar sin matar se ve la chispa; al reiniciar partida no quedan restos de efectos

## 5. Retroceso fisico y fogonazo

- [x] 5.1 En `src/const.lua`, anadir `RECOIL_IMPULSE=0.35` y `RECOIL_FRICTION=0.7` (ajustables)
- [x] 5.2 En `src/player.lua`, inicializar `pl.rx=0` y `pl.ry=0` en `pl_init`
- [x] 5.3 En `src/states.lua`, modificar `bl_fire` (disparo) para fijar `pl.rx=-cos(pl.turret_a)*RECOIL_IMPULSE` y `pl.ry=-sin(pl.turret_a)*RECOIL_IMPULSE`, y marcar `pl.muzzle_until=t()+0.07`
- [x] 5.4 En `src/player.lua`, integrar el retroceso en `pl_update` tras el movimiento por velocidad: aplicar `pl.rx=pl.rx*RECOIL_FRICTION`, `pl.ry=pl.ry*RECOIL_FRICTION` y sumar a `pl.x/pl.y` antes del pasaje de colision solida y de contacto existente (asi muros, enemigos y arena lo frenan y el contacto puede restar vida)
- [x] 5.5 En `src/player.lua`, dibujar el fogonazo en `pl_draw`: si `t()<pl.muzzle_until`, pintar un pixel brillante (`rectfill`) en la punta del canon segun `pl.turret_a`
- [x] 5.6 Verificar en el cartucho: disparo con empuje sutil opuesto al canon (tambien en modo apuntado); retroceso bloqueado por borde de arena y por enemigo vivo; contacto con enemigo durante el retroceso puede restar vida; fogonazo visible 2 frames

## 6. Efectos de sonido

- [x] 6.1 Autorar en la seccion `__sfx__` de `battle_tank.p8` (editor SFX de PICO-8 o hex del .p8) los SFX 0 (explosion: instrumento 6, ruido + drop, ~0.3 s) y 1 (disparo: blip corto, ~0.1 s), respetando `pico8.constraint.sound-instruments`; dejar intacto el resto de ranuras
- [x] 6.2 En `src/const.lua`, definir indices y canales: `SFX_SHOT`/`CH_SHOT` (canal 1) y `SFX_BOOM`/`CH_BOOM` (canal 0), mas `SFX_HIT`/`CH_HIT` (golpe intermedio), siguiendo la reserva de canales del diseno (D5)
- [x] 6.3 Reproducir con `pico8.api.sfx` los tres eventos: disparo en `bl_fire`, golpe en el impacto parcial de 2.4 y explosion en la muerte de 2.4, usando cada indice y canal reservado
- [x] 6.4 Verificar en el cartucho: suena un disparo por bala, golpe por impacto parcial y explosion por muerte, en sus canales correspondientes; sin solapamientos audibles extra
- [x] 6.5 En `battle_tank.p8`, reescribir el dato hex de SFX 3 (motor) en `__sfx__`: wave noise (6), pitches bajos (0x6..0xe), vol 1-2, dur 6-8, loop de 6-8 notas (~0.7-1 s ciclo); verificar que el dato alineado produce un ronroneo grave y tenue, no ticks de ruido blanco [REWORK: el dato actual tiene vol 8 (inválido), pitches altos 67/49, dur=4 ultracorto y wave 0xA no intencional; ver D7]
- [x] 6.6 En `src/player.lua`, inicializar `pl.motor_on=false` en `pl_init`; en `pl_update`, implementar deteccion de flanco: si `pl.speed > 0` y `not pl.motor_on`, activar `sfx(SFX_MOTOR, CH_MOTOR)` y marcar `pl.motor_on=true`; si `pl.speed <= 0` y `pl.motor_on`, detener `sfx(-1, CH_MOTOR)` y marcar `pl.motor_on=false`; en `st_reset` (src/states.lua), agregar `sfx(-1, CH_MOTOR)` y resetear `pl.motor_on=false` [REWORK: la condicion `pl.speed==0` nunca se cumple con SPEED_FRICTION=0.9 — ver task 6.8]
- [x] 6.7 Verificar en el cartucho: el motor suena al moverse y se detiene al quedarse quieto; no suena en menú ni en modo apuntado; se silencia al reiniciar partida; no interfiere con disparo/golpe/explosión
- [x] 6.8 En `src/player.lua:84`, cambiar la condicion de parada del motor de `pl.speed==0` a `abs(pl.speed)<0.01` (umbral de velocidad muerta); verificar que el motor se apaga al dejar de moverse [REWORK: comprobado que SPEED_FRICTION=0.9 hace que speed se aproxime a 0 asintoticamente sin alcanzarlo; ver D7]
- [x] 6.9 En `battle_tank.p8`, reducir el volumen del SFX 3 (motor) de vol 2 a vol 1 en todas las notas del dato hex (field bits 8-9 = 01); el nivel más bajo audible en PICO-8, suficiente para comunicar movimiento sin molestar [REWORK: verificado que vol 2 sigue algo alto en prueba auditiva; ver D7]
- [x] 6.10 En `src/player.lua:81`, cambiar la condicion de inicio del motor de `pl.speed~=0` a `abs(pl.speed)>=0.01` (umbral simétrico con el stop); la asimetría previa causaba oscillación start/stop cada frame en el rango (0,0.01) durante ~1.4s, reiniciando el SFX ~15Hz y percibiéndose como "nunca se detiene"; también restaurar instrumentos 3 (bass) en notas impares del SFX 3 en `battle_tank.p8:40` (corrompidos al reducir volumen en 6.9)
- [x] 6.11 En `src/player.lua:85`, subir umbral de parada del motor de `0.01` a `0.15` (= SPEED_ACCEL, 1 frame de aceleración) y restaurar `sfx(-1,CH_MOTOR)` (parada por canal); con umbral bajo el motor permanecía activo ~50 frames en rango "indeciso" donde PICO-8 reasignaba el SFX a canales alternos; con umbral 0.15 el SFX siempre está en el canal esperado y la parada por canal funciona

## 7. Presupuestos, regresion y cierre

- [x] 7.1 Verificar presupuestos: `info` de PICO-8 para tokens (tope `pico8.constraint.token-limit` de 8192), chars y compressed — Tokens: 2097/8192 (25.6%), Chars: 12748/65535 (19.5%), Compressed: 4690/15616 (30%) — todos dentro del previsto
- [x] 7.2 Regresion: ejecutar el cartucho y comprobar comportamiento previo intacto (menu, movimiento, apuntado, vidas, contact damage, score solo en muerte, respawn con vida completa, reinicio de cartucho) — verificado por el usuario
- [x] 7.3 Revisar que los comentarios tecnicos y el cierre referencien los IDs de conocimiento verificados usados y que no haya afirmaciones sin fuente; reportar documentacion consultada, restricciones comprobadas y limitaciones no verificables en el entorno