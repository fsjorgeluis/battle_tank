-- player.lua
-- Update/draw del tanque del jugador (modelo 4-direcciones)
-- pico8.api.cos, pico8.api.sin, pico8.api.btn, pico8.api.time,
-- pico8.api.spr, pico8.api.circfill
-- pico8.constraint.display-resolution

pl={}

function pl_init()
 -- spawn dos tiles por encima de la base aliada
 -- pico8.constraint.sprite-size
 pl.x=BASE_ALLY_X*8+4
 pl.y=12*8+4
 pl.body_a=0
 pl.speed=0
 pl.lifes=INITIAL_LIFES
 pl.invuln_until=0
 pl.prev_x=pl.x
 pl.prev_y=pl.y
 pl.rx=0
 pl.ry=0
 pl.muzzle_until=0
 pl.motor_on=false
end

-- comprueba si el movimiento a (x,y) entra en un tile solido nuevo
-- permite salir de un tile solido en el que ya se este (spawn sobre base)
function pl_enters_solid(x,y)
 local x1=x-COLLISION_INSET
 local y1=y-COLLISION_INSET
 local x2=x+COLLISION_INSET
 local y2=y+COLLISION_INSET
 local px1=pl.prev_x-COLLISION_INSET
 local py1=pl.prev_y-COLLISION_INSET
 local px2=pl.prev_x+COLLISION_INSET
 local py2=pl.prev_y+COLLISION_INSET
 local tx1=flr(x1/8)
 local ty1=flr(y1/8)
 local tx2=flr(x2/8)
 local ty2=flr(y2/8)
 local ptx1=flr(px1/8)
 local pty1=flr(py1/8)
 local ptx2=flr(px2/8)
 local pty2=flr(py2/8)
 for tx=tx1,tx2 do
  for ty=ty1,ty2 do
   if map_is_solid(tx,ty) then
    -- solo bloquea si este tile solido no estaba ya cubierto
    if tx<ptx1 or tx>ptx2 or ty<pty1 or ty>pty2 then
     return true
    end
   end
  end
 end
 return false
end

function pl_update()
 pl.prev_x=pl.x
 pl.prev_y=pl.y

 -- direccion: flechas → angulo + aceleracion
 -- prioridad: primera flecha detectada gana
 -- pico8.api.btn
 local dir=nil
 if btn(0) then dir=0.5    -- izquierda
 elseif btn(1) then dir=0   -- derecha
 elseif btn(2) then dir=0.25 -- arriba
 elseif btn(3) then dir=0.75 -- abajo
 end

 if dir then
  pl.body_a=dir
  pl.speed=pl.speed+SPEED_ACCEL
 else
  -- sin tecla: friccion
  pl.speed=pl.speed*SPEED_FRICTION
 end
 pl.speed=ut_clamp(pl.speed,0,SPEED_MAX)

 -- integrar movimiento
 -- pico8.api.cos, pico8.api.sin
 local dx=cos(pl.body_a)*pl.speed
 local dy=sin(pl.body_a)*pl.speed
 pl.x=pl.x+dx
 pl.y=pl.y+dy

 -- integrar retroceso
 pl.rx=pl.rx*RECOIL_FRICTION
 pl.ry=pl.ry*RECOIL_FRICTION
 pl.x=pl.x+pl.rx
 pl.y=pl.y+pl.ry

 -- motor: deteccion de flanco
 -- pico8.api.sfx
 if pl.speed>=0.15 and not pl.motor_on then
  sfx(SFX_MOTOR,CH_MOTOR)
  pl.motor_on=true
 elseif pl.speed<0.15 and pl.motor_on then
  sfx(-1,CH_MOTOR)
  pl.motor_on=false
 end

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

 -- colision con tiles solidos (ladrillo, metal, bases)
 if pl_enters_solid(pl.x,pl.y) then
  pl.x=pl.prev_x
  pl.y=pl.prev_y
 end

 -- clamp a arena 128x128
 -- pico8.constraint.display-resolution
 pl.x=ut_clamp(pl.x,SPR_SIZE/2,127-SPR_SIZE/2)
 pl.y=ut_clamp(pl.y,SPR_SIZE/2,127-SPR_SIZE/2)

 -- emitir rastro de orugas segun velocidad real
 -- pico8.concept.game-loop
 tr_emit(pl.x,pl.y,pl.body_a,pl.speed)
end

function pl_draw()
 -- parpadeo por invulnerabilidad
 -- pico8.api.time
 if t()<pl.invuln_until then
  if flr(t()*BLINK_HZ)%2~=0 then
   return
  end
 end

 -- sprite del cuerpo con flip segun body_a
 -- pico8.api.spr
 local sx=pl.x-SPR_SIZE/2
 local sy=pl.y-SPR_SIZE/2
 if pl.body_a==0.25 then
  -- arriba: sprite 0 sin flip
  spr(0,sx,sy)
 elseif pl.body_a==0.75 then
  -- abajo: sprite 0 con flip_y
  spr(0,sx,sy,1,1,false,true)
 elseif pl.body_a==0.5 then
  -- izquierda: sprite 1 sin flip
  spr(SPR_PLAYER_FLAT,sx,sy)
 else
  -- derecha (body_a==0): sprite 1 con flip_x
  spr(SPR_PLAYER_FLAT,sx,sy,1,1,true,false)
 end

 -- fogonazo: punta del canon con tabla MUZZLE
 -- pico8.api.circfill
 if t()<pl.muzzle_until then
  local m=MUZZLE[pl.body_a]
  if m then
   circfill(pl.x+m[1],pl.y+m[2],1,10)
  end
 end
end
