-- util.lua
-- Funciones puras: aabb_overlap, clamp, snap_sector
-- Verificables con assert en consola de PICO-8

-- detecta solapamiento de dos cajas AABB
-- pico8.api.cos, pico8.api.sin (para el contexto de uso en colisiones)
function ut_aabb_overlap(ax1,ay1,ax2,ay2, bx1,by1,bx2,by2)
 return ax1<bx2 and ax2>bx1 and ay1<by2 and ay2>by1
end

-- limita v al rango [lo,hi]
function ut_clamp(v,lo,hi)
 if v<lo then return lo end
 if v>hi then return hi end
 return v
end

-- convierte un angulo normalizado [0,1) a un sector de 8
-- 0..7, donde 0=derecha, 1=abajo-derecha, 2=abajo, etc.
function ut_snap_sector(a)
 return flr(((a%1)*8)%8)
end

-- verifica de sprites por sector: 4 sprites base + volteos
-- pico8.api.spr, pico8.api.fget
-- sprites: 0=right, 1=down, 2=down-right, 3=up-right
function ut_sprite_for_sector(sector)
 if sector==0 then return 0,false,false end
 if sector==1 then return 2,false,false end
 if sector==2 then return 1,false,false end
 if sector==3 then return 2,true,false end
 if sector==4 then return 0,true,false end
 if sector==5 then return 2,true,true end
 if sector==6 then return 1,false,true end
 return 3,false,true
end
