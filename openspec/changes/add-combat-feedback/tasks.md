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
- [ ] 3.2 Verificar en el cartucho: al danar un enemigo varias veces, el sprite muestra decrementos de color (gris/blanco -> amarillo/naranja -> naranja/rojo) y un destello blanco por impacto (pico8.api.pal) [PENDIENTE: requiere verificacion interactiva visual/auditiva en PICO-8]

## 4. Modulo de efectos visuales (src/fx.lua)

- [x] 4.1 Crear `src/fx.lua` con la lista `fx_list` y la API `fx_init` (vacia la lista), `fx_explode(x,y)`, `fx_hit(x,y)`, `fx_update(dt)` y `fx_draw`; usar `pico8.api.circfill`, `pico8.api.pset`, `pico8.api.rnd` y `pico8.api.time`
- [x] 4.2 Implementar la explosion: destello blanco inicial (~2 frames), anillo expansivo que cambia de naranja(9) a rojo(8) a gris(5), y 6 escombros con velocidad aleatoria y gravedad ligera que se desvanecen; duracion total ~0.5 s
- [x] 4.3 Implementar la chispa de impacto: 4-6 pixeles alrededor del punto, ~0.15 s
- [x] 4.4 Integrar en el bucle: `fx_update()` en `st_update_play` (tras `bl_update`) y `fx_draw()` en `ui_draw_play` justo despues de `en_draw`; limpiar la lista en `st_reset` (reinicio de partida)
- [x] 4.5 Anadir `#include src/fx.lua` en `battle_tank.p8` en el orden de dependencias correcto (tras modules de entidades)
- [ ] 4.6 Verificar en el cartucho: al matar un enemigo se ve la explosion completa en su posicion; al impactar sin matar se ve la chispa; al reiniciar partida no quedan restos de efectos [PENDIENTE: requiere verificacion interactiva visual/auditiva en PICO-8]

## 5. Retroceso fisico y fogonazo

- [x] 5.1 En `src/const.lua`, anadir `RECOIL_IMPULSE=0.35` y `RECOIL_FRICTION=0.7` (ajustables)
- [x] 5.2 En `src/player.lua`, inicializar `pl.rx=0` y `pl.ry=0` en `pl_init`
- [x] 5.3 En `src/states.lua`, modificar `bl_fire` (disparo) para fijar `pl.rx=-cos(pl.turret_a)*RECOIL_IMPULSE` y `pl.ry=-sin(pl.turret_a)*RECOIL_IMPULSE`, y marcar `pl.muzzle_until=t()+0.07`
- [x] 5.4 En `src/player.lua`, integrar el retroceso en `pl_update` tras el movimiento por velocidad: aplicar `pl.rx=pl.rx*RECOIL_FRICTION`, `pl.ry=pl.ry*RECOIL_FRICTION` y sumar a `pl.x/pl.y` antes del pasaje de colision solida y de contacto existente (asi muros, enemigos y arena lo frenan y el contacto puede restar vida)
- [x] 5.5 En `src/player.lua`, dibujar el fogonazo en `pl_draw`: si `t()<pl.muzzle_until`, pintar un pixel brillante (`rectfill`) en la punta del canon segun `pl.turret_a`
- [ ] 5.6 Verificar en el cartucho: disparo con empuje sutil opuesto al canon (tambien en modo apuntado); retroceso bloqueado por borde de arena y por enemigo vivo; contacto con enemigo durante el retroceso puede restar vida; fogonazo visible 2 frames [PENDIENTE: requiere verificacion interactiva visual/auditiva en PICO-8]

## 6. Efectos de sonido

- [x] 6.1 Autorar en la seccion `__sfx__` de `battle_tank.p8` (editor SFX de PICO-8 o hex del .p8) los SFX 0 (explosion: instrumento 6, ruido + drop, ~0.3 s) y 1 (disparo: blip corto, ~0.1 s), respetando `pico8.constraint.sound-instruments`; dejar intacto el resto de ranuras
- [x] 6.2 En `src/const.lua`, definir indices y canales: `SFX_SHOT`/`CH_SHOT` (canal 1) y `SFX_BOOM`/`CH_BOOM` (canal 0), mas `SFX_HIT`/`CH_HIT` (golpe intermedio), siguiendo la reserva de canales del diseno (D5)
- [x] 6.3 Reproducir con `pico8.api.sfx` los tres eventos: disparo en `bl_fire`, golpe en el impacto parcial de 2.4 y explosion en la muerte de 2.4, usando cada indice y canal reservado
- [ ] 6.4 Verificar en el cartucho: suena un disparo por bala, golpe por impacto parcial y explosion por muerte, en sus canales correspondientes; sin solapamientos audibles extra [PENDIENTE: requiere verificacion interactiva visual/auditiva en PICO-8]

## 7. Presupuestos, regresion y cierre

- [ ] 7.1 Verificar presupuestos: `info` de PICO-8 para tokens (tope `pico8.constraint.token-limit` de 8192, incremento dentro del previsto) y stat(1)/CTRL-P para CPU por frame con efectos activos e inactivos [PENDIENTE: requiere verificacion interactiva visual/auditiva en PICO-8]
- [ ] 7.2 Regresion: ejecutar el cartucho y comprobar comportamiento previo intacto (menu, movimiento, apuntado, vidas, contact damage, score solo en muerte, respawn con vida completa, reinicio de cartucho) [PARCIAL: el cartucho carga y corre sin errores en headless `pico8 -x`; el resto de la regresion requiere juego interactivo]
- [x] 7.3 Revisar que los comentarios tecnicos y el cierre referencien los IDs de conocimiento verificados usados y que no haya afirmaciones sin fuente; reportar documentacion consultada, restricciones comprobadas y limitaciones no verificables en el entorno