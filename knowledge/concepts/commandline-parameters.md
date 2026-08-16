---
schema_version: "1.0"
id: "pico8.concept.commandline-parameters"
kind: "concept"
title: "Parámetros de línea de comandos de PICO-8"
summary: "PICO-8 se invoca desde el sistema operativo como `pico8 [switches] [filename.p8]`; los switches anulan la configuración de config.txt y controlan ventana, sonido, carga, ejecución headless, exportación y rutas de datos."
status: "verified"
source:
  source_id: "pico8-manual-v0.2.7"
  url: "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"
  retrieved_at: "2026-08-15"
  sha256: "057226f0548b595accb5f587b2e58ba6363923b8513c0226c9cd33889c21148a"
  locator:
    section: "1.8 Configuration"
    anchor: "Commandline parameters"
relationships:
  - type: "related"
    target: "pico8.concept.export-tools"
  - type: "related"
    target: "pico8.concept.file-system"
  - type: "related"
    target: "pico8.api.run"
  - type: "related"
    target: "pico8.api.extcmd"
claims:
  - id: "pico8.concept.commandline-parameters.claim.1"
    statement: "La forma de invocación es `pico8 [switches] [filename.p8]` y los switches anulan los ajustes de config.txt."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "pico8 [switches] [filename.p8]  // note: these override settings found in config.txt"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.2"
    statement: "`-width n`, `-height n` y `-windowed n` (0/1) controlan el tamaño y el modo de ventana."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-width n set the window width; -height n set the window height; -windowed n set windowed mode off (0) or on (1)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.3"
    statement: "`-volume n` fija el volumen de audio en 0..256."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-volume n set audio volume 0..256"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.4"
    statement: "`-joystick n` hace que los controles de joystick empiecen en el jugador n (0..7)."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-joystick n joystick controls starts at player n (0..7)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.5"
    statement: "`-run filename` carga y ejecuta un cartucho."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-run filename load and run a cartridge"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.6"
    statement: "`-x filename` ejecuta un cartucho headless y luego sale; marcado como experimental en la fuente."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-x filename execute a PICO-8 cart headless and then quit (experimental!)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.7"
    statement: "`-export param_str` ejecuta el comando EXPORT en modo headless y sale."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-export param_str run EXPORT command in headless mode and exit"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.8"
    statement: "`-p param_str` pasa una string de parámetros al cartucho especificado."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-p param_str pass a parameter string to the specified cartridge"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.9"
    statement: "`-splore` arranca en modo SPLORE."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-splore boot in splore mode"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.10"
    statement: "`-home path` fija la ruta de config.txt y otros datos de usuario; `-root_path path` fija la ruta de los archivos de cartucho; `-desktop path` fija el destino de capturas y gifs."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-home path set the path to store config.txt and other user data files; -root_path path set the path to store cartridge files; -desktop path set a location for screenshots and gifs to be saved"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.11"
    statement: "`-screenshot_scale n` (por defecto 3, 368x368 píxeles) y `-gif_scale n` (por defecto 2, 256x256 píxeles) fijan las escalas de capturas y gifs; `-gif_len n` fija la duración máxima del gif en segundos (1..120)."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-screenshot_scale n scale of screenshots. default: 3 (368x368 pixels); -gif_scale n scale of gif captures. default: 2 (256x256 pixels); -gif_len n set the maximum gif length in seconds (1..120)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.12"
    statement: "`-timeout n` fija los segundos de espera antes de que expiren las descargas (por defecto 30)."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-timeout n how many seconds to wait before downloads timeout (default: 30)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.13"
    statement: "PICO-8 lee la configuración de config.txt al inicio de cada sesión y la guarda al salir; la ruta del archivo depende del sistema operativo y puede cambiarse con el switch `-home`."
    evidence:
      locator: "1.8 Configuration"
      quote_or_paraphrase: "PICO-8 reads configuration settings from config.txt at the start of each session, and saves it on exit ... Use the -home switch (below) to use a different path to store config.txt and other data."
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.14"
    statement: "Algunos ajustes pueden cambiarse en caliente escribiendo `CONFIG SETTING VALUE`; `CONFIG` solo muestra la lista."
    evidence:
      locator: "1.8 Configuration"
      quote_or_paraphrase: "Some settings can be changed while running PICO-8 by typing CONFIG SETTING VALUE. (type CONFIG by itself for a list)"
    classification: "fact"
    confidence: "high"
  - id: "pico8.concept.commandline-parameters.claim.15"
    statement: "`-accept_future n` con valor 1 permite cargar cartuchos hechos con versiones futuras de PICO-8."
    evidence:
      locator: "1.8 Configuration > Commandline parameters"
      quote_or_paraphrase: "-accept_future n 1 to allow loading cartridges made with future versions of PICO-8"
    classification: "fact"
    confidence: "high"
---

## Hechos verificados

Los switches se documentan en 1.8 Configuration > Commandline parameters y anulan los ajustes de `config.txt`. Cubren: ventana (`-width`, `-height`, `-windowed`, `-pixel_perfect`, `-preblit_scale`, `-draw_rect`, `-display`), audio (`-volume`), entrada (`-joystick`), carga/ejecución (`-run`, `-x` headless, `-export`, `-p`, `-splore`), rutas (`-home`, `-root_path`, `-desktop`), capturas (`-screenshot_scale`, `-gif_scale`, `-gif_len`), red (`-timeout`), edición (`-gui_theme`) y compatibilidad (`-accept_future`). Además hay switches de blitting y de sleep por frame.

## Modelo mental

PICO-8 es una aplicación de escritorio invocable con argumentos de línea de comandos. Los switches son configuración del host: no se invocan desde el código del cartucho (a diferencia de `EXTCMD`), salvo que `-p` entrega una string de parámetros legible con `stat(6)`.

## Consecuencias de implementación

- Para automatización o CI, `-x` permite ejecutar un cartucho headless; es experimental, así que no se asume paridad de comportamiento entre plataformas (`derived` desde claim 6).
- `-export` permite exportar desde el host sin abrir el editor (`derived` desde claim 7, ver `pico8.concept.export-tools`).
- `-run` + `-p` permite cargar un cartucho con parámetros desde scripts del sistema (`derived` desde claims 5 y 8).

## Documentos relacionados

- `pico8.concept.export-tools` — el switch `-export` invoca EXPORT en modo headless.
- `pico8.concept.file-system` — `-home` y `-root_path` cambian las rutas de datos y de cartuchos.
- `pico8.api.run` — `RUN()` es la contraparte en runtime del switch `-run`.
- `pico8.api.extcmd` — comandos de host accesibles desde el código del cartucho.

## Ambigüedades

El switch `-x` (headless) se marca como experimental en la fuente; el comportamiento exacto en todas las plataformas no está especificado.
