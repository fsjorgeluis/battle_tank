-- track.lua
-- Rastro de orugas para entidades moviles
-- pico8.api.add, pico8.api.deli, pico8.api.rnd, pico8.api.pset
-- pico8.concept.game-loop

tracks={}

TRACK_COLOR=5
TRACK_LIFE=15
TRACK_SPEED_THRESHOLD=0.2
TRACK_TREAD_OFFSET=3
TRACK_TREAD_OFFSET_IN=2

function tr_init()
 tracks={}
end

function tr_emit(x,y,dir,speed)
 if speed<TRACK_SPEED_THRESHOLD then return end
 -- los sprites de tanque tienen las orugas desplazadas -3/+2 px
 -- respecto al centro logico por el dibujo a pixel entero de 8x8
 local ox1,oy1,ox2,oy2=0,0,0,0
 if dir==0 then      -- derecha
  oy1,oy2=-TRACK_TREAD_OFFSET,TRACK_TREAD_OFFSET_IN
 elseif dir==0.5 then -- izquierda
  oy1,oy2=-TRACK_TREAD_OFFSET,TRACK_TREAD_OFFSET_IN
 elseif dir==0.25 then -- arriba
  ox1,ox2=-TRACK_TREAD_OFFSET,TRACK_TREAD_OFFSET_IN
 elseif dir==0.75 then -- abajo
  ox1,ox2=-TRACK_TREAD_OFFSET,TRACK_TREAD_OFFSET_IN
 end
 add(tracks,{x=x+ox1,y=y+oy1,life=TRACK_LIFE,max_life=TRACK_LIFE})
 add(tracks,{x=x+ox2,y=y+oy2,life=TRACK_LIFE,max_life=TRACK_LIFE})
end

function tr_update()
 for i=#tracks,1,-1 do
  local p=tracks[i]
  p.life=p.life-1
  if p.life<=0 then
   deli(tracks,i)
  end
 end
end

function tr_draw()
 for p in all(tracks) do
  if rnd(1)<p.life/p.max_life then
   pset(p.x,p.y,TRACK_COLOR)
  end
 end
end
