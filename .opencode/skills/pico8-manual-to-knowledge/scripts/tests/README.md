# Pruebas del verificador `--verify-plan-md`

Este directorio contiene fixtures que reproducen, de forma controlada, el fallo
real ocurrido en la fase `map-memory` (tablas truncadas a 2/1/3 columnas en vez
de 3/—/4/8, presentadas con un ✅ falso en la puerta de calidad).

## Archivos

- `fixtures/sample-manifest.json`: manifiesto JSON pequeño y válido (1 API,
  1 restricción, 1 incertidumbre), suficiente para probar el flujo completo sin
  reproducir los 26 archivos de la fase real.
- `fixtures/plan-valid.md`: un PLAN.md que pega el bloque **sin editar**, tal
  como debería hacerlo el agente. Debe pasar la verificación.
- `fixtures/plan-broken.md`: un PLAN.md que reproduce el bug real: la tabla de
  archivos creados sin columnas `kind`/`id`, la tabla de restricciones con sólo
  2 de 8 columnas, la de incertidumbres sin la columna `acción`, y un ✅
  autoasignado en la puerta de calidad. Debe **fallar** la verificación.

## Cómo ejecutar las pruebas manualmente

Desde la raíz de este directorio (`tests/`), con el `validate_phase_plan.py`
actualizado en el mismo directorio de scripts del skill:

```sh
# 1) Debe terminar en código de salida 0 e imprimir:
#    "PLAN.md verificado: coincide con el manifiesto"
python3 ../validate_phase_plan.py fixtures/sample-manifest.json \
  --verify-plan-md fixtures/plan-valid.md
echo "salida: $?"   # esperado: 0

# 2) Debe terminar en código de salida 1, e imprimir un diff mostrando
#    exactamente las columnas/celdas faltantes.
python3 ../validate_phase_plan.py fixtures/sample-manifest.json \
  --verify-plan-md fixtures/plan-broken.md
echo "salida: $?"   # esperado: 1

# 3) Regresión: --render-plan sin el flag nuevo debe comportarse exactamente
#    igual que antes de este cambio.
python3 ../validate_phase_plan.py fixtures/sample-manifest.json --render-plan
```

Si (1) no termina en 0, o (2) no termina en 1 con un diff visible, el cambio no
se aplicó correctamente y no debe usarse en el skill real.

## Prueba de aceptación mínima antes de usar el skill en una fase real

1. Copiar el `validate_phase_plan.py` actualizado sobre
   `.opencode/skills/pico8-manual-to-knowledge/scripts/validate_phase_plan.py`.
2. Copiar el `SKILL.md` actualizado sobre
   `.opencode/skills/pico8-manual-to-knowledge/SKILL.md`.
3. Ejecutar los tres comandos de arriba (ajustando las rutas relativas) y
   confirmar los códigos de salida esperados.
4. Invocar el skill para una fase nueva y pequeña (por ejemplo `audio`, o un
   alcance personalizado de 2-3 documentos) y confirmar en la transcripción que
   el agente:
   - escribe `/tmp/pico8-phase-<fase>-plan.md` antes de mostrar el PLAN,
   - ejecuta `--verify-plan-md` sobre ese archivo,
   - pega la línea `PLAN.md verificado: coincide con el manifiesto` en la
     puerta de calidad,
   - y sólo entonces pide `CONFIRMO`.
5. Como prueba negativa deliberada, se puede pedir al agente (en una
   conversación de prueba, no en uso real) que "resuma la tabla para ahorrar
   espacio" y confirmar que el paso de verificación lo bloquea con un error en
   vez de dejarlo pasar.
