#!/usr/bin/env python3
"""Valida manifiestos temporales de PLAN para el skill de conocimiento PICO-8."""

from __future__ import annotations

import argparse
import difflib
import json
import re
# import sys
from pathlib import Path, PurePosixPath
from typing import Any


KINDS = {"api", "constraint", "concept", "example"}
OPERATORS = {"max", "fixed", "exact", "range", "approx"}
UNCERTAINTY_CATEGORIES = {
    "ambiguity",
    "source-limitation",
    "cross-domain-dependency",
    "approximation",
    "source-typo",
}
CONSTRAINT_FIELDS = {"path", "id", "subject", "property", "operator", "value", "unit", "scope"}
ID_PATTERN = re.compile(r"pico8\.(api|constraint|concept|example)\.[a-z0-9-]+$")

MARKER_START = "<!-- PICO8-PLAN-MANIFEST-START: no resumir ni editar este bloque -->"
MARKER_END = "<!-- PICO8-PLAN-MANIFEST-END -->"


def error(errors: list[str], message: str) -> None:
    errors.append(message)


def is_safe_knowledge_path(value: Any) -> bool:
    if not isinstance(value, str) or not value.startswith("knowledge/"):
        return False
    path = PurePosixPath(value)
    return ".." not in path.parts and not path.is_absolute()


def is_allowed(path: str, allowed_paths: list[str]) -> bool:
    return any(path == allowed or (allowed.endswith("/") and path.startswith(allowed)) for allowed in allowed_paths)


def required_string(item: dict[str, Any], field: str, errors: list[str], context: str) -> str:
    value = item.get(field)
    if not isinstance(value, str) or not value.strip():
        error(errors, f"{context}: falta cadena no vacía '{field}'")
        return ""
    return value.strip()


def render_constraints(constraints: list[dict[str, Any]]) -> str:
    header = "| ruta | id | subject | property | operator | value | unit | scope |"
    divider = "| --- | --- | --- | --- | --- | --- | --- | --- |"
    rows = [header, divider]
    for constraint in constraints:
        cells = [str(constraint[field]).replace("|", "\\|") for field in (
            "path", "id", "subject", "property", "operator", "value", "unit", "scope"
        )]
        rows.append("| " + " | ".join(cells) + " |")
    return "\n".join(rows)


def markdown_cell(value: Any) -> str:
    return str(value).replace("|", "\\|").replace("\n", " ")


def render_plan_block(
    phase: str,
    created: list[dict[str, Any]],
    modified: list[str],
    constraints: list[dict[str, Any]],
    uncertainties: list[dict[str, Any]],
) -> str:
    """Renderiza el bloque Markdown canónico que se muestra para aprobación."""
    lines = [
        MARKER_START,
        "## Salida validada del manifiesto",
        "",
        f"Fase: `{markdown_cell(phase)}`",
        f"Rutas creadas: {len(created)} · Rutas modificadas: {len(modified)} · "
        f"Restricciones: {len(constraints)}",
        "",
        "### Archivos creados",
        "",
        "| ruta | kind | id |",
        "| --- | --- | --- |",
    ]
    for item in created:
        lines.append(
            "| " + " | ".join(markdown_cell(item[field]) for field in ("path", "kind", "id")) + " |"
        )
    lines.extend(["", "### Archivos modificados", ""])
    if modified:
        lines.extend(f"- `{markdown_cell(path)}`" for path in modified)
    else:
        lines.append("- Ninguno")
    lines.extend(["", "### Tabla atómica de restricciones", "", render_constraints(constraints), ""])
    lines.extend([
        "### Incertidumbres previstas",
        "",
        "| documento | categoría | evidencia/localizador | acción |",
        "| --- | --- | --- | --- |",
    ])
    if uncertainties:
        for item in uncertainties:
            lines.append(
                "| " + " | ".join(
                    markdown_cell(item[field]) for field in ("document", "category", "evidence", "action")
                ) + " |"
            )
    else:
        lines.append("| — | ambiguity | Ninguna | No hay claims incompatibles en las fuentes autorizadas. |")
    lines.extend([
        "",
        MARKER_END,
    ])
    return "\n".join(lines)


def _normalize_block(text: str) -> str:
    """Normaliza espacios en blanco irrelevantes sin tocar el contenido real.

    Sólo recorta espacios finales de línea y saltos de línea sobrantes al
    principio/final del bloque. No colapsa espacios internos ni cambia
    mayúsculas/minúsculas: una tabla con menos columnas, o una fila sin la
    columna `acción`, debe seguir produciendo una diferencia detectable.
    """
    lines = [line.rstrip() for line in text.strip("\n").splitlines()]
    return "\n".join(lines)


