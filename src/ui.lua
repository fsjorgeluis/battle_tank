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
 -- desplazar origen del mundo para dejar franja del HUD libre
 -- pico8.api.camera
 camera(0,-HUD_H)
 -- dibujar mapa con paleta del bioma
 -- pico8.api.map, pico8.api.pal
 biome_apply_palette(gs.game.level)
 map(0,0,0,0,16,14)
 biome_reset_palette()
 -- entidades con paleta por defecto
 tr_draw()
 en_draw()
 fx_draw()
 pl_draw()
 bl_draw()
 -- capa de tiles que deben dibujarse sobre entidades (bosque)
 -- pico8.api.spr
 biome_apply_palette(gs.game.level)
 map_draw_overlay()
 biome_reset_palette()
 -- restablecer camara para dibujar HUD en coordenadas de pantalla
 -- pico8.api.camera
 camera(0,0)
 ui_draw_hud()
end

-- HUD: corazones, nivel, toques y puntos
function ui_draw_hud()
 -- pico8.api.spr
 for i=1,pl.lifes do
  spr(SPR_HEART,(i-1)*10,1)
 end
 color(COL_TEXT)
 print("nivel:"..gs.game.level,34,1)
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

-- victoria
function ui_draw_victory()
 cls(COL_BG)
 color(COL_TEXT)
 print("victoria",44,40,11)
 print("base enemiga destruida",18,55,COL_TEXT)
 print("puntos: "..gs.game.score,20,65,COL_TEXT)
 print("x para reintentar",24,80,COL_GREY)
end

-- banner con el nombre del bioma al iniciar nivel
function ui_draw_level_banner(level)
 local name=biome_name(level)
 local x=64-#name*2
 local y=56
 print(name,x+1,y+1,COL_DARK)
 print(name,x,y,COL_TEXT)
end

-- pantalla intermedia de nivel completado
function ui_draw_level_clear()
 ui_draw_play()
 ui_draw_level_banner(gs.game.level+1)
end
