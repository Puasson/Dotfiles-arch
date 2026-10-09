# dotfiles

Dotfiles para **Arch Linux puro**, agnósticos al usuario (todo via `$HOME`,
nunca `/home/<user>`). Sin `paru`/`yay`: los binarios de AUR vienen de
**chaotic-AUR** con `pacman`.

Port del flake NixOS+Home Manager a dotfiles clásicos con GNU Stow:
Hyprland (config Lua nativa), Quickshell, Kitty, Neovim (`lazy.nvim`),
Fastfetch, MPV, Bash+oh-my-posh, GTK, SSH, OpenCode y 3 scripts propios
(`theme-set`, `theme-apply`, `wallpaper-set`) con 7 familias de tema × dark/light.

## Requisitos

- Arch Linux puro actualizado, `sudo`, `git`, `base-devel`.
- Clonar en `~/Documents/dotfiles` (o fijar `$DOTFILES` a otra ruta).

## Instalación

```bash
git clone <este-repo> ~/Documents/dotfiles
cd ~/Documents/dotfiles
./install.sh                      # repos + paquetes + stow + tema
./install.sh --packages-only       # solo repos + paquetes
./install.sh --stow-only           # solo stow (p. ej. tras git pull)
./install.sh --with-nvim-sync      # además: sync headless de lazy.nvim
```

Después: `docs/arch-notes.md` (servicios, DNS, GDM, Mason, etc.) y reinicia
la sesión para entrar por UWSM/Hyprland.

## Layout (paquetes Stow)

Cada directorio de primer nivel (menos `assets`, `docs`, `packages`,
`themes`) es un paquete: `stow --target="$HOME" <paquete>`.
`install.sh` ya hace `stow` de todos:
`hypr quickshell nvim kitty palette fastfetch mpv bash gtk ssh opencode scripts`.

- `themes/` no se instala: es la fuente (`palettes.json` + `generate.py`).
- `palette/` lleva los `.css` GTK generados a
  `~/.local/share/quickshell-palette/gtk/`.
- `kitty/` incluye `themes-custom/` generado + `theme-current.conf`.

## Temas y Neovim

Ver `docs/arch-notes.md`. Resumen: `theme-set --toggle|--next`,
Neovim sigue al sistema vía `SIGUSR1`, primer `:Lazy sync` + `:Mason`.

## Personalizar

Edita `themes/palettes.json` y corre `python3 themes/generate.py`.
Ajusta tu nombre/email de git en tu `~/.gitconfig` (no va en el repo).
