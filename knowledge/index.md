# Índice de conocimiento PICO-8

Mapa de recuperación de la base generada desde `sources/pico8-manual-v0.2.7.html`
(SHA-256 `057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a`).

## Límites

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.constraint.token-limit` | constraint | Máximo de 8192 tokens de código | verified | `knowledge/constraints/token-limit.md` |
| `pico8.constraint.cpu-clock` | constraint | Velocidad de CPU virtual de 8 MHz | verified | `knowledge/constraints/cpu-clock.md` |
| `pico8.constraint.cpu-cycles-per-instruction` | constraint | ~2 ciclos por instrucción de VM | verified | `knowledge/constraints/cpu-cycles-per-instruction.md` |
| `pico8.constraint.cpu-throughput` | constraint | 4M instrucciones de VM por segundo | verified | `knowledge/constraints/cpu-throughput.md` |
| `pico8.constraint.controller-button-count` | constraint | 6 botones por controlador | verified | `knowledge/constraints/controller-button-count.md` |
| `pico8.constraint.number-precision` | constraint | Paso mínimo ~0.00002 entre números | verified | `knowledge/constraints/number-precision.md` |
| `pico8.constraint.number-min` | constraint | Mínimo de número: -32768 | verified | `knowledge/constraints/number-min.md` |
| `pico8.constraint.number-max` | constraint | Máximo de número: ~32767.99999 | verified | `knowledge/constraints/number-max.md` |
| `pico8.constraint.display-resolution` | constraint | Pantalla fija de 128x128 píxeles | verified | `knowledge/constraints/display-resolution.md` |
| `pico8.constraint.palette-color-count` | constraint | Paleta fija de 16 colores | verified | `knowledge/constraints/palette-color-count.md` |
| `pico8.constraint.sprite-count` | constraint | Banco dedicado de 128 sprites | verified | `knowledge/constraints/sprite-count.md` |
| `pico8.constraint.sprite-shared-count` | constraint | 128 sprites compartidos con el mapa | verified | `knowledge/constraints/sprite-shared-count.md` |
| `pico8.constraint.sprite-size` | constraint | Sprite de 8x8 píxeles | verified | `knowledge/constraints/sprite-size.md` |
| `pico8.constraint.sprite-sheet-size` | constraint | Hoja de sprites de 128x128 píxeles | verified | `knowledge/constraints/sprite-sheet-size.md` |
| `pico8.constraint.audio-channels` | constraint | Bus de audio de 4 canales fijos | verified | `knowledge/constraints/audio-channels.md` |
| `pico8.constraint.sound-instruments` | constraint | 64 definiciones de sonido (sfx) | verified | `knowledge/constraints/sound-instruments.md` |
| `pico8.constraint.map-size` | constraint | Cuadrícula de mapa por defecto de 128x32 tiles | verified | `knowledge/constraints/map-size.md` |
| `pico8.constraint.map-shared-size` | constraint | Mapa de 128x64 tiles con memoria compartida | verified | `knowledge/constraints/map-shared-size.md` |
| `pico8.constraint.map-cell-width` | constraint | Celda de mapa de 8 bits (1 byte por tile) | verified | `knowledge/constraints/map-cell-width.md` |
| `pico8.constraint.tline-fraction-bits` | constraint | 13 bits fraccionarios por defecto en TLINE | verified | `knowledge/constraints/tline-fraction-bits.md` |
| `pico8.constraint.ram-size` | constraint | RAM base de 64k | verified | `knowledge/constraints/ram-size.md` |
| `pico8.constraint.cart-rom-size` | constraint | Cart ROM de 32k | verified | `knowledge/constraints/cart-rom-size.md` |
| `pico8.constraint.lua-ram-size` | constraint | Lua RAM de 2MB | verified | `knowledge/constraints/lua-ram-size.md` |
| `pico8.constraint.persistent-cart-data-size` | constraint | 256 bytes de datos persistentes de cartucho | verified | `knowledge/constraints/persistent-cart-data-size.md` |
| `pico8.constraint.screen-buffer-size` | constraint | Buffer de pantalla de 8k en 0x6000 | verified | `knowledge/constraints/screen-buffer-size.md` |
| `pico8.constraint.peek-result-max` | constraint | PEEK devuelve como máximo 8192 resultados | verified | `knowledge/constraints/peek-result-max.md` |
| `pico8.constraint.poke-values-max` | constraint | POKE escribe como máximo 8192 valores | verified | `knowledge/constraints/poke-values-max.md` |
| `pico8.constraint.cart-write-session-limit` | constraint | CSTORE escribe hasta 64 cartuchos por sesión | verified | `knowledge/constraints/cart-write-session-limit.md` |
| `pico8.constraint.cartdata-number-count` | constraint | Un slot CARTDATA almacena 64 números (256 bytes) | verified | `knowledge/constraints/cartdata-number-count.md` |
| `pico8.constraint.cartdata-id-length` | constraint | ID de CARTDATA de hasta 64 caracteres (a..z, 0..9, _) | verified | `knowledge/constraints/cartdata-id-length.md` |

## Ciclo de juego

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.concept.game-loop` | concept | Bucle `_init`/`_update`/`_draw` y modos 30/60/15fps | verified | `knowledge/concepts/game-loop.md` |

