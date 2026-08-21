-- biome.lua
-- Datos y funciones de biomas
-- pico8.api.pal, pico8.api.rnd, pico8.api.flr, pico8.api.all

-- 8 biomas con pesos de revestimiento y mapeo sutil de paleta
BIOMES={
 {
  name="pradera",
  tiles={
   empty={{0,60},{TILE_FOREST,20},{TILE_ICE,5},{TILE_SAND,15}},
   solid={{TILE_BRICK,80},{TILE_WATER,20}}
  },
  palette={{4,9},{3,11}}
 },
 {
  name="bosque",
  tiles={
   empty={{0,30},{TILE_FOREST,50},{TILE_ICE,5},{TILE_SAND,15}},
   solid={{TILE_BRICK,70},{TILE_WATER,30}}
  },
  palette={{3,11},{4,5}}
 },
 {
  name="tundra",
  tiles={
   empty={{0,40},{TILE_FOREST,10},{TILE_ICE,40},{TILE_SAND,10}},
   solid={{TILE_BRICK,70},{TILE_WATER,30}}
  },
  palette={{7,6},{12,1}}
 },
 {
  name="desierto",
  tiles={
   empty={{0,30},{TILE_FOREST,5},{TILE_ICE,5},{TILE_SAND,60}},
   solid={{TILE_BRICK,60},{TILE_WATER,40}}
  },
  palette={{4,9},{5,4}}
 },
 {
  name="pantano",
  tiles={
   empty={{0,20},{TILE_FOREST,40},{TILE_ICE,5},{TILE_SAND,25}},
   solid={{TILE_BRICK,50},{TILE_WATER,50}}
  },
  palette={{11,3},{6,5}}
 },
 {
  name="helado",
  tiles={
   empty={{0,30},{TILE_FOREST,5},{TILE_ICE,50},{TILE_SAND,15}},
   solid={{TILE_BRICK,60},{TILE_WATER,40}}
  },
  palette={{7,12},{6,7}}
 },
 {
  name="volcanico",
  tiles={
   empty={{0,20},{TILE_FOREST,10},{TILE_ICE,0},{TILE_SAND,20}},
   solid={{TILE_BRICK,40},{TILE_WATER,60}}
  },
  palette={{4,8},{9,8}}
 },
 {
  name="ruinas",
  tiles={
   empty={{0,30},{TILE_FOREST,10},{TILE_ICE,10},{TILE_SAND,30}},
   solid={{TILE_BRICK,30},{TILE_WATER,70}}
  },
  palette={{6,5},{5,6}}
 }
}

-- cantidad de enemigos por oleada para cada nivel
LEVEL_WAVES={1,2,2,3,3,4,4,5}

-- elige un tile segun pesos: tabla de {tile,peso}
function biome_pick_tile(weights)
 local total=0
 for i=1,#weights do
  total=total+weights[i][2]
 end
 local r=rnd(total)
 for i=1,#weights do
  r=r-weights[i][2]
  if r<0 then return weights[i][1] end
 end
 return weights[1][1]
end

-- aplica el revestimiento del bioma sobre el laberinto base
function biome_dress(level)
 local b=BIOMES[level]
 if not b then return end
 for x=1,MAP_W-2 do
  for y=1,MAP_H-2 do
   if not map_is_base_zone(x,y) then
    local t=mget(x,y)
    if t==0 then
     mset(x,y,biome_pick_tile(b.tiles.empty))
    elseif t==TILE_BRICK then
     mset(x,y,biome_pick_tile(b.tiles.solid))
    end
   end
  end
 end
end

-- aplica la paleta del bioma al mundo
function biome_apply_palette(level)
 local b=BIOMES[level]
 if not b then return end
 for p in all(b.palette) do
  pal(p[1],p[2])
 end
end

-- restaura la paleta por defecto antes de entidades/hud
function biome_reset_palette()
 pal()
end

-- nombre del bioma para el banner
function biome_name(level)
 local b=BIOMES[level]
 return b and b.name or "???"
end
