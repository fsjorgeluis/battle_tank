---
schema_version: "1.0"
id: "pico8.api.extcmd"
kind: "api"
title: "EXTCMD"
summary: "Comando especial de sistema: pausa, reset, breadcrumb, etiqueta, capturas, gifs, audio, apagado, carpeta, nombre de archivo y título de ventana."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "6.1 System"
    anchor: "EXTCMD"
relationships:
  - type: "related"
    target: "pico8.api.stat"
  - type: "related"
    target: "pico8.api.printh"
  - type: "related"
    target: "pico8.api.flip"
  - type: "related"
    target: "pico8.concept.export-tools"
claims:
  - id: "pico8.api.extcmd.claim.1"
    statement: "EXTCMD toma una string de comando y dos parámetros numéricos opcionales P1, P2."
    evidence:
      locator: "6.1 System > EXTCMD"
      quote_or_paraphrase: "EXTCMD(CMD_STR, [P1, P2]) -- Special system command, where CMD_STR is a string"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.2"
    statement: "Los comandos disponibles incluyen: \"pause\" (abrir menú de pausa), \"reset\" (reset de cartucho), \"go_back\" (volver al cart anterior), \"label\" (fijar la etiqueta del cart al contenido de pantalla), \"screen\" (guardar captura), \"rec\" (iniciar vídeo), \"rec_frames\" (iniciar vídeo en modo frames), \"video\" (guardar gif en el escritorio), \"audio_rec\" (iniciar grabación de audio), \"audio_end\" (guardar el audio grabado), \"shutdown\" (salir del cartucho en binario exportado), \"folder\" (abrir la carpeta actual), \"set_filename\" y \"set_title\"."
    evidence:
      locator: "6.1 System > EXTCMD"
      quote_or_paraphrase: "\"pause\" request the pause menu be opened | \"reset\" request a cart reset | \"go_back\" return to the previous cart if there is one | \"label\" set cart label to contents of screen | \"screen\" save a screenshot | \"rec\" set video start point | \"rec_frames\" set video start point in frames mode | \"video\" save a .gif to desktop | \"audio_rec\" start recording audio | \"audio_end\" save recorded audio to desktop (no supported from web) | \"shutdown\" quit cartridge (from exported binary) | \"folder\" open current working folder on the host operating system | \"set_filename\" set the filename for screenshots / gifs / audio recordings | \"set_title\" set the host window title"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.3"
    statement: "Para \"video\" y \"screen\", P1 es un factor de escala entero que anula la configuración del sistema y P2, si es > 0, guarda en la carpeta actual en lugar del escritorio."
    evidence:
      locator: "6.1 System > EXTCMD"
      quote_or_paraphrase: "\"video\" and \"screen\": P1: an integer scaling factor that overrides the system setting. P2: when > 0, save to the current folder instead of to desktop"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.4"
    statement: "Para \"audio_end\", P1 > 0 guarda en la carpeta actual en lugar del escritorio."
    evidence:
      locator: "6.1 System > EXTCMD"
      quote_or_paraphrase: "\"audio_end\" P1: when > 0, save to the current folder instead of to desktop"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.5"
    statement: "EXTCMD(\"REC\") y EXTCMD(\"VIDEO\") equivalen a ctrl-8 y ctrl-9 y guardan un gif en el escritorio con la configuración GIF_SCALE actual."
    evidence:
      locator: "6.1 System > Recording GIFs"
      quote_or_paraphrase: "EXTCMD(\"REC\"), EXTCMD(\"VIDEO\") is the same as using ctrl-8, ctrl-9 and saves a gif to the desktop using the current GIF_SCALE setting (use CONFIG GIF_SCALE to change)."
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.6"
    statement: "Por la naturaleza del formato gif, todos los gifs se graban a 33.3fps y PICO-8 omite o duplica frames para aproximar lo que ve el usuario."
    evidence:
      locator: "6.1 System > Recording GIFs"
      quote_or_paraphrase: "all gifs are recorded at 33.3fps, and frames produced by PICO-8 are skipped or duplicated in the gif to match roughly what the user is seeing"
    classification: "fact"
    confidence: "high"
  - id: "pico8.api.extcmd.claim.7"
    statement: "El nombre de archivo por defecto de gifs, capturas y audio es foo_%d, con foo el nombre del cartucho y %d un contador que empieza en 0; EXTCMD(\"SET_FILENAME\", \"FOO\") lo anula."
    evidence:
      locator: "6.1 System > Recording GIFs"
      quote_or_paraphrase: "The default filename for gifs (and screenshots, audio) is foo_%d, where foo is the name of the cartridge, and %d is a number starting at 0 and automatically incremented until a file of that name does not exist. Use EXTCMD(\"SET_FILENAME\",\"FOO\") to override that default."
    classification: "fact"
    confidence: "high"
---

## Contrato

```lua
extcmd(cmd_str, [p1, p2])
```

## Semántica

Ejecuta un comando especial del sistema por string, principalmente para capturas, grabaciones, navegación de carts y control del host.

## Parámetros y retorno

- `cmd_str`: uno de los comandos de la tabla (`"pause"`, `"reset"`, `"go_back"`, `"label"`, `"screen"`, `"rec"`, `"rec_frames"`, `"video"`, `"audio_rec"`, `"audio_end"`, `"shutdown"`, `"folder"`, `"set_filename"`, `"set_title"`).
- `p1`, `p2` (opcionales): parámetros numéricos según el comando.
- Retorno: no especificado por la fuente.

## Efectos y límites

- `"audio_end"` no está soportado desde web.
- Los gifs se graban a 33.3fps fijos; `EXTCMD("REC_FRAMES")` graba un frame por cada `FLIP()`.

## Ejemplos relacionados

`EXTCMD("VIDEO", 4)` graba un gif a escala x4 (512x512); `EXTCMD("VIDEO", 0, 1)` graba con escala por defecto en la carpeta de datos.

## Ambigüedades

Ninguna documentada.
