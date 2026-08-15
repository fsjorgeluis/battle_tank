#!/usr/bin/env python3
"""Descarga una instantánea explícitamente solicitada del manual oficial."""

from __future__ import annotations

import argparse
import hashlib
from datetime import date
from pathlib import Path
from urllib.request import Request, urlopen

URL = "https://www.lexaloffle.com/dl/docs/pico-8_manual.html"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", required=True)
    args = parser.parse_args()

    root = Path(__file__).resolve().parents[4]
    sources = root / "sources"
    sources.mkdir(exist_ok=True)
    destination = sources / f"pico8-manual-v{args.version}.html"
    if destination.exists():
        raise SystemExit(f"No se sobrescribe una fuente existente: {destination}")

    request = Request(URL, headers={"User-Agent": "pico8-knowledge-builder/1.0"})
    with urlopen(request, timeout=30) as response:
        payload = response.read()
    destination.write_bytes(payload)
    digest = hashlib.sha256(payload).hexdigest()
    metadata = destination.with_suffix(destination.suffix + ".source.json")
    metadata.write_text(
        "{\n"
        f'  "url": "{URL}",\n'
        f'  "retrieved_at": "{date.today().isoformat()}",\n'
        f'  "sha256": "{digest}"\n'
        "}\n",
        encoding="utf-8",
    )
    print(destination)
    print(f"sha256: {digest}")


if __name__ == "__main__":
    main()
