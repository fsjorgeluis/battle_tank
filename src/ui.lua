-- ui.lua
-- HUD, menu, game over
-- pico8.api.print, pico8.api.cls, pico8.api.color, pico8.api.spr,
-- pico8.api.btnp, pico8.api.stop
-- pico8.constraint.display-resolution, pico8.constraint.palette-color-count

-- menu
function ui_draw_menu()
 cls(COL_BG)
 color(COL_TEXT)
 print("battle tank",40,30,COL_RED)
 print("jugar",52,60,COL_TEXT)
 print("salir",52,75,COL_TEXT)
 -- cursor de seleccion
 local cy=58
 if gs.game.menu_sel==2 then cy=73 end
 print(">",44,cy,COL_RED)
end

-- HUD en partida
function ui_draw_play()
 cls(COL_BG)
 en_draw()
 pl_draw()
 bl_draw()
 ui_draw_hud()
end

-- HUD: corazones, toques y puntos
function ui_draw_hud()
 -- pico8.api.spr
 for i=1,pl.lifes do
  spr(SPR_HEART,(i-1)*10,1)
 end
 color(COL_TEXT)
 print("toques:"..gs.game.hits,60,1)
 print("puntos:"..gs.game.score,60,9)
end

-- game over
function ui_draw_gameover()
 cls(COL_BG)
 color(COL_TEXT)
 print("game over",40,40,COL_RED)
 print("toques recibidos: "..gs.game.hits,20,55,COL_TEXT)
 print("puntos: "..gs.game.score,20,65,COL_TEXT)
 print("x para reintentar",24,80,COL_GREY)
end