## Entrada

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.btn` | api | Estado de botón por jugador o bitfield | verified | `knowledge/api-input/btn.md` |
| `pico8.api.btnp` | api | Pulsación en borde con repetición | verified | `knowledge/api-input/btnp.md` |
| `pico8.concept.devkit-input` | concept | Modo devkit de ratón y teclado (experimental) | verified | `knowledge/concepts/devkit-input.md` |

## Gráficos

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.clip` | api | Rectángulo de recorte para operaciones de dibujo | verified | `knowledge/api-graphics/clip.md` |
| `pico8.api.pset` | api | Dibujar píxel con índice de color | verified | `knowledge/api-graphics/pset.md` |
| `pico8.api.pget` | api | Leer color de un píxel de pantalla | verified | `knowledge/api-graphics/pget.md` |
| `pico8.api.sget` | api | Leer color de un píxel de la hoja de sprites | verified | `knowledge/api-graphics/sget.md` |
| `pico8.api.sset` | api | Escribir color de un píxel de la hoja de sprites | verified | `knowledge/api-graphics/sset.md` |
| `pico8.api.fget` | api | Leer flags de un sprite | verified | `knowledge/api-graphics/fget.md` |
| `pico8.api.fset` | api | Escribir flags de un sprite | verified | `knowledge/api-graphics/fset.md` |
| `pico8.api.print` | api | Imprimir texto con color y retorno de ancho | verified | `knowledge/api-graphics/print.md` |
| `pico8.api.cursor` | api | Fijar posición del cursor de texto | verified | `knowledge/api-graphics/cursor.md` |
| `pico8.api.color` | api | Fijar color de dibujo actual | verified | `knowledge/api-graphics/color.md` |
| `pico8.api.cls` | api | Limpiar pantalla y restablecer recorte | verified | `knowledge/api-graphics/cls.md` |
| `pico8.api.camera` | api | Desplazamiento de cámara para el dibujo | verified | `knowledge/api-graphics/camera.md` |
| `pico8.api.circ` | api | Círculo (contorno) | verified | `knowledge/api-graphics/circ.md` |
| `pico8.api.circfill` | api | Círculo relleno | verified | `knowledge/api-graphics/circfill.md` |
| `pico8.api.oval` | api | Elipse (contorno) | verified | `knowledge/api-graphics/oval.md` |
| `pico8.api.ovalfill` | api | Elipse rellena | verified | `knowledge/api-graphics/ovalfill.md` |
| `pico8.api.line` | api | Línea entre dos puntos | verified | `knowledge/api-graphics/line.md` |
| `pico8.api.rect` | api | Rectángulo (contorno) | verified | `knowledge/api-graphics/rect.md` |
| `pico8.api.rectfill` | api | Rectángulo relleno | verified | `knowledge/api-graphics/rectfill.md` |
| `pico8.api.rrect` | api | Rectángulo redondeado (contorno) | verified | `knowledge/api-graphics/rrect.md` |
| `pico8.api.rrectfill` | api | Rectángulo redondeado relleno | verified | `knowledge/api-graphics/rrectfill.md` |
| `pico8.api.pal` | api | Re-mapeo de paletas (dibujo, pantalla, secundaria) | verified | `knowledge/api-graphics/pal.md` |
| `pico8.api.palt` | api | Transparencia por índice de color | verified | `knowledge/api-graphics/palt.md` |
| `pico8.api.spr` | api | Dibujar sprite con tamaño y volteo | verified | `knowledge/api-graphics/spr.md` |
| `pico8.api.sspr` | api | Estirar región de la hoja de sprites | verified | `knowledge/api-graphics/sspr.md` |
| `pico8.api.fillp` | api | Patrón de relleno 4x4 de 2 colores | verified | `knowledge/api-graphics/fillp.md` |

