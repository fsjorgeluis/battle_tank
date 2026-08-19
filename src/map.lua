-- map.lua
-- Generacion procedural del mapa de juego
-- pico8.api.mget, pico8.api.mset, pico8.api.fget, pico8.api.fset,
-- pico8.api.rnd, pico8.api.flr, pico8.api.abs
-- pico8.constraint.map-size, pico8.constraint.sprite-size,
-- pico8.constraint.display-resolution

-- dimensiones y tiles
MAP_W=16
MAP_H=16
TILE_BRICK=11
TILE_METAL=12
TILE_BASE_ALLY=13
TILE_BASE_ENEMY=14

-- flags de sprite (pico8.api.fget)
FLAG_SOLID=0
FLAG_BREAKABLE=1
FLAG_BASE=2

function map_init()
 -- configurar flags de sprite en runtime
 -- pico8.api.fset
 fset(TILE_BRICK,FLAG_SOLID,true)
 fset(TILE_BRICK,FLAG_BREAKABLE,true)
 fset(TILE_METAL,FLAG_SOLID,true)
 fset(TILE_BASE_ALLY,FLAG_SOLID,true)
 fset(TILE_BASE_ALLY,FLAG_BASE,true)
 fset(TILE_BASE_ENEMY,FLAG_SOLID,true)
 fset(TILE_BASE_ENEMY,FLAG_BASE,true)
end

function map_clear()
 for x=0,MAP_W-1 do
  for y=0,MAP_H-1 do
   mset(x,y,TILE_BRICK)
  end
 end
end

function map_place_base_with_shield(bx,by,s)
 -- zona segura de 4x3 tiles frente a la base
 -- para garantizar que el tanque pueda salir y entrar
 local zx1,zx2=bx-1,bx+2
 local zy1,zy2
 if by<MAP_H/2 then
  -- base enemiga: zona hacia abajo
  zy1,zy2=by,by+2
 else
  -- base aliada: zona hacia arriba
  zy1,zy2=by-2,by
 end
 for x=zx1,zx2 do
  for y=zy1,zy2 do
   if x>=1 and x<MAP_W-1 and y>=1 and y<MAP_H-1 then
    mset(x,y,0)
   end
  end
 end
 -- colocar base
 mset(bx,by,s)
 -- escudo compacto de ladrillos a los lados y retaguardia
 -- apertura frontal de exactamente 2 tiles hacia el campo de batalla
 if by<MAP_H/2 then
  -- base enemiga
  mset(bx-1,by,TILE_BRICK)
  mset(bx+2,by,TILE_BRICK)
  mset(bx-1,by+1,TILE_BRICK)
  mset(bx+2,by+1,TILE_BRICK)
 else
  -- base aliada
  mset(bx-1,by,TILE_BRICK)
  mset(bx+2,by,TILE_BRICK)
  mset(bx-1,by-1,TILE_BRICK)
  mset(bx+2,by-1,TILE_BRICK)
 end
end

function map_place_bases()
 map_place_base_with_shield(7,1,TILE_BASE_ENEMY)
 map_place_base_with_shield(7,14,TILE_BASE_ALLY)
end

function map_recursive_division(x,y,w,h)
 -- algoritmo de division recursiva para laberintos perfectos
 if w<2 or h<2 then return end

 local horizontal
 if w>h then
  horizontal=false
 elseif h>w then
  horizontal=true
 else
  horizontal=rnd(1)>0.5
 end

 if horizontal then
  -- pared horizontal
  local py=flr(rnd(h-1))+y+1
  for px=x,x+w-1 do
   mset(px,py,TILE_BRICK)
  end
  -- abrir una puerta
  local hole=flr(rnd(w))+x
  mset(hole,py,0)
  -- dividir sub-espacios
  map_recursive_division(x,y,w,py-y)
  map_recursive_division(x,py+1,w,h-(py-y)-1)
 else
  -- pared vertical
  local px=flr(rnd(w-1))+x+1
  for py=y,y+h-1 do
   mset(px,py,TILE_BRICK)
  end
  -- abrir una puerta
  local hole=flr(rnd(h))+y
  mset(px,hole,0)
  -- dividir sub-espacios
  map_recursive_division(x,y,px-x,h)
  map_recursive_division(px+1,y,w-(px-x)-1,h)
 end
end

function map_erode_walls(prob)
 -- erosionar paredes internas para crear circuitos y rutas alternativas
 for x=2,MAP_W-3 do
  for y=2,MAP_H-3 do
    if mget(x,y)==TILE_BRICK then
     -- no erosionar cerca de las bases
     local near_base=(x>=6 and x<=9 and y>=1 and y<=3)
      or (x>=6 and x<=9 and y>=12 and y<=14)
     if not near_base and rnd(1)<prob then
     mset(x,y,0)
    end
   end
  end
 end
end

function map_place_metal_border()
 for x=0,MAP_W-1 do
  mset(x,0,TILE_METAL)
  mset(x,MAP_H-1,TILE_METAL)
 end
 for y=0,MAP_H-1 do
  mset(0,y,TILE_METAL)
  mset(MAP_W-1,y,TILE_METAL)
 end
end

function map_scatter_metal(count)
 local placed=0
 local attempts=0
 while placed<count and attempts<1000 do
   local tx=flr(rnd(MAP_W-2))+1
   local ty=flr(rnd(MAP_H-2))+1
   -- evitar zona segura alrededor de cada base
   local near_base=(tx>=6 and tx<=9 and ty>=1 and ty<=3)
    or (tx>=6 and tx<=9 and ty>=12 and ty<=14)
   if not near_base and mget(tx,ty)==TILE_BRICK then
   mset(tx,ty,TILE_METAL)
   placed=placed+1
  end
  attempts=attempts+1
 end
end

function map_ensure_base_connectivity()
 -- garantizar que cada base tenga un camino hacia el laberinto
 -- tallando un corto corredor de 1 tile desde la apertura frontal
 -- base aliada: apertura en y=13, tallar hacia abajo
 for y=11,8,-1 do
  mset(7,y,0)
 end
 -- base enemiga: apertura en y=2, tallar hacia arriba
 for y=4,7 do
  mset(7,y,0)
 end
end

function map_generate()
 map_clear()
 -- dejar borde como ladrillo y limpiar interior
 for x=1,MAP_W-2 do
  for y=1,MAP_H-2 do
   mset(x,y,0)
  end
 end
 -- generar laberinto perfecto por division recursiva
 map_recursive_division(1,1,MAP_W-2,MAP_H-2)
 -- erosionar paredes para crear rutas alternativas
 map_erode_walls(0.10)
 -- colocar bases con escudo de ladrillos (limpia zona segura)
 map_place_bases()
 -- garantizar conexion de cada base con el laberinto
 map_ensure_base_connectivity()
 -- marco de metal irrompible
 map_place_metal_border()
 -- bloques de metal interiores
 map_scatter_metal(flr(rnd(6))+5)
end

-- consulta de colision: true si el tile es solido
function map_is_solid(tx,ty)
 if tx<0 or tx>=MAP_W or ty<0 or ty>=MAP_H then
  return true
 end
 return fget(mget(tx,ty),FLAG_SOLID)
end

-- devuelve tile vacio del borde superior (filas 1 o 2)
function map_find_empty_top_spawn()
 local candidates={}
 for x=1,MAP_W-2 do
  for y=1,2 do
   if mget(x,y)==0 then
    add(candidates,{x,y})
   end
  end
 end
 if #candidates>0 then
  local c=candidates[flr(rnd(#candidates))+1]
  return c[1],c[2]
 end
 -- fallback: posicion segura conocida
 return 7,1
end
