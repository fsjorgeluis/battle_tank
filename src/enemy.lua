-- enemy.lua
-- Entidad enemiga estatica
-- pico8.api.spr

en={}

function en_init()
 en.x=ENEMY_X
 en.y=ENEMY_Y
end

function en_draw()
 -- pico8.api.spr
 spr(SPR_ENEMY,en.x-SPR_SIZE/2,en.y-SPR_SIZE/2)
end

-- en_update no hace nada: el enemigo es estatico
function en_update()
end
