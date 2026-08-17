-- player.lua
-- Update/draw del tanque del jugador
-- pico8.api.cos, pico8.api.sin, pico8.api.btn, pico8.api.time,
-- pico8.api.spr, pico8.api.line, pico8.api.fget
-- pico8.constraint.display-resolution

pl={}

function pl_init()
 pl.x=PLAYER_X
 pl.y=PLAYER_Y
 pl.body_a=0
 pl.turret_a=0
 pl.speed=0
 pl.lifes=INITIAL_LIFES
 pl.invuln_until=0
 pl.prev_x=pl.x
 pl.prev_y=pl.y
end

function pl_update()
 pl.prev_x=pl.x
 pl.prev_y=pl.y

 -- rotacion: btn(0)=izq, btn(1)=der
 -- pico8.api.btn
 if not btn(4) then
  -- modo normal: rotar cuerpo
  if btn(0) then
   pl.body_a=pl.body_a-ROT_SPEED
  end
  if btn(1) then
   pl.body_a=pl.body_a+ROT_SPEED
  end
  -- cañon sigue al cuerpo
  pl.turret_a=pl.body_a
 else
  -- modo apuntado: rotar solo cañon
  if btn(0) then
   pl.turret_a=pl.turret_a-ROT_SPEED
  end
  if btn(1) then
   pl.turret_a=pl.turret_a+ROT_SPEED
  end
 end

 -- movimiento: btn(2)=adelante, btn(3)=atras
 -- solo en modo normal (sin btn(4))
 if not btn(4) then
  if btn(2) then
   pl.speed=pl.speed+SPEED_ACCEL
  end
  if btn(3) then
   pl.speed=pl.speed-SPEED_ACCEL
  end
  -- friccion
  pl.speed=pl.speed*SPEED_FRICTION
  -- clamp
  pl.speed=ut_clamp(pl.speed,-SPEED_MAX,SPEED_MAX)
 end

 -- integrar movimiento
 -- pico8.api.cos, pico8.api.sin
 local dx=cos(pl.body_a)*pl.speed
 local dy=sin(pl.body_a)*pl.speed
 pl.x=pl.x+dx
 pl.y=pl.y+dy

 -- colision solida con enemigos (antes de clamp de arena)
 local px1=pl.x-COLLISION_INSET
 local py1=pl.y-COLLISION_INSET
 local px2=pl.x+COLLISION_INSET
 local py2=pl.y+COLLISION_INSET
 local hit_enemy=false
 for e in all(enemies) do
  local ex1=e.x-SPR_SIZE/2
  local ey1=e.y-SPR_SIZE/2
  local ex2=e.x+SPR_SIZE/2
  local ey2=e.y+SPR_SIZE/2
  -- deteccion de contacto (ANTES de colision solida)
  if t()>pl.invuln_until and not hit_enemy then
   if ut_aabb_overlap(px1,py1,px2,py2,ex1,ey1,ex2,ey2) then
    gs.game.hits=gs.game.hits+1
    pl.lifes=pl.lifes-1
    pl.invuln_until=t()+INVULN_TIME
    hit_enemy=true
   end
  end
  -- colision solida (empuja jugador hacia atras)
  if ut_aabb_overlap(px1,py1,px2,py2,ex1,ey1,ex2,ey2) then
   pl.x=pl.prev_x
   pl.y=pl.prev_y
  end
 end

 -- clamp a arena 128x128
 -- pico8.constraint.display-resolution
 pl.x=ut_clamp(pl.x,SPR_SIZE/2,127-SPR_SIZE/2)
 pl.y=ut_clamp(pl.y,SPR_SIZE/2,127-SPR_SIZE/2)
end

function pl_draw()
 -- parpadeo por invulnerabilidad
 -- pico8.api.time
 if t()<pl.invuln_until then
  if flr(t()*BLINK_HZ)%2~=0 then
   return
  end
 end

 -- sprite del cuerpo
 -- pico8.api.spr
 spr(SPR_PLAYER,pl.x-SPR_SIZE/2,pl.y-SPR_SIZE/2)

 -- cañon con line() hacia turret_a
 -- pico8.api.line
 local bx=pl.x+cos(pl.turret_a)*BARREL_LEN
 local by=pl.y+sin(pl.turret_a)*BARREL_LEN
 line(pl.x,pl.y,bx,by,COL_DKGREY)
end
