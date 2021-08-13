# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/johannes/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add Julia to PATH
export PATH=~/julia-1.6.2/bin:$PATH
export PATH=$HOME/.npm-packages/bin:$PATH
export PATH="$PATH:/home/johannes/.local/share/coursier/bin"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$HOME/diff-so-fancy:$PATH

export EDITOR=nvim
v() { $EDITOR $(rg --files | fzf) }
alias config='/usr/bin/git --git-dir=/home/johannes/.cfg/ --work-tree=/home/johannes'
alias vim=nvim
alias vz='nvim ~/.zshrc'
alias vv='nvim ~/.config/nvim/init.vim'
alias l='ls -lha'
#vvv a vim keybindings in the terminal
