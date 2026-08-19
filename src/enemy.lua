-- enemy.lua
-- Entidad enemiga como lista + respawn
-- pico8.api.spr, pico8.api.all, pico8.api.add, pico8.api.del, pico8.api.time

enemies={}
en={next_respawn=0,last_zone=0}

function en_init()
 enemies={}
 en.next_respawn=0
 en.last_zone=0
 -- spawn inicial en borde superior aleatorio
 local tx,ty=map_find_empty_top_spawn()
 add(enemies,{x=tx*8+4,y=ty*8+4,hp=ENEMY_HP,flash_until=0,dir=0,speed=0})
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
  -- respawn en borde superior aleatorio
  local tx,ty=map_find_empty_top_spawn()
  add(enemies,{x=tx*8+4,y=ty*8+4,hp=ENEMY_HP,flash_until=0,dir=0,speed=0})
 end
 -- emitir rastro para enemigos en movimiento
 for e in all(enemies) do
  tr_emit(e.x,e.y,e.dir,e.speed)
 end
end