## Audio

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.sfx` | api | Reproducir SFX con canal, offset y longitud | verified | `knowledge/api-audio/sfx.md` |
| `pico8.api.music` | api | Reproducir música con fundido y máscara de canales | verified | `knowledge/api-audio/music.md` |

## Mapa y memoria

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.mget` | api | Obtener valor del mapa en (x, y) | verified | `knowledge/api-map/mget.md` |
| `pico8.api.mset` | api | Fijar valor del mapa en (x, y) | verified | `knowledge/api-map/mset.md` |
| `pico8.api.map` | api | Dibujar sección del mapa con capas | verified | `knowledge/api-map/map.md` |
| `pico8.api.tline` | api | Línea texturizada muestreando el mapa | verified | `knowledge/api-map/tline.md` |
| `pico8.api.peek` | api | Leer byte(s) de la RAM base | verified | `knowledge/api-memory/peek.md` |
| `pico8.api.poke` | api | Escribir byte(s) en la RAM base | verified | `knowledge/api-memory/poke.md` |
| `pico8.api.peek2` | api | Leer número de 16 bits (little-endian) | verified | `knowledge/api-memory/peek2.md` |
| `pico8.api.poke2` | api | Escribir número de 16 bits (little-endian) | verified | `knowledge/api-memory/poke2.md` |
| `pico8.api.peek4` | api | Leer número de 32 bits (little-endian) | verified | `knowledge/api-memory/peek4.md` |
| `pico8.api.poke4` | api | Escribir número de 32 bits (little-endian) | verified | `knowledge/api-memory/poke4.md` |
| `pico8.api.memcpy` | api | Copiar LEN bytes dentro de la RAM base | verified | `knowledge/api-memory/memcpy.md` |
| `pico8.api.memset` | api | Rellenar memoria con un valor de 8 bits | verified | `knowledge/api-memory/memset.md` |
| `pico8.api.reload` | api | Copiar de cart ROM a RAM base | verified | `knowledge/api-memory/reload.md` |
| `pico8.api.cstore` | api | Copiar de RAM base a cart ROM | verified | `knowledge/api-memory/cstore.md` |

## Tablas (6.3)

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.add` | api | Añadir valor al final de la tabla o insertar en posición | verified | `knowledge/api-tables/add.md` |
| `pico8.api.del` | api | Eliminar la primera instancia de un valor | verified | `knowledge/api-tables/del.md` |
| `pico8.api.deli` | api | Eliminar por índice; sin índice, el último | verified | `knowledge/api-tables/deli.md` |
| `pico8.api.count` | api | Longitud de la tabla o conteo de instancias | verified | `knowledge/api-tables/count.md` |
| `pico8.api.all` | api | Iterar elementos en orden de inserción | verified | `knowledge/api-tables/all.md` |
| `pico8.api.foreach` | api | Aplicar función a cada elemento | verified | `knowledge/api-tables/foreach.md` |
| `pico8.api.pairs` | api | Iterar clave/valor sin restricción de indexación | verified | `knowledge/api-tables/pairs.md` |

## Matemáticas (6.8)

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.max` | api | Máximo de dos valores | verified | `knowledge/api-math/max.md` |
| `pico8.api.min` | api | Mínimo de dos valores | verified | `knowledge/api-math/min.md` |
| `pico8.api.mid` | api | Valor del medio de tres | verified | `knowledge/api-math/mid.md` |
| `pico8.api.flr` | api | Suelo de un número | verified | `knowledge/api-math/flr.md` |
| `pico8.api.ceil` | api | Techo de un número | verified | `knowledge/api-math/ceil.md` |
| `pico8.api.cos` | api | Coseno con 1.0 = vuelta completa | verified | `knowledge/api-math/cos.md` |
| `pico8.api.sin` | api | Seno invertido para espacio de pantalla | verified | `knowledge/api-math/sin.md` |
| `pico8.api.atan2` | api | Vector a ángulo de 0..1 en pantalla | verified | `knowledge/api-math/atan2.md` |
| `pico8.api.sqrt` | api | Raíz cuadrada | verified | `knowledge/api-math/sqrt.md` |
| `pico8.api.abs` | api | Valor absoluto | verified | `knowledge/api-math/abs.md` |
| `pico8.api.rnd` | api | Aleatorio en [0, X) o elemento aleatorio | verified | `knowledge/api-math/rnd.md` |
| `pico8.api.srand` | api | Fijar semilla aleatoria | verified | `knowledge/api-math/srand.md` |
| `pico8.api.band` | api | AND a nivel de bits (operador &) | verified | `knowledge/api-math/band.md` |
| `pico8.api.bor` | api | OR a nivel de bits (operador \|) | verified | `knowledge/api-math/bor.md` |
| `pico8.api.bxor` | api | XOR a nivel de bits (operador ^^) | verified | `knowledge/api-math/bxor.md` |
| `pico8.api.bnot` | api | NOT a nivel de bits (operador ~) | verified | `knowledge/api-math/bnot.md` |
| `pico8.api.shl` | api | Desplazamiento a la izquierda (operador <<) | verified | `knowledge/api-math/shl.md` |
| `pico8.api.shr` | api | Desplazamiento aritmético a la derecha (operador >>) | verified | `knowledge/api-math/shr.md` |
| `pico8.api.lshr` | api | Desplazamiento lógico a la derecha (operador >>>) | verified | `knowledge/api-math/lshr.md` |
| `pico8.api.rotl` | api | Rotación a la izquierda (operador <<>) | verified | `knowledge/api-math/rotl.md` |
| `pico8.api.rotr` | api | Rotación a la derecha (operador >><) | verified | `knowledge/api-math/rotr.md` |

