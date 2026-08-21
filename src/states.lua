-- states.lua
-- Maquina de estados global minima
-- pico8.concept.game-loop, pico8.api.btn, pico8.api.btnp

gs={state=GS_MENU,game=nil}

function st_init()
 gs.state=GS_MENU
 gs.game={menu_sel=1,hits=0,score=0,level=1,level_clear_timer=0}
end

function st_set_state(newstate)
 gs.state=newstate
end

function st_reset()
 gs.game.level=1
 gs.game.score=0
 gs.game.hits=0
 map_generate(gs.game.level)
 map_place_test_tiles()
 tr_init()
 pl_init()
 en_init(gs.game.level)
 bl_init()
 fx_init()
 sfx(-1,CH_MOTOR)
 gs.state=GS_PLAY
end

function st_update()
 if gs.state==GS_MENU then
  st_update_menu()
 elseif gs.state==GS_PLAY then
  st_update_play()
 elseif gs.state==GS_LEVEL_CLEAR then
  st_update_level_clear()
 elseif gs.state==GS_GAMEOVER then
  st_update_gameover()
 elseif gs.state==GS_VICTORY then
  st_update_victory()
 end
end

function st_draw()
 if gs.state==GS_MENU then
  ui_draw_menu()
 elseif gs.state==GS_PLAY then
  ui_draw_play()
 elseif gs.state==GS_LEVEL_CLEAR then
  ui_draw_level_clear()
 elseif gs.state==GS_GAMEOVER then
  ui_draw_gameover()
 elseif gs.state==GS_VICTORY then
  ui_draw_victory()
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
 fx_update()
 tr_update()
 if gs.state==GS_PLAY then
  -- disparo con X (btnp(5))
  if btnp(5) then
   bl_fire(pl.x,pl.y,pl.body_a)
  end
  -- avance de nivel: oleada vacia o base enemiga destruida
  if #enemies==0 then
   st_set_state(GS_LEVEL_CLEAR)
   gs.game.level_clear_timer=60
  elseif pl.lifes<=0 then
   st_set_state(GS_GAMEOVER)
  end
 end
end

-- game over
function st_update_gameover()
 if btnp(5) then
  st_reset()
 end
end

-- victoria
function st_update_victory()
 if btnp(5) then
  st_reset()
 end
end

-- transicion al siguiente nivel
function st_next_level()
 local old_lifes=pl.lifes
 local old_score=gs.game.score
 gs.game.level=gs.game.level+1
 gs.game.hits=0
 map_generate(gs.game.level)
 map_place_test_tiles()
 tr_init()
 pl_init()
 en_init(gs.game.level)
 bl_init()
 fx_init()
 pl.lifes=old_lifes
 gs.game.score=old_score
 st_set_state(GS_PLAY)
end

-- nivel completado: banner y avance
function st_update_level_clear()
 -- asegurar timer al entrar desde destruccion de base
 if gs.game.level_clear_timer<=0 then
  gs.game.level_clear_timer=60
 end
 gs.game.level_clear_timer=gs.game.level_clear_timer-1
 if btnp(5) or gs.game.level_clear_timer<=0 then
  if gs.game.level==8 then
   st_set_state(GS_VICTORY)
  else
   st_next_level()
  end
 end
end
