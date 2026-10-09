#!/usr/bin/env bash
# install.sh — bootstrap de los dotfiles en Arch Linux puro.
# Sin paru/yay: los binarios de AUR vienen de chaotic-AUR (pacman).
# Agnóstico al usuario: todo via $HOME, nunca /home/<user>.
#
# Uso:
#   ./install.sh                      # todo
#   ./install.sh --stow-only           # solo stow
#   ./install.sh --packages-only       # solo repos + paquetes
#   ./install.sh --with-nvim-sync      # además: sync headless de lazy.nvim + Mason
# Vars:
#   DOTFILES  ruta del repo (defecto: $HOME/Documents/dotfiles)
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/Documents/dotfiles}"
WITH_NVIM_SYNC=0
STOW_ONLY=0
PACKAGES_ONLY=0

for arg in "$@"; do
  case "$arg" in
    --with-nvim-sync) WITH_NVIM_SYNC=1 ;;
    --stow-only) STOW_ONLY=1 ;;
    --packages-only) PACKAGES_ONLY=1 ;;
    -h|--help)
      sed -n '2,14p' "$0"
      exit 0 ;;
    *) echo "Flag desconocida: $arg (ver --help)" >&2; exit 1 ;;
  esac
done

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*" >&2; }

[ -d "$DOTFILES" ] || { warn "No existe DOTFILES=$DOTFILES"; exit 1; }
# shellcheck disable=SC1091
. /etc/os-release
[ "${ID:-}" = "arch" ] || { warn "Esto es Arch puro (ID=${ID:-?}). Abortando."; exit 1; }
command -v sudo >/dev/null || { warn "Falta sudo."; exit 1; }

FAILED_PKGS=()

install_list() {
  # $1 = fichero, $2 = prefijo repo opcional (p.ej. chaotic-aur)
  local list="$1" prefix="${2:-}" pkg spec
  while IFS= read -r pkg || [ -n "$pkg" ]; do
    pkg="${pkg%%#*}"
    pkg="$(echo "$pkg" | tr -d '[:space:]')"
    [ -z "$pkg" ] && continue
    spec="$pkg"
    [ -n "$prefix" ] && spec="$prefix/$pkg"
    log "pacman -S $spec"
    if sudo pacman -S --needed --noconfirm "$spec" >/dev/null 2>&1; then
      continue
    fi
    if [ -n "$prefix" ] && sudo pacman -S --needed --noconfirm "$pkg" >/dev/null 2>&1; then
      continue
    fi
    warn "falló: $spec"
    FAILED_PKGS+=("$spec")
  done < "$list"
}

enable_multilib() {
  if grep -q '^\[multilib\]' /etc/pacman.conf; then
    log "multilib ya activo"
    return
  fi
  log "activando [multilib] (requerido por chaotic-AUR)"
  sudo cp /etc/pacman.conf "/etc/pacman.conf.bak.$(date +%s)"
  sudo sed -i 's/^#\(\[multilib\]\)/\1/; s/^#\(Include = \/etc\/pacman.d\/mirrorlist\)/\1/' /etc/pacman.conf
  grep -q '^\[multilib\]' /etc/pacman.conf || { warn "no se pudo activar multilib"; exit 1; }
}

setup_chaotic() {
  if grep -q '^\[chaotic-aur\]' /etc/pacman.conf; then
    log "chaotic-AUR ya configurado"
    return
  fi
  log "configurando chaotic-AUR (keyring + mirrorlist oficiales)"
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U --noconfirm \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  printf '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist\n' | sudo tee -a /etc/pacman.conf >/dev/null
  sudo pacman -Sy
}

do_packages() {
  enable_multilib
  setup_chaotic
  log "actualizando sistema"
  sudo pacman -Syu --noconfirm
  log "instalando repos oficiales"
  install_list "$DOTFILES/packages/pacman.txt"
  log "instalando chaotic-AUR"
  install_list "$DOTFILES/packages/chaotic-aur.txt" "chaotic-aur"
  if [ "${#FAILED_PKGS[@]}" -gt 0 ]; then
    warn "paquetes con fallo (${#FAILED_PKGS[@]}):"
    printf '  - %s\n' "${FAILED_PKGS[@]}" >&2
    warn "revisa docs/arch-notes.md (alternativas / makepkg puntual)"
  fi
}

STOW_PKGS="hypr quickshell nvim kitty palette fastfetch mpv bash gtk ssh opencode scripts"

do_stow() {
  command -v stow >/dev/null || { warn "falta stow (corre primero la fase de paquetes)"; exit 1; }
  log "stow -> $HOME"
  # shellcheck disable=SC2086
  stow --restow --target="$HOME" --dir="$DOTFILES" $STOW_PKGS
  log "enlaces creados. Verifica con: stow --target=\$HOME --dir=$DOTFILES (nada pendiente = OK)"
}

do_theme() {
  mkdir -p "$HOME/Pictures/Wallpaper" "$HOME/.cache/quickshell/theme" "$HOME/.cache/quickshell/wallpaper"
  if [ -f "$HOME/.cache/quickshell/theme/mode" ]; then
    "$HOME/.local/bin/theme-apply" --cached || true
  else
    "$HOME/.local/bin/theme-apply" abyss-blue dark || true
  fi
  log "tema inicial aplicado (abyss-blue dark). Cambia con: theme-set --next | --toggle | --list"
}

do_nvim_sync() {
  if [ "$WITH_NVIM_SYNC" -eq 1 ] && command -v nvim >/dev/null; then
    log "lazy.nvim sync (headless)"
    nvim --headless "+Lazy! sync" +qa || warn "falló Lazy sync; abre nvim y corre :Lazy sync a mano"
  else
    log "omitiendo sync de nvim (usa --with-nvim-sync o abre nvim y corre :Lazy sync)"
  fi
}

main() {
  if [ "$STOW_ONLY" -eq 1 ]; then
    do_stow; do_theme; exit 0
  fi
  do_packages
  if [ "$PACKAGES_ONLY" -eq 1 ]; then
    [ "${#FAILED_PKGS[@]}" -gt 0 ] && exit 1
    exit 0
  fi
  do_stow
  do_theme
  do_nvim_sync
  log "listo. Lee docs/arch-notes.md (servicios: NetworkManager, GDM, DNS, Mason)."
  if [ "${#FAILED_PKGS[@]}" -gt 0 ]; then exit 1; fi
}

main
