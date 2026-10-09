#!/usr/bin/env python3
"""Genera ficheros de tema estaticos desde palettes.json.

Fuente de verdad: themes/palettes.json (extraido de palettes.nix del flake NixOS).
Uso:
    python3 generate.py                  # regenera todo desde palettes.json
    python3 generate.py --from-nix PATH  # re-extrae palettes.json desde palettes.nix y regenera

Salidas (rutas relativas a la raiz del repo):
    ../kitty/.config/kitty/themes-custom/<fam>-<mode>.conf   (14)
    ../palette/.local/share/quickshell-palette/gtk/<fam>-<mode>.css  (14)
    ../quickshell/.config/quickshell/theme/PaletteData.qml
"""
import argparse
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
PALETTES_JSON = HERE / "palettes.json"

SLOTS = ["bg", "side", "thumb", "text", "main", "muted",
         "blue", "green", "yellow", "red", "violet"]
MODES = ["dark", "light"]


def parse_nix(path: Path) -> dict:
    text = path.read_text()
    families = re.findall(r'"([a-z-]+)"', text.split("families = [", 1)[1].split("];", 1)[0])
    labels = dict(re.findall(r'"([a-z-]+)"\s*=\s*"([^"]+)"', text.split("labels = {", 1)[1].split("};", 1)[0]))
    data: dict = {}
    for fam in families:
        fam_block = re.search(
            r'"' + re.escape(fam) + r'"\s*=\s*\{(.*?)\n    \};',
            text, re.DOTALL)
        if not fam_block:
            raise ValueError(f"familia no encontrada: {fam}")
        body = fam_block.group(1)
        data[fam] = {}
        for mode in MODES:
            m = re.search(mode + r'\s*=\s*\{(.*?)\n      \};', body, re.DOTALL)
            if not m:
                raise ValueError(f"modo no encontrado: {fam}/{mode}")
            colors = dict(re.findall(r'(\w+)\s*=\s*"(#[0-9A-Fa-f]{6})"', m.group(1)))
            missing = [s for s in SLOTS if s not in colors]
            if missing:
                raise ValueError(f"{fam}/{mode} sin slots: {missing}")
            data[fam][mode] = {s: colors[s] for s in SLOTS}
    return {"families": families, "labels": labels, "data": data}


def kitty_file(family: str, mode: str, p: dict) -> str:
    black = p["side"] if mode == "dark" else p["text"]
    white = p["text"] if mode == "dark" else p["bg"]
    return f"""# {family} {mode} — generado por themes/generate.py, NO editar.
background {p['bg']}
foreground {p['main']}
cursor {p['blue']}
cursor_text_color {p['bg']}
selection_background {p['blue']}
selection_foreground {p['bg']}
color0 {black}
color8 {p['muted']}
color1 {p['red']}
color9 {p['red']}
color2 {p['green']}
color10 {p['green']}
color3 {p['yellow']}
color11 {p['yellow']}
color4 {p['blue']}
color12 {p['blue']}
color5 {p['violet']}
color13 {p['violet']}
color6 {p['green']}
color14 {p['green']}
color7 {white}
color15 {white}
url_color {p['blue']}
active_border_color {p['blue']}
inactive_border_color {p['thumb']}
active_tab_background {p['blue']}
active_tab_foreground {p['bg']}
inactive_tab_background {p['thumb']}
inactive_tab_foreground {p['muted']}
tab_bar_background {p['side']}
"""


