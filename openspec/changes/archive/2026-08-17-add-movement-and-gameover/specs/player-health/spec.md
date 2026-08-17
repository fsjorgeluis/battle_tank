## Purpose

Gestiona la salud del jugador: tres vidas visibles como corazones, pérdida de vidas por contacto con el enemigo e invulnerabilidad temporal con parpadeo.

## ADDED Requirements

### Requirement: Contador de vidas con HUD
El jugador SHALL disponer de 3 vidas en cada partida. Las vidas SHALL mostrarse en pantalla como tres corazones. Cada corazón perdido SHALL dejar de mostrarse de forma inmediata. La partida comienza con los 3 corazones visibles.

#### Scenario: Inicio de partida
- **WHEN** una partida comienza (estado partida)
- **THEN** el HUD muestra 3 corazones y la salud interna del jugador es 3

#### Scenario: HUD tras un toque
- **WHEN** el jugador recibe un toque y pierde una vida
- **THEN** el HUD refleja el cambio de inmediato (un corazón menos)

### Requirement: Daño por contacto
El jugador SHALL perder exactamente una vida por cada toque al enemigo mientras sea vulnerable. Un contacto durante la invulnerabilidad SHALL NO restar vida. Tras un toque, el jugador SHALL entrar en invulnerabilidad.

#### Scenario: Contacto vulnerable
- **WHEN** el cuerpo del tanque colisiona con el enemigo y el jugador es vulnerable
- **THEN** se pierde una vida
- **THEN** el tanque pasa a estar invulnerable

#### Scenario: Contacto invulnerable
- **WHEN** el tanque sigue en contacto con el enemigo mientras es invulnerable
- **THEN** no se pierde ninguna vida adicional

### Requirement: Invulnerabilidad de 3 segundos con parpadeo
Tras recibir daño, el tanque SHALL permanecer invulnerable durante 3 segundos y parpadear (alternar su visibilidad) mientras tanto. Pasado ese tiempo SHALL volver a ser vulnerable y mostrarse de forma continua.

#### Scenario: Ventana de invulnerabilidad
- **WHEN** el jugador recibe daño
- **THEN** durante los siguientes 3 segundos el tanque parpadea y cualquier contacto con el enemigo no causa daño

#### Scenario: Fin de la invulnerabilidad
- **WHEN** transcurren exactamente 3 segundos desde el último toque
- **THEN** el tanque deja de parpadear, se muestra sólido y vuelve a ser vulnerable

#### Scenario: Reinicio de reloj con nuevo toque
- **WHEN** el jugador recibe un nuevo toque cuando puede volver a recibir daño
- **THEN** la ventana de invulnerabilidad se reinicia a 3 segundos completos
- **THEN** la vida se descuenta una vez por este toque

### Requirement: Agotamiento de vidas
Cuando el jugador pierde su última vida (llega a 0), el juego SHALL transicionar a game over y la pantalla de game over SHALL mostrar cuántos toques recibió el jugador en toda la partida.

#### Scenario: Última vida
- **WHEN** el jugador con 1 vida recibe un toque y su salud llega a 0
- **THEN** el estado pasa a game over (ver game-flow)
- **THEN** la pantalla de game over muestra el número de toques recibidos durante la partida