# Set path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="/home/johannes/.oh-my-zsh"

# Set zsh theme
ZSH_THEME="agnoster"


# Zsh plugins
plugins=(
    git
    zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh


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

# Add diff-so-fancy to path
export PATH=$HOME/diff-so-fancy:$PATH

# Default editor nvim
export EDITOR=nvim

source ~/.sh_aliases

# Ruby
export GEM_HOME=$HOME/.gem
export PATH=$HOME/.gem/bin:$PATH


