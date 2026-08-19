## MODIFIED Requirements

### Requirement: Límites de la arena y colisión con tiles sólidos
El tanque SHALL quedar contenido dentro del area de juego de la pantalla completa (128x128) y no SHALL atravesar tiles sólidos del mapa (ladrillo, metal ni bases). Al alcanzar un borde o un tile sólido, el tanque SHALL detenerse sin traspasarlo y solo podra separarse rotando o invirtiendo la marcha.

#### Scenario: Los cuatro bordes
- **WHEN** el tanque intenta salir por cualquiera de los cuatro bordes de la arena
- **THEN** se detiene en el borde correspondiente sin traspasarlo

#### Scenario: Colisión con ladrillo
- **WHEN** el tanque se mueve hacia un tile de ladrillo
- **THEN** el tanque se detiene antes de ocupar ese tile

#### Scenario: Colisión con metal
- **WHEN** el tanque se mueve hacia un tile de metal
- **THEN** el tanque se detiene antes de ocupar ese tile

#### Scenario: Colisión con base
- **WHEN** el tanque se mueve hacia un tile de base
- **THEN** el tanque se detiene antes de ocupar ese tile
