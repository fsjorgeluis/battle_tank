#!/usr/bin/env python3
"""Validador sin dependencias para el contrato de knowledge v1."""

from __future__ import annotations

import hashlib
import re
import sys
from pathlib import Path

VALID_KINDS = {"api", "constraint", "concept", "example"}
VALID_STATUS = {"verified", "ambiguous", "needs-review"}
VALID_CONSTRAINT_OPERATORS = {"max", "fixed", "exact", "range", "approx"}
REQUIRED_CONSTRAINT_FIELDS = {"subject", "property", "operator", "value", "unit", "scope", "enforcement"}
REQUIRED = {"schema_version", "id", "kind", "title", "summary", "status", "source", "relationships", "claims"}


def frontmatter(text: str) -> dict[str, str] | None:
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---\n", 4)
    if end == -1:
        return None
    data: dict[str, str] = {}
    for line in text[4:end].splitlines():
        match = re.match(r"^([A-Za-z_][\w-]*):\s*(.*)$", line)
        if match:
            data[match.group(1)] = match.group(2).strip().strip('"')
    return data


def nested_value(text: str, key: str) -> str | None:
    match = re.search(rf"^\s+{re.escape(key)}:\s*[\"']?([^\"'\n]+)", text, re.MULTILINE)
    return match.group(1).strip() if match else None


def constraint_fields(text: str) -> dict[str, str]:
    """Extrae el único bloque YAML `constraint:` del frontmatter limitado."""
    matches = list(re.finditer(r"^constraint:\n((?:  [A-Za-z_][\w-]*:.*\n?)+)", text, re.MULTILINE))
    if len(matches) != 1:
        return {}
    fields: dict[str, str] = {}
    for line in matches[0].group(1).splitlines():
        match = re.match(r"^  ([A-Za-z_][\w-]*):\s*(.*)$", line)
        if match:
            fields[match.group(1)] = match.group(2).strip().strip('"')
    return fields


def main() -> None:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else "knowledge")
    if not root.is_dir():
        raise SystemExit(f"ERROR: No existe el directorio: {root}")
    errors: list[str] = []
    warnings: list[str] = []
    ids: set[str] = set()
    references: list[tuple[Path, str]] = []
    project_root = root.resolve().parent
    files = [path for path in root.rglob("*.md") if path.name != "index.md"]
    if not files:
        errors.append(f"{root}: no hay documentos de conocimiento que validar")

    for path in files:
        text = path.read_text(encoding="utf-8")
        data = frontmatter(text)
        if data is None:
            errors.append(f"{path}: falta frontmatter YAML delimitado")
            continue
        missing = REQUIRED - data.keys()
        if missing:
            errors.append(f"{path}: faltan claves: {', '.join(sorted(missing))}")
            continue
        identifier = data["id"]
        if not re.fullmatch(r"pico8\.(api|constraint|concept|example)\.[a-z0-9-]+", identifier):
            errors.append(f"{path}: id inválido: {identifier}")
        if identifier in ids:
            errors.append(f"{path}: id duplicado: {identifier}")
        ids.add(identifier)
        if data["schema_version"] != "1.0":
            errors.append(f"{path}: schema_version debe ser 1.0")
        if data["kind"] not in VALID_KINDS:
            errors.append(f"{path}: kind inválido: {data['kind']}")
        if data["status"] not in VALID_STATUS:
            errors.append(f"{path}: status inválido: {data['status']}")
        if data["kind"] == "constraint":
            fields = constraint_fields(text)
            missing_constraint = REQUIRED_CONSTRAINT_FIELDS - fields.keys()
            if missing_constraint:
                errors.append(
                    f"{path}: constraint incompleto o múltiple; faltan: "
                    f"{', '.join(sorted(missing_constraint))}"
                )
            else:
                if fields["operator"] not in VALID_CONSTRAINT_OPERATORS:
                    errors.append(f"{path}: constraint.operator inválido: {fields['operator']}")
                for field in ("subject", "property", "value", "unit", "scope"):
                    if not fields[field]:
                        errors.append(f"{path}: constraint.{field} no puede estar vacío")
                if "," in fields["property"] or "," in fields["value"]:
                    errors.append(
                        f"{path}: constraint debe ser atómico; property y value no pueden contener comas"
                    )
        if data["status"] == "verified" and not re.search(r"^\s*- id: .*?\n(?:\s+.*\n)*?\s+evidence:", text, re.MULTILINE):
            errors.append(f"{path}: verified requiere al menos una claim con evidence")
        if data["status"] == "ambiguous" and "## Ambigüedades" not in text:
            errors.append(f"{path}: ambiguous requiere sección de ambigüedades")
        source_id = nested_value(text, "source_id")
        source_hash = nested_value(text, "sha256")
        if not source_hash or not re.fullmatch(r"[0-9a-fA-F]{64}", source_hash):
            errors.append(f"{path}: source.sha256 debe contener 64 caracteres hexadecimales")
        elif source_id:
            snapshots = list((project_root / "sources").glob(f"{source_id}.*"))
            snapshots = [candidate for candidate in snapshots if not candidate.name.endswith(".source.json")]
            if not snapshots:
                errors.append(f"{path}: no existe instantánea local para source_id: {source_id}")
            elif len(snapshots) > 1:
                errors.append(f"{path}: hay más de una instantánea para source_id: {source_id}")
            else:
                actual_hash = hashlib.sha256(snapshots[0].read_bytes()).hexdigest()
                if actual_hash.lower() != source_hash.lower():
                    errors.append(f"{path}: source.sha256 no coincide con {snapshots[0]}")
        else:
            errors.append(f"{path}: falta source.source_id")
        for target in re.findall(r'target:\s*["\']?([\w.-]+)', text):
            references.append((path, target))

    for path, target in references:
        if target not in ids:
            errors.append(f"{path}: relationship apunta a id inexistente: {target}")
    index = root / "index.md"
    if not index.exists():
        errors.append(f"{index}: falta el índice de recuperación")

    for message in errors:
        print(f"ERROR: {message}")
    for message in warnings:
        print(f"WARNING: {message}")
    print(f"Documentos inspeccionados: {len(files)}; errores: {len(errors)}; avisos: {len(warnings)}")
    raise SystemExit(1 if errors else 0)


if __name__ == "__main__":
    main()
