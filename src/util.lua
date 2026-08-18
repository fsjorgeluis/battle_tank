-- util.lua
-- Funciones puras: aabb_overlap, clamp
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