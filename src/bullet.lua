-- bullet.lua
-- Módulo de balas del jugador
-- pico8.api.cos, pico8.api.sin, pico8.api.add, pico8.api.del, pico8.api.all,
-- pico8.api.rectfill, pico8.api.time

bl={}
bullets={}

function bl_init()
 bullets={}
 bl.cooldown_until=0
end

function bl_fire(x,y,a)
 if t()<bl.cooldown_until then return end
 bl.cooldown_until=t()+FIRE_COOLDOWN
 local bx=x+cos(a)*BARREL_LEN
 local by=y+sin(a)*BARREL_LEN
 add(bullets,{x=bx,y=by,vx=cos(a)*BULLET_SPEED,vy=sin(a)*BULLET_SPEED,born=t()})
end

function bl_update()
 local alive={}
 for b in all(bullets) do
  b.x=b.x+b.vx
  b.y=b.y+b.vy
  -- fuera de arena (margen BULLET_SIZE)
  if b.x<-BULLET_SIZE or b.x>127+BULLET_SIZE
   or b.y<-BULLET_SIZE or b.y>127+BULLET_SIZE then
   -- descartar
  elseif t()-b.born>BULLET_LIFE then
   -- timeout
  else
   -- colisión bala-enemigo
   local bx1=b.x-BULLET_SIZE/2
   local by1=b.y-BULLET_SIZE/2
   local bx2=b.x+BULLET_SIZE/2
   local by2=b.y+BULLET_SIZE/2
   local hit=false
   for e in all(enemies) do
    local ex1=e.x-SPR_SIZE/2
    local ey1=e.y-SPR_SIZE/2
    local ex2=e.x+SPR_SIZE/2
    local ey2=e.y+SPR_SIZE/2
    if ut_aabb_overlap(bx1,by1,bx2,by2,ex1,ey1,ex2,ey2) then
     en_kill(e)
     hit=true
     break
    end
   end
   if not hit then
    add(alive,b)
   end
  end
 end
 bullets=alive
end

function bl_draw()
 for b in all(bullets) do
  -- pico8.api.rectfill
  rectfill(b.x-BULLET_SIZE/2,b.y-BULLET_SIZE/2,
           b.x+BULLET_SIZE/2,b.y+BULLET_SIZE/2,BULLET_COL)
 end
end