def gtk_css_file(family: str, mode: str, p: dict) -> str:
    shade = "rgba(0, 0, 0, 0.36)" if mode == "dark" else "rgba(0, 0, 0, 0.12)"
    return f"""/* {family} {mode} — generado por themes/generate.py, NO editar. */
@define-color window_bg_color {p['bg']};
@define-color window_fg_color {p['text']};
@define-color view_bg_color {p['bg']};
@define-color view_fg_color {p['main']};
@define-color headerbar_bg_color {p['side']};
@define-color headerbar_fg_color {p['text']};
@define-color headerbar_border_color {p['thumb']};
@define-color headerbar_backdrop_color @window_bg_color;
@define-color headerbar_shade_color {shade};
@define-color card_bg_color {p['thumb']};
@define-color card_fg_color {p['main']};
@define-color card_shade_color {shade};
@define-color dialog_bg_color {p['side']};
@define-color dialog_fg_color {p['text']};
@define-color popover_bg_color {p['side']};
@define-color popover_fg_color {p['text']};
@define-color shade_color {shade};
@define-color scrollbar_outline_color {shade};
@define-color accent_bg_color {p['blue']};
@define-color accent_fg_color {p['bg']};
@define-color accent_color {p['blue']};
@define-color destructive_bg_color {p['red']};
@define-color destructive_fg_color {p['bg']};
@define-color destructive_color {p['red']};
@define-color success_bg_color {p['green']};
@define-color success_fg_color {p['bg']};
@define-color success_color {p['green']};
@define-color warning_bg_color {p['yellow']};
@define-color warning_fg_color {p['bg']};
@define-color warning_color {p['yellow']};
@define-color error_bg_color {p['red']};
@define-color error_fg_color {p['bg']};
@define-color error_color {p['red']};
"""


def qml_entry(p: dict) -> str:
    return "{ " + ", ".join(f'{s}: "{p[s]}"' for s in SLOTS) + " }"


def qml_file(pal: dict) -> str:
    out = ["pragma Singleton",
           "import Quickshell",
           "import QtQuick",
           "",
           "// Generado por themes/generate.py — NO editar a mano.",
           "Scope {",
           "    function base(fam, dark): var {"]
    for fam in pal["families"]:
        out.append(f'if (fam === "{fam}") {{')
        out.append("    if (dark)")
        out.append(f"        return {qml_entry(pal['data'][fam]['dark'])};")
        out.append(f"    return {qml_entry(pal['data'][fam]['light'])};")
        out.append("}")
    first = pal["families"][0]
    out.append("    // Fallback: primera familia en dark (families valida antes).")
    out.append(f"    return {qml_entry(pal['data'][first]['dark'])};")
    out.append("    }")
    out.append("}")
    return "\n".join(out) + "\n"


def generate(pal: dict) -> list[str]:
    written = []
    kitty_dir = ROOT / "kitty" / ".config" / "kitty" / "themes-custom"
    gtk_dir = ROOT / "palette" / ".local" / "share" / "quickshell-palette" / "gtk"
    kitty_dir.mkdir(parents=True, exist_ok=True)
    gtk_dir.mkdir(parents=True, exist_ok=True)
    for fam in pal["families"]:
        for mode in MODES:
            p = pal["data"][fam][mode]
            kf = kitty_dir / f"{fam}-{mode}.conf"
            kf.write_text(kitty_file(fam, mode, p))
            written.append(str(kf.relative_to(ROOT)))
            gf = gtk_dir / f"{fam}-{mode}.css"
            gf.write_text(gtk_css_file(fam, mode, p))
            written.append(str(gf.relative_to(ROOT)))
    qml = ROOT / "quickshell" / ".config" / "quickshell" / "theme" / "PaletteData.qml"
    qml.write_text(qml_file(pal))
    written.append(str(qml.relative_to(ROOT)))
    return written


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--from-nix", metavar="PATH", default=None)
    args = ap.parse_args()
    if args.from_nix:
        pal = parse_nix(Path(args.from_nix))
        PALETTES_JSON.write_text(json.dumps(pal, indent=2) + "\n")
        print(f"palettes.json actualizado desde {args.from_nix}")
    else:
        pal = json.loads(PALETTES_JSON.read_text())
    for w in generate(pal):
        print(f"  {w}")
    print(f"OK: {len(pal['families']) * 4 + 1} ficheros generados")
    return 0


if __name__ == "__main__":
    sys.exit(main())
