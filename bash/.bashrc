# .bashrc — dotfiles (Arch puro). Agnóstico al usuario: solo $HOME, nunca /home/<user>.
# interactive check
case $- in
  *i*) ;;
  *) return ;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend checkwinsize
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"

for f in ~/.bashrc.d/*.sh; do
  [ -r "$f" ] && . "$f"
done

# oh-my-posh (tema spaceship, como en el flake NixOS)
if command -v oh-my-posh >/dev/null 2>&1; then
  _posh_theme=""
  for _cand in \
    "$HOME/.cache/oh-my-posh/themes/spaceship.omp.json" \
    /usr/share/oh-my-posh/themes/spaceship.omp.json \
    "$HOME/.local/share/oh-my-posh/themes/spaceship.omp.json"; do
    if [ -r "$_cand" ]; then _posh_theme="$_cand"; break; fi
  done
  unset _cand
  if [ -n "$_posh_theme" ]; then
    eval "$(oh-my-posh init bash --config "$_posh_theme")"
  else
    PS1='[\u@\h \W]\$ '
  fi
  unset _posh_theme
else
  PS1='[\u@\h \W]\$ '
fi

# direnv (si está instalado)
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"

# pnpm / node local
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) PATH="$HOME/.local/bin:$PNPM_HOME:$PATH" ;;
esac
export PATH
