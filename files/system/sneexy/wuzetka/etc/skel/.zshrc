#!/usr/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# export some custom paths the average user may use
path+=("${HOME}/.local/bin")
path+=("${HOME}/.cargo/bin")

# load sheldon
eval "$(sheldon source)"

# random pokemon sprite
krabby random

# load completions
autoload -Uz compinit && compinit

# load aliases
if [ -f ${HOME}/.config/zsh/.aliases ]; then
  source ${HOME}/.config/zsh/.aliases
fi

# zoxide
eval "$(zoxide init zsh)"

# autin
eval "$(atuin init zsh)"

# starship prompt
eval "$(starship init zsh)"