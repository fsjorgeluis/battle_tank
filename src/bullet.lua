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
 local dir=a
 local m=MUZZLE[dir]
 local bx=x+m[1]
 local by=y+m[2]
 -- tile de spawn: tile del jugador, no del punto de nacimiento de la bala
 -- asi se evita saltar el muro adyacente cuando el tanque dispara pegado
 add(bullets,{x=bx,y=by,vx=cos(dir)*BULLET_SPEED,vy=sin(dir)*BULLET_SPEED,born=t(),sx=flr(x/8),sy=flr(y/8)})
 -- retroceso opuesto a body_a
 pl.rx=-cos(dir)*RECOIL_IMPULSE
 pl.ry=-sin(dir)*RECOIL_IMPULSE
 pl.muzzle_until=t()+0.07
 sfx(SFX_SHOT,CH_SHOT)
end

function bl_update()
 local alive={}
 for b in all(bullets) do
  b.x=b.x+b.vx
  b.y=b.y+b.vy
  -- fuera del mundo jugable (margen BULLET_SIZE)
  if b.x<-BULLET_SIZE or b.x>WORLD_W+BULLET_SIZE
   or b.y<-BULLET_SIZE or b.y>WORLD_H+BULLET_SIZE then
   -- descartar
  elseif t()-b.born>BULLET_LIFE then
   -- timeout
  else
    -- colision bala-tile: tile actual y tile frontal
     local hit=false
     local tiles_to_check={}
     local tx=flr(b.x/8)
     local ty=flr(b.y/8)
     add(tiles_to_check,{tx,ty})
     -- comprobar tile inmediatamente delante segun direccion
     if b.vx>0 then
      add(tiles_to_check,{flr((b.x+3.9)/8),ty})
     elseif b.vx<0 then
      add(tiles_to_check,{flr((b.x-3.9)/8),ty})
     end
     if b.vy>0 then
      add(tiles_to_check,{tx,flr((b.y+3.9)/8)})
     elseif b.vy<0 then
      add(tiles_to_check,{tx,flr((b.y-3.9)/8)})
     end

     for tc in all(tiles_to_check) do
      local ttx,tty=tc[1],tc[2]
      -- ignorar tile de spawn (donde estaba el jugador al disparar)
      if ttx==b.sx and tty==b.sy then
       -- skip
      else
       local tile=mget(ttx,tty)
       if tile~=0 then
        local act=BULLET_TILE_ACT[tile]
        if act==BULLET_PASS then
         -- atraviesa: nada que hacer
        elseif act==BULLET_DESTROY then
         -- destruir ladrillo
         mset(ttx,tty,0)
         hit=true
         break
        elseif act==BULLET_VICTORY then
         st_set_state(GS_VICTORY)
         hit=true
         break
        elseif act==BULLET_GAMEOVER then
         st_set_state(GS_GAMEOVER)
         hit=true
         break
        else
         -- BULLET_BOUNCE u otro valor por defecto
         hit=true
         break
        end
       end
      end
     end
    if not hit then
     -- colision bala-enemigo
     local bx1=b.x-BULLET_SIZE/2
     local by1=b.y-BULLET_SIZE/2
     local bx2=b.x+BULLET_SIZE/2
     local by2=b.y+BULLET_SIZE/2
     for e in all(enemies) do
      local ex1=e.x-SPR_SIZE/2
      local ey1=e.y-SPR_SIZE/2
      local ex2=e.x+SPR_SIZE/2
      local ey2=e.y+SPR_SIZE/2
      if ut_aabb_overlap(bx1,by1,bx2,by2,ex1,ey1,ex2,ey2) then
       fx_hit(e.x,e.y)
       local died=en_hit(e)
       if not died then
        sfx(SFX_HIT,CH_HIT)
       else
        en_kill(e)
        fx_explode(e.x,e.y)
        sfx(SFX_BOOM,CH_BOOM)
       end
       hit=true
       break
      end
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
