## ADDED Requirements

### Requirement: Retroceso físico al disparar
En el estado partida, disparar con X (btnp(5)) SHALL imprimir al tanque del jugador un impulso opuesto a la dirección en que apunta el cañón (`pl.turret_a`), que lo desplace dentro del movimiento de la partida. El impulso SHALL decaer por fricción hasta detenerse y SHALL respetar las colisiones existentes: los bordes de la arena y los enemigos vivos detienen el desplazamiento (colisión sólida); si durante el retroceso el tanque entra en contacto con un enemigo vivo mientras es vulnerable, podrá recibir daño por contacto (ver capability `player-health`). El desplazamiento total es pequeño (del orden de 1-2 px) y no altera la velocidad ni la orientación de giro del tanque.

#### Scenario: Disparo hacia delante
- **WHEN** el jugador pulsa X con el cañón apuntando en cualquier dirección
- **THEN** el tanque se desplaza brevemente en dirección opuesta al cañón y regresa a reposo por la fricción del impulso, sin cambiar su rotación ni su velocidad de crucero

#### Scenario: Retroceso contra el borde de la arena
- **WHEN** el tanque dispara estando pegado a un borde de la arena con la espalda hacia él
- **THEN** el retroceso no lo saca de la arena: el borde lo detiene y queda apoyado contra él

#### Scenario: Retroceso contra un enemigo vivo
- **WHEN** el tanque dispara y su retroceso le hace solapar el área de un enemigo vivo que tiene detrás
- **THEN** el enemigo bloquea el desplazamiento (el tanque no lo atraviesa) y, si el tanque es vulnerable, el contacto le resta una vida (ver `player-health`)

#### Scenario: Retroceso en modo apuntado
- **WHEN** el jugador mantiene btn(4) con el cañón desalineado del cuerpo y dispara
- **THEN** el retroceso se opone a la dirección real del cañón (`turret_a`), no a la orientación del cuerpo

### Requirement: Fogonazo al disparar
Al disparar, el cañón del jugador SHALL mostrar un fogonazo visual breve (aproximadamente 2 frames) en la punta del cañón, en la dirección de `turret_a`. El fogonazo es puramente visual y no afecta al movimiento ni a las colisiones.

#### Scenario: Destello visible al disparar
- **WHEN** el jugador pulsa X
- **THEN** aparece un píxel brillante en la boca del cañón durante aproximadamente 2 frames y luego desaparece

#### Scenario: Sin fogonazo entre disparos
- **WHEN** pasan más de 2 frames desde el disparo sin disparar de nuevo
- **THEN** no se dibuja ningún fogonazo en el cañón

### Requirement: Impacto visual al golpear a un enemigo
Cuando una bala del jugador impacta en un enemigo vivo (ver `projectiles`), SHALL mostrarse una chispa visual corta (~0.15 s) en la posición del impacto, además del destello blanco propio del enemigo (ver `enemies`). La chispa es transitoria y no altera el estado de la partida.

#### Scenario: Chispa en cada impacto
- **WHEN** una bala solapa a un enemigo vivo
- **THEN** se dibuja una chispa de unos pocos píxeles en el punto del impacto que desaparece en menos de medio segundo
- **THEN** la bala desaparece y el enemigo reduce su vida en 1 o muere si era su última vida

### Requirement: Explosión al morir un enemigo
Cuando un enemigo muere (su vida llega a 0, ver `enemies`), SHALL mostrarse una explosión visible de aproximadamente medio segundo en la posición que ocupaba el enemigo: un destello blanco inicial, un anillo expansivo que cambia de color hacia el rojo y un puñado de escombros que se dispersan y se desvanecen. La explosión es puramente visual y el enemigo muerto no se dibuja mientras tanto.

#### Scenario: Explosión en la muerte
- **WHEN** una bala reduce a 0 la vida de un enemigo
- **THEN** se muestra una explosión de ~0.5 s en la posición de la muerte y el enemigo deja de dibujarse

#### Scenario: La explosión finaliza
- **WHEN** transcurre la duración completa de la explosión
- **THEN** ningún escombro ni anillo permanece en pantalla

### Requirement: Retroalimentación sonora de disparo y explosión
Disparar SHALL reproducir el sonido de disparo y la muerte de un enemigo SHALL reproducir el sonido de explosión, cada uno en su canal reservado (pico8.constraint.audio-channels, pico8.api.sfx): disparo en canal 1 y explosión en canal 0. Los impactos intermedios que no matan SHALL reproducir un sonido de golpe/golpeo.

#### Scenario: Sonido al disparar
- **WHEN** el jugador pulsa X y el disparo no está en cooldown
- **THEN** se reproduce el SFX de disparo en el canal 1

#### Scenario: Sonido de explosión al morir
- **WHEN** un enemigo muere
- **THEN** se reproduce el SFX de explosión en el canal 0

#### Scenario: Sonido en impacto intermedio
- **WHEN** una bala impacta en un enemigo que sobrevive al golpe
- **THEN** se reproduce el sonido de impacto del golpe en su canal reservado

### Requirement: Efectos restablecidos al reiniciar la partida
Al reiniciar una partida (tanto desde menú como tras game over), SHALL desaparecer cualquier efecto en curso y no SHALL quedar chispas, explosiones, fogonazos ni retrocesos pendientes.

#### Scenario: Reinicio limpio tras muerte de enemigo
- **WHEN** una explosión está en curso y el jugador reinicia la partida
- **THEN** no se dibuja ningún resto de efecto: la arena queda limpia al comenzar la nueva partida

#### Scenario: Reinicio durante retroceso
- **WHEN** el tanque está en medio del retroceso y se reinicia la partida
- **THEN** el tanque nuevo comienza sin impulso de retroceso acumulado