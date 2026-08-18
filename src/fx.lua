-- fx.lua
-- Efectos visuales transitorios: explosion e impacto
-- pico8.api.circfill, pico8.api.pset, pico8.api.rnd, pico8.api.time

fx_list={}

function fx_init()
 fx_list={}
end

function fx_explode(x,y)
 add(fx_list,{
  type="explode",
  x=x,y=y,
  born=t(),
  dur=0.5,
  debris={}
 })
 -- generar 6 escombros con velocidad aleatoria
 for i=1,6 do
  local a=rnd(1)
  local sp=rnd(1.5)+0.5
  add(fx_list[#fx_list].debris,{
   x=x,y=y,
   vx=cos(a)*sp,
   vy=sin(a)*sp-0.5,
   life=0.5
  })
 end
end

function fx_hit(x,y)
 add(fx_list,{
  type="hit",
  x=x,y=y,
  born=t(),
  dur=0.15,
  particles={}
 })
 -- generar 4-6 pixeles alrededor del punto
 for i=1,4+flr(rnd(3)) do
  local a=rnd(1)
  local d=rnd(2)
  add(fx_list[#fx_list].particles,{
   dx=cos(a)*d,
   dy=sin(a)*d
  })
 end
end

function fx_update()
 local alive={}
 for f in all(fx_list) do
  local age=t()-f.born
  if age>=f.dur then
   -- podar efecto vencido
  elseif f.type=="explode" then
   -- actualizar escombros
   for d in all(f.debris) do
    d.x=d.x+d.vx
    d.y=d.y+d.vy
    d.vy=d.vy+0.08 -- gravedad ligera
   end
   add(alive,f)
  else
   add(alive,f)
  end
 end
 fx_list=alive
end

function fx_draw()
 for f in all(fx_list) do
  local age=t()-f.born
  local progress=age/f.dur
  if f.type=="explode" then
   -- destello blanco inicial (~2 primeros frames = 0.07s)
   if age<0.07 then
    circfill(f.x,f.y,3,7)
   else
    -- anillo expansivo: naranja(9) -> rojo(8) -> gris(5)
    local r=3+progress*8
    local c=9
    if progress>0.4 then c=8 end
    if progress>0.7 then c=5 end
    circfill(f.x,f.y,r,c)
    -- escombros
    for d in all(f.debris) do
     local alpha=1-progress
     if alpha>0 then
      pset(d.x,d.y,8)
     end
    end
   end
  elseif f.type=="hit" then
   -- chispa: pixeles alrededor del punto
   for p in all(f.particles) do
    pset(f.x+p.dx,f.y+p.dy,7)
   end
  end
 end
end
