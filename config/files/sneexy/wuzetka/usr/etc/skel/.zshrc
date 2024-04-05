#!/usr/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# export some custom paths
# (required for some packages/scripts/applications and some things in here)
path+=("${HOME}/.local/bin")
path+=("${HOME}/.cargo/bin")

# load sheldon
eval "$(sheldon source)"

# load completions
autoload -Uz compinit && compinit

# funny pokemon
#krabby random

# load aliases
if [ -f ${HOME}/.config/zsh/.aliases ]; then
  source ${HOME}/.config/zsh/.aliases
fi

# zoxide
eval "$(zoxide init zsh)"

# starship prompt
eval "$(starship init zsh)"
