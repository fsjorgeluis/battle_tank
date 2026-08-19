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

-- posiciones de bases; valores por defecto para _init() previo a map_generate()
BASE_ENEMY_X=7
BASE_ALLY_X=7

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

function map_is_base_zone(tx,ty)
 return (tx>=BASE_ENEMY_X-1 and tx<=BASE_ENEMY_X+1 and ty>=1 and ty<=2)
     or (tx>=BASE_ALLY_X-1 and tx<=BASE_ALLY_X+1 and ty>=13 and ty<=14)
end

function map_place_base_with_shield(bx,by,s)
 -- colocar base
 mset(bx,by,s)
 -- determinar frente segun hemisferio
 local front_y
 if by<MAP_H/2 then
  front_y=by+1
 else
  front_y=by-1
 end
 -- coloca ladrillo o metal si toca el borde del mapa
 local function place_wall(x,y)
  if x>=1 and x<=14 and y>=1 and y<=14 then
   if x==1 or x==14 then
    mset(x,y,TILE_METAL)
   else
    mset(x,y,TILE_BRICK)
   end
  end
 end
 -- paredes laterales
 place_wall(bx-1,by)
 place_wall(bx+1,by)
 -- muro frontal completo
 for x=bx-1,bx+1 do
  place_wall(x,front_y)
 end
end

function map_place_bases()
 map_place_base_with_shield(BASE_ENEMY_X,1,TILE_BASE_ENEMY)
 map_place_base_with_shield(BASE_ALLY_X,14,TILE_BASE_ALLY)
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
  local placed=false
  for px=x,x+w-1 do
   if not map_is_base_zone(px,py) then
    mset(px,py,TILE_BRICK)
    placed=true
   end
  end
  -- abrir una puerta fuera de zona de base
  if placed then
   local hole
   repeat
    hole=flr(rnd(w))+x
   until not map_is_base_zone(hole,py)
   mset(hole,py,0)
  end
  -- dividir sub-espacios
  map_recursive_division(x,y,w,py-y)
  map_recursive_division(x,py+1,w,h-(py-y)-1)
 else
  -- pared vertical
  local px=flr(rnd(w-1))+x+1
  local placed=false
  for py=y,y+h-1 do
   if not map_is_base_zone(px,py) then
    mset(px,py,TILE_BRICK)
    placed=true
   end
  end
  -- abrir una puerta fuera de zona de base
  if placed then
   local hole
   repeat
    hole=flr(rnd(h))+y
   until not map_is_base_zone(px,hole)
   mset(px,hole,0)
  end
  -- dividir sub-espacios
  map_recursive_division(x,y,px-x,h)
  map_recursive_division(px+1,y,w-(px-x)-1,h)
 end
end

function map_erode_walls(prob)
 -- erosionar paredes internas para crear circuitos y rutas alternativas
 for x=2,MAP_W-3 do
  for y=2,MAP_H-3 do
   if mget(x,y)==TILE_BRICK and not map_is_base_zone(x,y) and rnd(1)<prob then
    mset(x,y,0)
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
  if not map_is_base_zone(tx,ty) and mget(tx,ty)==TILE_BRICK then
   mset(tx,ty,TILE_METAL)
   placed=placed+1
  end
  attempts=attempts+1
 end
end

function map_check_connectivity()
 -- bfs ligero desde spawn aliado hasta vecindad de base enemiga
 -- pico8.api.add, pico8.api.abs
 local v={}
 local q={{BASE_ALLY_X,12}}
 v[BASE_ALLY_X*16+12]=true
 local head=1
 while head<=#q do
  local c=q[head]
  head= head + 1
  local x,y=c[1],c[2]
  -- distancia chebyshev <=2 de la base enemiga (y<=3)
  if abs(x-BASE_ENEMY_X)<=2 and y<=3 then
   return true
  end
  for dx=-1,1 do
   for dy=-1,1 do
    if dx~=0 or dy~=0 then
     local nx,ny=x+dx,y+dy
     local k=nx*16+ny
     if nx>=1 and nx<=14 and ny>=1 and ny<=14 and not v[k] and mget(nx,ny)==0 then
      v[k]=true
      add(q,{nx,ny})
     end
    end
   end
  end
 end
 return false
end

function map_generate()
 local attempts=0
 repeat
  BASE_ENEMY_X=flr(rnd(12))+2
  BASE_ALLY_X=flr(rnd(12))+2
  map_clear()
  -- dejar borde como ladrillo y limpiar interior
  for x=1,MAP_W-2 do
   for y=1,MAP_H-2 do
    mset(x,y,0)
   end
  end
  -- generar laberinto perfecto respetando zonas de base
  map_recursive_division(1,1,MAP_W-2,MAP_H-2)
  -- erosionar paredes para crear rutas alternativas
  map_erode_walls(0.10)
  -- colocar bases en camaras 3x2 selladas
  map_place_bases()
  -- asegurar espacio de spawn del jugador frente a la base aliada
  mset(BASE_ALLY_X-1,12,0)
  mset(BASE_ALLY_X,12,0)
  mset(BASE_ALLY_X+1,12,0)
  -- marco de metal irrompible
  map_place_metal_border()
  -- bloques de metal interiores
  map_scatter_metal(flr(rnd(6))+5)
  attempts= attempts + 1
 until map_check_connectivity() or attempts>=10
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
   if mget(x,y)==0 and not map_is_base_zone(x,y) then
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
