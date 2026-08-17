#!/usr/bin/env python3
"""Assert-based tests for sprite_to_ascii.py (no external deps).

Run from the repo root:
    python3 .opencode/skills/pico8-sprite-viewer/scripts/tests/test_sprite_to_ascii.py
"""

from __future__ import annotations

import sys
from pathlib import Path

TESTS_DIR = Path(__file__).resolve().parent
SCHEV = TESTS_DIR.parent.parent / "scripts"
sys.path.insert(0, str(SCHEV))

import sprite_to_ascii as s  # noqa: E402

FIXTURE = TESTS_DIR / "fixtures" / "small_cart.p8"


def test_extract_gfx_rows():
    rows = s.extract_gfx_rows(s.parse_cart(FIXTURE))
    assert len(rows) == 8, f"expected 8 gfx rows, got {len(rows)}"
    assert all(len(r) == s.GFX_ROW_WIDTH for r in rows)


def test_sprite_zero_pixel():
    rows = s.extract_gfx_rows(s.parse_cart(FIXTURE))
    grid = s.sprite_grid(rows, 0)
    assert grid[0][0] == 1
    assert grid[0][1] == 0
    assert grid[7][7] == 0


def test_render_single_pixel_sprite():
    rows = s.extract_gfx_rows(s.parse_cart(FIXTURE))
    grid = s.sprite_grid(rows, 0)
    out = s.format_sprite(grid, label="0")
    lines = out.splitlines()
    assert lines[0] == "<sprite 0>"
    assert lines[1] == "1......."
    assert lines[2] == "........"
    assert lines[9].strip().startswith("|")
    assert "1=dark_blue" in lines[9]


def test_pixel_char_mapping():
    assert s.pixel_char(0) == "."
    assert s.pixel_char(1) == "1"
    assert s.pixel_char(9) == "9"
    assert s.pixel_char(10) == "A"
    assert s.pixel_char(15) == "F"


def test_sprite_range_out_of_bounds():
    rows = s.extract_gfx_rows(s.parse_cart(FIXTURE))
    try:
        s.sprite_grid(rows, 256)
    except ValueError:
        pass
    else:
        raise AssertionError("sprite_grid(256) should raise ValueError")


def test_palette():
    out = s.format_palette()
    assert out.splitlines()[0] == " 0=black"
    assert out.splitlines()[15] == "15=peach"


if __name__ == "__main__":
    failures = 0
    for name, fn in sorted(globals().items()):
        if name.startswith("test_") and callable(fn):
            try:
                fn()
                print(f"PASS {name}")
            except Exception as exc:  # noqa: BLE001
                failures += 1
                print(f"FAIL {name}: {exc}")
    sys.exit(1 if failures else 0)