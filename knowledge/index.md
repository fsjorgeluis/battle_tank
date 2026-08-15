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

## Pendiente (dominios no procesados en la fase foundation)

Estos documentos y límites no existen todavía: pertenecen a fases posteriores y no se
han generado en esta fase.

- **Gráficos**: display 128x128 y paleta fija de 16 colores; banco de 128 sprites 8x8 (+128 compartidos); secciones 6.2.
- **Mapa/memoria**: tilemap 128x32 (+128x32 compartido); superposición sprite/mapa; secciones 6.6 y 6.7.
- **Audio**: 4 canales y 64 instrumentos definibles; sección 6.5.
- **Datos/cartucho**: límite de 32k de datos del cartucho; sección 6.11.
- **Directiva `#INCLUDE`**: documentada en la sección 5 pero sin ruta `api` autorizada en foundation.
- **Contratos completos de `stat()` y `poke()`**: sólo se citan hechos parciales en `pico8.concept.devkit-input`; dominios system y memory.
