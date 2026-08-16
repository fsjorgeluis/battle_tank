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

## Pendiente (dominios no procesados en las fases foundation, graphics y audio)

Estos documentos y límites no existen todavía: pertenecen a fases posteriores y no se
han generado en esta fase.

- **Mapa/memoria**: tilemap 128x32 (+128x32 compartido); superposición sprite/mapa; secciones 6.6 y 6.7.
- **Audio (estado en tiempo real)**: `stat()` expone el estado del mezclador de audio (valores 16..26 legados y 46..56 actuales: canales 0..3, nota, patrón, ticks); sección 6.1, fase system-tools.
- **Audio (códigos P8SCII)**: el código de control `\A` del Apéndice A reproduce datos de SFX (velocidad, bucle, notas, instrumento, volumen, efecto) desde `print`; pertenece a gráficos/apéndice, no se documenta en la fase audio.
- **Audio (editores)**: el editor de SFX (2.4) y el de música (2.5) describen instrumentos, efectos, filtros y formas de onda; herramientas, fase system-tools.
- **Datos/cartucho**: límite de 32k de datos del cartucho; sección 6.11.
- **Directiva `#INCLUDE`**: documentada en la sección 5 pero sin ruta `api` autorizada en foundation.
- **Contratos completos de `stat()` y `poke()`**: sólo se citan hechos parciales en `pico8.concept.devkit-input`; dominios system y memory.
- **APIs `map()` y `tline()`**: citadas en 6.2 (transparencia de `palt` y máscaras de `fget`) pero su contrato completo pertenece al dominio de mapa (sección 6.6).
- **Soporte de las APIs gráficas vía `poke`**: la configuración de scroll (`0x5f36`) y valores fuera de rango (`0x5f5b`, `0x5f59`) depende del contrato de memoria (sección 6.7).
