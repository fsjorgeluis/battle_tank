## Context

El juego actualmente usa sprites de 8x8 píxeles para el tanque del jugador y el enemigo. El sprite del enemigo (índice 4) está completamente vacío (todos ceros), making it invisible. El sprite del jugador es demasiado pequeño y no se visualiza como un tanque rectangular. Se necesitarediseñar ambos sprites a 12x10 píxeles para mejor visualización.

## Goals / Non-Goals

**Goals:**
- Crear sprites de 12x10 píxeles para jugador y enemigo
- Hacer visible el sprite del enemigo (corregir bug)
- Mantener el cañón como `line()` existente
- Actualizar constante `SPR_SIZE` de 8 a 12

**Non-Goals:**
- Cambiar la lógica de movimiento o colisión
- Agregar animaciones o efectos especiales
- Modificar el sistema de colisiones existente

## Decisions

### 1. Tamaño de sprite: 12x10 píxeles
**Decisión**: Usar sprites de 12x10 píxeles (ancho x alto)
**Razón**: 12 píxeles de ancho permite un cuerpo rectangular visible, 10 píxeles de alto mantiene proporciones de tanque. Es un tamaño intermedio entre 8x8 (demasiado pequeño) y 16x16 (demasiado grande para 128x128).
**Alternativa considerada**: 16x12 - descartado por ocupar demasiado espacio en pantalla.

### 2. Sprites por sector: 4 sprites base + volteos
**Decisión**: Mantener el sistema actual de 4 sprites base (0-3) con flip flags para 8 direcciones
**Razón**: Eficiente en uso de sprites (solo 4 sprites por entidad) y compatible con el código existente de `ut_sprite_for_sector()`.
**Sprites necesarios**:
- Jugador: 4 sprites (índices 0-3) para rotaciones
- Enemigo: 4 sprites (índices 4-7) para rotaciones (mismo diseño, diferente color)

### 3. Enemigo: mismo sprite, diferente color
**Decisión**: Usar el mismo diseño de sprite que el jugador pero con colores diferentes
**Razón**: Simplifica el diseño inicial. El jugador usa colores oscuros (azul/morado), el enemigo usará colores claros (gris/blanco) para diferenciar visualmente.

### 4. Actualización de constantes
**Decisión**: Actualizar `SPR_SIZE` de 8 a 12 en `src/const.lua`
**Razón**: La constante controla el tamaño de dibujo y colisión. Debe coincidir con el nuevo tamaño de sprite.

## Risks / Trade-offs

### Riesgo 1: Colisiones más grandes
**Riesgo**: Sprites más grandes = colisiones más grandes = más fácil chocar
**Mitigación**: Ajustar `COLLISION_INSET` si es necesario para mantener la misma "sensación" de colisión

### Riesgo 2: Sprites comparten espacio con mapa
**Riesgo**: Los sprites 0-7 están en la zona de sprites dedicados, pero 12x10 requiere más espacio
**Mitigación**: Los sprites de 12x10 caben en la zona de sprites (128 sprites de 8x8 = 1024 píxeles de ancho). Los sprites 0-3 (jugador) y 4-7 (enemigo) usan 16 bytes de ancho total.

### Riesgo 3: Posicionamiento de dibujo
**Riesgo**: El código actual usa `pl.x-SPR_SIZE/2` para centrar el sprite
**Mitigación**: Con SPR_SIZE=12, el offset será -6 píxeles (correcto para 12x10)

## Migration Plan

1. Actualizar `src/const.lua`: `SPR_SIZE=12`
2. Rediseñar sprites en `__gfx__`:
   - Sprites 0-3: jugador (12x10, colores oscuros)
   - Sprites 4-7: enemigo (12x10, colores claros)
3. Verificar que `ut_sprite_for_sector()` funciona con nuevos sprites
4. Probar colisiones y ajustar `COLLISION_INSET` si es necesario
5. Ejecutar en PICO-8 para validar visualización

## Open Questions

- ¿Necesitamos ajustar `COLLISION_INSET` para el nuevo tamaño?
- ¿Los sprites de 12x10 requieren cambios en `ut_sprite_for_sector()`?
- ¿Cómo afecta el cambio al presupuesto de tokens?
