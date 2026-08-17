-- probe.p8
-- Carga battle_tank.p8 y vuelca los primeros bytes de sfx 0..2 desde base RAM
-- pico8.api.load, pico8.api.peek, pico8.api.printh, pico8.api.stop
-- pico8.concept.memory-layout
function _init()
 load("battle_tank.p8")
 local hx="0123456789abcdef"
 for i=0,2 do
  local base=0x3200+i*68
  local s=""
  for j=0,15 do
   local b=peek(base+j)
   s=s..sub(hx,flr(b/16)+1,flr(b/16)+1)..sub(hx,(b%16)+1,(b%16)+1)
  end
  printh("SFX"..i.."="..s)
 end
 stop()
end