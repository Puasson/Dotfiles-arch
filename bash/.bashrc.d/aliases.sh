# Aliases — traducidos desde home-manager (bash.nix), adaptados a Arch puro.
# Sin referencias a usuarios ni a nixos-rebuild/home-manager.
alias img='kitten icat'
alias clean='rm -f ~/.config/gtk-3.0/settings.ini.backup ~/.config/gtk-4.0/settings.ini.backup'
alias ..='cd ..'

# pacman + chaotic-aur
alias update='sudo pacman -Syu'
alias install='sudo pacman -S --needed'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias orphans='pacman -Qdt'
alias pkgclean='sudo pacman -Sc'
alias explicit='pacman -Qqe'
alias foreign='pacman -Qqm'

# dotfiles
alias dots='cd ~/Documents/dotfiles'
alias dots-stow='stow --restow --target="$HOME" --dir="$HOME/Documents/dotfiles"'
alias theme-list='theme-set --list'
alias theme-status='theme-set --status'

# atajos personales
alias datos='cd /mnt/Datos'
alias work='cd /mnt/Datos/Workstation'