def verify_plan_md(path: Path, rendered_block: str) -> bool:
    """Compara, carácter por carácter (tras normalizar espacios finales), el
    bloque delimitado por PICO8-PLAN-MANIFEST-START/END dentro de un PLAN.md ya
    escrito contra la salida canónica que el manifiesto JSON debería producir.

    Este chequeo reemplaza instrucciones de autodisciplina como "cuenta
    visualmente ocho celdas": ese control ya falló en producción pese a estar
    explícitamente indicado en el skill, porque depende de que el propio
    agente audite honestamente su propia salida. Esta función no confía en
    eso: recalcula la salida esperada de forma determinista y la compara.
    """
    if not path.is_file():
        print(f"ERROR: no existe el archivo PLAN.md a verificar: {path}")
        return False
    text = path.read_text(encoding="utf-8")
    start_count = text.count(MARKER_START)
    end_count = text.count(MARKER_END)
    if start_count != 1 or end_count != 1:
        print(
            f"ERROR: {path} debe contener exactamente un marcador de inicio y uno de "
            f"fin (se encontraron {start_count} de inicio y {end_count} de fin). "
            "Esto normalmente significa que el bloque fue editado, duplicado o "
            "que el PLAN.md no incluye la salida real de --render-plan."
        )
        return False
    start = text.find(MARKER_START)
    end = text.find(MARKER_END) + len(MARKER_END)
    actual_block = text[start:end]
    expected_norm = _normalize_block(rendered_block)
    actual_norm = _normalize_block(actual_block)
    if expected_norm == actual_norm:
        print(f"PLAN.md verificado: coincide con el manifiesto ({path})")
        return True
    print(f"ERROR: {path} no coincide con la salida esperada del manifiesto.")
    print(
        "El bloque pegado en el PLAN.md fue editado, resumido o reescrito a mano "
        "respecto de lo que --render-plan produce a partir del manifiesto real. "
        "Diferencias (esperado vs. encontrado):"
    )
    diff = difflib.unified_diff(
        expected_norm.splitlines(),
        actual_norm.splitlines(),
        fromfile="esperado (manifiesto)",
        tofile=f"encontrado ({path})",
        lineterm="",
    )
    for line in diff:
        print(line)
    return False


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("manifest", help="Ruta de un manifiesto JSON temporal")
    parser.add_argument("--render-constraints", action="store_true")
    parser.add_argument("--render-plan", action="store_true")
    parser.add_argument(
        "--verify-plan-md",
        metavar="PLAN_MD_PATH",
        help=(
            "Verifica que un PLAN.md ya escrito contiene, sin editar, el bloque "
            "que este manifiesto debería producir. Termina con código de salida "
            "distinto de cero si hay cualquier discrepancia."
        ),
    )
    args = parser.parse_args()

    try:
        manifest = json.loads(open(args.manifest, encoding="utf-8").read())
    except (OSError, json.JSONDecodeError) as exc:
        raise SystemExit(f"ERROR: No se pudo leer el manifiesto: {exc}")
    if not isinstance(manifest, dict):
        raise SystemExit("ERROR: El manifiesto debe ser un objeto JSON")

    errors: list[str] = []
    phase = manifest.get("phase")
    if not isinstance(phase, str) or not phase.strip():
        error(errors, "phase debe ser una cadena no vacía")

    allowed_paths = manifest.get("allowed_paths")
    if not isinstance(allowed_paths, list) or not allowed_paths or not all(is_safe_knowledge_path(p) for p in allowed_paths):
        error(errors, "allowed_paths debe ser una lista no vacía de rutas seguras bajo knowledge/")
        allowed_paths = []
    elif len(set(allowed_paths)) != len(allowed_paths):
        error(errors, "allowed_paths contiene rutas duplicadas")

    created = manifest.get("created")
    modified = manifest.get("modified")
    constraints = manifest.get("constraints")
    uncertainties = manifest.get("uncertainties")
    if not isinstance(created, list):
        error(errors, "created debe ser una lista")
        created = []
    if not isinstance(modified, list):
        error(errors, "modified debe ser una lista")
        modified = []
    if not isinstance(constraints, list):
        error(errors, "constraints debe ser una lista")
        constraints = []
    if not isinstance(uncertainties, list):
        error(errors, "uncertainties debe ser una lista")
        uncertainties = []

    all_paths: list[str] = []
    created_by_path: dict[str, dict[str, Any]] = {}
    ids: set[str] = set()
    for index, item in enumerate(created):
        context = f"created[{index}]"
        if not isinstance(item, dict):
            error(errors, f"{context} debe ser objeto")
            continue
        path = required_string(item, "path", errors, context)
        kind = required_string(item, "kind", errors, context)
        identifier = required_string(item, "id", errors, context)
        if not is_safe_knowledge_path(path) or not path.endswith(".md"):
            error(errors, f"{context}: path debe ser un archivo .md seguro bajo knowledge/")
        elif not is_allowed(path, allowed_paths):
            error(errors, f"{context}: ruta fuera del alcance autorizado: {path}")
        if kind not in KINDS:
            error(errors, f"{context}: kind inválido: {kind}")
        if not ID_PATTERN.fullmatch(identifier):
            error(errors, f"{context}: id inválido: {identifier}")
        elif identifier in ids:
            error(errors, f"{context}: id duplicado: {identifier}")
        ids.add(identifier)
        if path in created_by_path:
            error(errors, f"{context}: ruta creada duplicada: {path}")
        created_by_path[path] = item
        all_paths.append(path)

    for index, path in enumerate(modified):
        context = f"modified[{index}]"
        if not is_safe_knowledge_path(path) or not isinstance(path, str) or not path.endswith(".md"):
            error(errors, f"{context}: debe ser una ruta .md segura bajo knowledge/")
            continue
        if not is_allowed(path, allowed_paths):
            error(errors, f"{context}: ruta fuera del alcance autorizado: {path}")
        all_paths.append(path)
    if len(all_paths) != len(set(all_paths)):
        error(errors, "created y modified contienen rutas duplicadas")

    constraint_paths: set[str] = set()
    for index, item in enumerate(constraints):
        context = f"constraints[{index}]"
        if not isinstance(item, dict):
            error(errors, f"{context} debe ser objeto")
            continue
        missing = CONSTRAINT_FIELDS - item.keys()
        if missing:
            error(errors, f"{context}: faltan campos: {', '.join(sorted(missing))}")
            continue
        for field in CONSTRAINT_FIELDS:
            required_string(item, field, errors, context)
        path = str(item["path"])
        constraint_paths.add(path)
        created_item = created_by_path.get(path)
        if not created_item or created_item.get("kind") != "constraint":
            error(errors, f"{context}: debe corresponder a un created kind: constraint: {path}")
        elif created_item.get("id") != item["id"]:
            error(errors, f"{context}: id no coincide con created: {path}")
        if item["operator"] not in OPERATORS:
            error(errors, f"{context}: operator inválido: {item['operator']}")
        if "," in str(item["property"]) or "," in str(item["value"]):
            error(errors, f"{context}: property y value deben ser atómicos (sin comas)")

    declared_constraint_paths = {path for path, item in created_by_path.items() if item.get("kind") == "constraint"}
    if constraint_paths != declared_constraint_paths:
        missing = declared_constraint_paths - constraint_paths
        extra = constraint_paths - declared_constraint_paths
        if missing:
            error(errors, f"faltan filas de restricciones: {', '.join(sorted(missing))}")
        if extra:
            error(errors, f"filas de restricciones sin archivo constraint: {', '.join(sorted(extra))}")

    for index, item in enumerate(uncertainties):
        context = f"uncertainties[{index}]"
        if not isinstance(item, dict):
            error(errors, f"{context} debe ser objeto")
            continue
        category = required_string(item, "category", errors, context)
        for field in ("document", "evidence", "action"):
            required_string(item, field, errors, context)
        if category not in UNCERTAINTY_CATEGORIES:
            error(errors, f"{context}: categoría inválida: {category}")

    for message in errors:
        print(f"ERROR: {message}")
    if errors:
        print(f"PLAN inválido: {len(errors)} error(es)")
        raise SystemExit(1)
    print(
        f"PLAN válido: fase={phase}; creados={len(created)}; modificados={len(modified)}; "
        f"restricciones={len(constraints)}; rutas={len(all_paths)}"
    )
    if args.render_constraints:
        print()
        print(render_constraints(constraints))

    rendered_block = render_plan_block(str(phase), created, modified, constraints, uncertainties)
    if args.render_plan:
        print()
        print(rendered_block)

    if args.verify_plan_md:
        print()
        if not verify_plan_md(Path(args.verify_plan_md), rendered_block):
            raise SystemExit(1)


if __name__ == "__main__":
    main()
