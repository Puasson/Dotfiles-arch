# Notas de Arch puro (equivalente manual del flake NixOS)

Este repo es un port del flake NixOS+Home Manager a dotfiles clásicos.
Lo que en Nix era declarativo aquí es manual o vía `install.sh`.

## Servicios (systemd)

```bash
sudo systemctl enable --now NetworkManager
# Display manager (elige uno; el flake usaba GDM + Hyprland-UWSM):
sudo systemctl enable gdm        # o sddm, ly...
# Bluetooth (opcional):
sudo systemctl enable --now bluetooth
```

Hyprland se entra desde el DM eligiendo la sesión `Hyprland (UWSM)`.
El autostart (`hypr/.config/hypr/configs/autostart.lua`) levanta
`theme-apply --cached`, `nm-applet`, polkit-gnome, `udiskie`, `quickshell`,
`hypridle` y `wallpaper-set --restore` — no hacen falta servicios extra.

## DNS (AdGuard + DNSSEC/DoT, como en el flake)

```bash
sudo systemctl enable --now systemd-resolved
# /etc/systemd/resolved.conf:
#   DNS=94.140.14.14 94.140.15.15
#   FallbackDNS=94.140.14.14 94.140.15.15
#   DNSSEC=true
#   DNSOverTLS=true
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

## Paquetes

- `packages/pacman.txt` → repos oficiales (`pacman -S --needed`).
- `packages/chaotic-aur.txt` → binarios de AUR vía chaotic-AUR, **sin paru/yay**.
- Si un nombre falla, `install.sh` lo reporta al final y sigue con el resto.
  Fallback puntual sin helpers: `git clone <aur-url> && cd <pkg> && makepkg -si`.
- Higiene AUR/chaotic (recomendado por el propio chaotic-AUR):
  `pacman -Qqm` (no-oficiales), `pacman -Qqe` (explícitos), `pacman -Qdt` (huérfanos).

## Neovim

1. `stow nvim`, abre `nvim` y corre `:Lazy sync` (o `install.sh --with-nvim-sync`).
2. `:Mason` e instala: `pyright ruff ts_ls eslint lua_ls html cssls
   tailwindcss emmet_ls jsonls`. `nil_ls`/`qmlls` vienen del sistema
   (`nil`, `qt6-declarative`) si los instalaste.
3. Formateadores externos: `prettierd` (chaotic), `stylua`, `nixfmt`,
   `ruff`. Linters: `ruff`, `eslint`.
4. `image.nvim` necesita además el rock `magick`:
   `luarocks --local install magick` (+ `imagemagick`, `ueberzugpp`).
5. El fondo del editor sigue al sistema: `theme-apply` escribe
   `~/.cache/quickshell/theme/nvim-background` y manda `SIGUSR1` a nvim.
6. Tras el primer sync, commitea `nvim/.config/nvim/lazy-lock.json`
   para fijar versiones.

## Temas

- Fuente de verdad: `themes/palettes.json` (7 familias × dark/light).
- Regenerar: `python3 themes/generate.py` (escribe los 14 `.conf` de Kitty,
  los 14 `.css` GTK y `PaletteData.qml`).
- `theme-set --list | --status | --toggle | --next`,
  `theme-apply [FAMILIA] {dark|light} | --cached`,
  `wallpaper-set --persist FILE | --restore | --random`.
- Fondos: `~/Pictures/Wallpaper` (también `~/Pictures/Wallpaper/<familia>/<modo>`).

## GDM

El flake tematizaba el greeter (adw-gtk3-dark, WhiteSur, Vimix, Ubuntu Sans).
En Arch hazlo con `gdm-settings` (chaotic-AUR) o dconf del perfil `gdm` a mano.

## No portado (a propósito)

`hardware-configuration.nix`, kernel `linux-zen`, `systemd-boot`, particiones
y UUIDs, `system.stateVersion`, `nix-direnv`/`UV_PYTHON` con paths `/nix/store`
(python usa `uv` + python del sistema; `direnv` funciona sin `nix-direnv`).
