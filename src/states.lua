-- states.lua
-- Maquina de estados global minima
-- pico8.concept.game-loop, pico8.api.btn, pico8.api.btnp

gs={state=GS_MENU,game=nil}

function st_init()
 gs.state=GS_MENU
 gs.game={menu_sel=1,hits=0,score=0}
end

function st_set_state(newstate)
 gs.state=newstate
end

function st_reset()
 pl_init()
 en_init()
 bl_init()
 gs.game.score=0
 gs.state=GS_PLAY
end

function st_update()
 if gs.state==GS_MENU then
  st_update_menu()
 elseif gs.state==GS_PLAY then
  st_update_play()
 elseif gs.state==GS_GAMEOVER then
  st_update_gameover()
 end
end

function st_draw()
 if gs.state==GS_MENU then
  ui_draw_menu()
 elseif gs.state==GS_PLAY then
  ui_draw_play()
 elseif gs.state==GS_GAMEOVER then
  ui_draw_gameover()
 end
end

-- menu
function st_update_menu()
 if btnp(2) then
  gs.game.menu_sel=gs.game.menu_sel-1
  if gs.game.menu_sel<1 then gs.game.menu_sel=2 end
 end
 if btnp(3) then
  gs.game.menu_sel=gs.game.menu_sel+1
  if gs.game.menu_sel>2 then gs.game.menu_sel=1 end
 end
 if btnp(5) then
  if gs.game.menu_sel==1 then
   st_reset()
  else
   -- pico8.api.stop
   stop()
  end
 end
end

-- partida
function st_update_play()
 pl_update()
 en_update()
 bl_update()
 -- disparo con X (btnp(5))
 if btnp(5) then
  bl_fire(pl.x,pl.y,pl.turret_a)
 end
 -- comprobar gameover
 if pl.lifes<=0 then
  st_set_state(GS_GAMEOVER)
 end
end

-- game over
function st_update_gameover()
 if btnp(5) then
  st_reset()
 end
end
