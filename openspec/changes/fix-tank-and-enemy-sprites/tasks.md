## 1. Actualización de Constantes

- [x] 1.1 Verificar `SPR_SIZE` en `src/const.lua` (mantenido en 8)

## 2. Rediseño de Sprites del Jugador

- [x] 2.1 Diseñar sprite del jugador (índice 0) - 8x8 píxeles, forma rectangular, colores oscuros
- [x] 2.2 Copiar sprite del jugador (índice 1) - para rotación
- [x] 2.3 Copiar sprite del jugador (índice 2) - para rotación
- [x] 2.4 Copiar sprite del jugador (índice 3) - para rotación

## 3. Creación de Sprites del Enemigo

- [x] 3.1 Diseñar sprite del enemigo (índice 4) - 8x8 píxeles, mismo diseño que jugador, colores claros
- [x] 3.2 Copiar sprite del enemigo (índice 5) - para rotación
- [x] 3.3 Copiar sprite del enemigo (índice 6) - para rotación
- [x] 3.4 Copiar sprite del enemigo (índice 7) - para rotación

## 4. Ajuste de Posicionamiento

- [x] 4.1 Verificar que `src/player.lua` usa correctamente `SPR_SIZE` para centrar sprite
- [x] 4.2 Verificar que `src/enemy.lua` usa correctamente `SPR_SIZE` para centrar sprite
- [x] 4.3 Verificar `COLLISION_INSET` para el tamaño actual

## 5. Verificación

- [x] 5.1 Ejecutar en PICO-8 y verificar que el tanque del jugador se ve rectangular
- [x] 5.2 Ejecutar en PICO-8 y verificar que el enemigo es visible con colores diferentes
- [x] 5.3 Probar colisiones y movimiento para asegurar que funciona correctamente
- [x] 5.4 Verificar que el cañón sigue funcionando como `line()`
