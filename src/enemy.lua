-- enemy.lua
-- Entidad enemiga como lista + respawn
-- pico8.api.spr, pico8.api.all, pico8.api.add, pico8.api.del, pico8.api.time

enemies={}
en={next_respawn=0,last_zone=0}

function en_init()
 enemies={}
 en.next_respawn=0
 en.last_zone=0
 add(enemies,{x=ENEMY_X,y=ENEMY_Y,hp=ENEMY_HP,flash_until=0})
end

function en_hit(e)
 e.hp=e.hp-1
 e.flash_until=t()+ENEMY_FLASH_TIME
 return e.hp<=0
end

function en_draw()
 for e in all(enemies) do
  -- pico8.api.pal: re-mapeo de paleta segun vida restante (pares src,dst)
  local tints=ENEMY_TINTS[e.hp] or ENEMY_TINTS[1]
  pal(tints[1],tints[2])
  pal(tints[3],tints[4])
  -- destello blanco si recien impactado
  if t()<e.flash_until then
   pal(6,7)
   pal(7,7)
  end
  -- pico8.api.spr
  spr(SPR_ENEMY,e.x-SPR_SIZE/2,e.y-SPR_SIZE/2)
 end
 -- restaurar paleta para no tenir otras entidades
 pal()
end

function en_kill(e)
 del(enemies,e)
 gs.game.score=gs.game.score+KILL_POINTS
 en.next_respawn=t()+RESPAWN_TIME
end

function en_update()
 if #enemies==0 and t()>=en.next_respawn then
  -- zona distinta de la anterior (índice circular determinista)
  local zi=(en.last_zone)%#ENEMY_ZONES+1
  en.last_zone=zi
  local z=ENEMY_ZONES[zi]
  add(enemies,{x=z.x,y=z.y,hp=ENEMY_HP,flash_until=0})
 end
end
