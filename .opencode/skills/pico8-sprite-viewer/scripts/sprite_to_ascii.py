#!/usr/bin/env python3
"""Render PICO-8 sprites from a .p8 cartridge as ASCII art.

Format facts (sources: knowledge/ from the pico8 manual):
- gfx rows are 128 hex chars; 1 char = 1 pixel (4-bit color index 0..15)
  (pico8.concept.memory-layout).
- each sprite is 8x8 px (pico8.constraint.sprite-size); sprite n lives in the
  128x128 sheet (pico8.constraint.sprite-sheet-size) at columns (n%16)*8 and
  rows (n//16)*8.
- palette names: 0 black ... 15 peach (pico8.constraint.palette-color-count).
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

PALETTE_NAMES = [
    "black", "dark_blue", "dark_purple", "dark_green",
    "brown", "dark_gray", "light_gray", "white",
    "red", "orange", "yellow", "green",
    "blue", "indigo", "pink", "peach",
]

GFX_ROW_WIDTH = 128
SPRITE_SIZE = 8
SPRITES_PER_ROW = 16


def parse_cart(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def extract_gfx_rows(text: str) -> list[str]:
    """Return the raw gfx rows (hex strings of GFX_ROW_WIDTH chars)."""
    match = re.search(r"__gfx__\n(.*?)\n__sfx__", text, re.DOTALL)
    if not match:
        raise ValueError("no __gfx__ section found in cartridge")
    rows = []
    for line in match.group(1).splitlines():
        line = line.strip()
        if not line:
            continue
        if len(line) != GFX_ROW_WIDTH:
            raise ValueError(
                f"invalid gfx row length {len(line)} (expected {GFX_ROW_WIDTH}): {line[:20]}..."
            )
        if not re.fullmatch(r"[0-9a-fA-F]+", line):
            raise ValueError(f"gfx row contains non-hex characters: {line[:20]}...")
        rows.append(line)
    return rows


def sprite_grid(rows: list[str], index: int) -> list[list[int]]:
    """Return an 8x8 grid of color indices for the sprite at index."""
    if not 0 <= index < 256:
        raise ValueError(f"sprite index out of range: {index}")
    start_col = (index % SPRITES_PER_ROW) * SPRITE_SIZE
    start_row = (index // SPRITES_PER_ROW) * SPRITE_SIZE
    grid = []
    for r in range(start_row, start_row + SPRITE_SIZE):
        if r >= len(rows):
            grid.append([0] * SPRITE_SIZE)
            continue
        row = rows[r]
        grid.append([int(row[start_col + c], 16) for c in range(SPRITE_SIZE)])
    return grid


def pixel_char(color: int) -> str:
    if color == 0:
        return "."
    # Colors 1..9 -> '1'..'9'; 10..15 -> 'A'..'F'
    return "0123456789ABCDEF"[color]


def render_sprite(grid: list[list[int]]) -> list[str]:
    return ["".join(pixel_char(c) for c in row) for row in grid]


def used_colors(grid: list[list[int]]) -> list[int]:
    return sorted({c for row in grid for c in row if c != 0})


def legend(colors: list[int]) -> list[str]:
    if not colors:
        return ["sin colores usados"]
    width = max(len(str(c)) for c in colors)
    return [
        f"{str(c).rjust(width)}={PALETTE_NAMES[c]}"
        for c in colors
    ]


def collect_non_empty(rows: list[str]) -> list[int]:
    indexes = []
    for n in range(256):
        grid = sprite_grid(rows, n)
        if any(c != 0 for row in grid for c in row):
            indexes.append(n)
    return indexes


def format_sprite(grid: list[list[int]], label: str | None = None) -> str:
    lines = []
    if label:
        lines.append(f"<sprite {label}>")
    for row in render_sprite(grid):
        lines.append(row)
    lines.append("| " + " | ".join(legend(used_colors(grid))))
    return "\n".join(lines)


def format_all(rows: list[str], indexes: list[int]) -> str:
    if not indexes:
        return "no hay sprites no vacíos"
    blocks = []
    for n in indexes:
        grid = sprite_grid(rows, n)
        blocks.append(format_sprite(grid, label=str(n)))
    return "\n\n".join(blocks)


def resolve_name(name: str, cart_path: Path) -> int:
    """Resolve SPR_<NAME> from src/const.lua relative to the cartridge."""
    src_dir = cart_path.resolve().parent / "src"
    const_file = src_dir / "const.lua"
    if not const_file.exists():
        raise ValueError(f"no const file found at {const_file} to resolve --name")
    text = const_file.read_text(encoding="utf-8")
    pattern = re.compile(rf"SPR_({re.escape(name.upper())})\s*=\s*(\d+)")
    m = pattern.search(text)
    if not m:
        raise ValueError(f"SPR_{name.upper()} not found in {const_file}")
    return int(m.group(2))


def format_palette() -> str:
    lines = []
    for i, name in enumerate(PALETTE_NAMES):
        lines.append(f"{i:2d}={name}")
    return "\n".join(lines)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("cart", nargs="?", default="battle_tank.p8",
                        help="path to the .p8 cartridge (default: battle_tank.p8)")
    parser.add_argument("--sprite", type=int, help="sprite index 0..255")
    parser.add_argument("--name", help="SPR_<NAME> constant in src/const.lua")
    parser.add_argument("--all", action="store_true", help="render all non-empty sprites")
    parser.add_argument("--palette", action="store_true", help="show the full 16-color palette")
    args = parser.parse_args(argv)

    cart = Path(args.cart)
    if not cart.exists():
        print(f"cartridge not found: {cart}", file=sys.stderr)
        return 1

    if args.palette:
        print(format_palette())
        return 0

    text = parse_cart(cart)
    rows = extract_gfx_rows(text)

    try:
        if args.all:
            print(format_all(rows, collect_non_empty(rows)))
        elif args.name is not None:
            idx = resolve_name(args.name, cart)
            print(format_sprite(sprite_grid(rows, idx), label=f"{idx}={args.name.lower()}"))
        elif args.sprite is not None:
            print(format_sprite(sprite_grid(rows, args.sprite), label=str(args.sprite)))
        else:
            parser.error("specify one of: --sprite N, --name NAME, --all, --palette")
    except ValueError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())