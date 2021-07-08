# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename ~/.zshrc

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Init zsh masala
eval "$(starship init zsh)"
source ~/.config/zsh/zsh-autosuggestions.zsh


# Aliases
alias icat='kitty +kitten icat'
alias contrib='~/bumblebee-status/bumblebee_status/modules/contrib'
alias bumblebee='~/bumblebee-status/bumblebee-status'
alias norecibo='~/NoRecibo_Android/app/src/main/java/com/si/norecibo'
alias confs='~/.config'