## Strings (6.10)

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.tostr` | api | Convertir a string con flags de formato | verified | `knowledge/api-strings/tostr.md` |
| `pico8.api.tonum` | api | Convertir a número con flags de formato | verified | `knowledge/api-strings/tonum.md` |
| `pico8.api.chr` | api | Códigos ordinales a string | verified | `knowledge/api-strings/chr.md` |
| `pico8.api.ord` | api | Caracteres a códigos ordinales 0..255 | verified | `knowledge/api-strings/ord.md` |
| `pico8.api.sub` | api | Substring por posiciones | verified | `knowledge/api-strings/sub.md` |
| `pico8.api.split` | api | Dividir string en tabla | verified | `knowledge/api-strings/split.md` |
| `pico8.api.type` | api | Tipo de un valor como string | verified | `knowledge/api-strings/type.md` |

## Datos (6.11)

| ID | Tipo | Resumen | Estado | Ruta |
| --- | --- | --- | --- | --- |
| `pico8.api.cartdata` | api | Abrir slot de almacenamiento permanente | verified | `knowledge/api-data/cartdata.md` |
| `pico8.api.dget` | api | Leer número (0..63) del slot | verified | `knowledge/api-data/dget.md` |
| `pico8.api.dset` | api | Escribir número (0..63) en el slot | verified | `knowledge/api-data/dset.md` |

## Pendiente (dominios no procesados en las fases foundation, graphics, audio, map-memory y data-math)

Estos documentos y límites no existen todavía: pertenecen a fases posteriores y no se
han generado en esta fase.

- **Audio (estado en tiempo real)**: `stat()` expone el estado del mezclador de audio (valores 16..26 legados y 46..56 actuales: canales 0..3, nota, patrón, ticks); sección 6.1, fase system-tools.
- **Audio (códigos P8SCII)**: el código de control `\A` del Apéndice A reproduce datos de SFX (velocidad, bucle, notas, instrumento, volumen, efecto) desde `print`; pertenece a gráficos/apéndice, no se documenta en la fase audio.
- **Audio (editores)**: el editor de SFX (2.4) y el de música (2.5) describen instrumentos, efectos, filtros y formas de onda; herramientas, fase system-tools.
- **Contratos completos de `stat()`**: sólo se citan hechos parciales en `pico8.concept.devkit-input`; dominio system, fase system-tools.
- **Directiva `#INCLUDE`**: documentada en la sección 5; se documentará en la fase system-tools (herramientas).
- **Registro de estado compartido `0x5f36`**: el bitfield se documenta por dominio: fuera de rango de PGET (`0x5f5b`) y SGET (`0x5f59`) en las APIs gráficas, scroll de texto de PRINT (`0x40`) en herramientas; el resto de flags de mapa/memoria ya está cubierto en `mget`, `map` y `tline`.
