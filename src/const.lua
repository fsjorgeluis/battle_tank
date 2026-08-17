-- const.lua
-- Constantes semanticas del juego
-- pico8.constraint.display-resolution, pico8.constraint.palette-color-count,
-- pico8.constraint.controller-button-count

-- estados
GS_MENU=1
GS_PLAY=2
GS_GAMEOVER=3

-- colores
COL_BG=0
COL_TEXT=7
COL_DARK=1
COL_RED=8
COL_GREY=6
COL_DKGREY=5

-- movimiento
SPEED_MAX=1.5
SPEED_ACCEL=0.15
SPEED_FRICTION=0.9
ROT_SPEED=0.03

-- invulnerabilidad
BLINK_HZ=8
INVULN_TIME=3.0

-- vida
INITIAL_LIFES=3

-- sprites (indices en la hoja)
SPR_PLAYER=0
SPR_ENEMY=4
SPR_HEART=8

-- posiciones iniciales
PLAYER_X=16
PLAYER_Y=64
ENEMY_X=104
ENEMY_Y=64

-- tamano del sprite
SPR_SIZE=8

-- inset de colision del jugador (perdon al jugador)
COLLISION_INSET=2

-- tamano de cañon
BARREL_LEN=6

-- disparo
BULLET_SPEED=4
BULLET_SIZE=2
BULLET_LIFE=2.0
FIRE_COOLDOWN=0.35
KILL_POINTS=100
RESPAWN_TIME=2.0
BULLET_COL=10

-- zonas de respawn enemigo
ENEMY_ZONES={
 {x=104,y=32},
 {x=32,y=104},
 {x=104,y=104},
 {x=32,y=32}
}
