# Enable Powerlevel10k instant prompt
# -- should stay close to the top of ~/.zshrc
# -- initialization code that may require console input (password prompts, [y/n]
#    confirmations, etc.) must go above this block; everything else may go below
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Gopath
export GOPATH=$HOME/go


# IDEA JDK
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/


# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH                                 # base PATH
# export PATH=$PATH:/home/johannes/.local/bin/                               # add terminal image displaying
export PATH=$HOME/.npm-packages/bin:$PATH                                  # npm packages
# export PATH="$PATH:/home/johannes/.local/share/coursier/bin"               # coursier
export PATH=$HOME/diff-so-fancy:$PATH                                      # diff-so-fancy
# export PATH=$PATH:/usr/local/go/bin                                        # Go
# export PATH=$PATH:/$GOPATH/bin
export PATH=$HOME/.gem/bin:$PATH                                           # Ruby
export GEM_HOME=$HOME/.gem                                                 # where the Ruby gems live
export PATH=$PATH:$JAVA_HOME                                               # default java
export PATH=$PATH:"home/johannes/intellij-idea/idea-IC-222.3345.118/bin/"  # Intellij idea

# Set default editor nvim
export EDITOR=nvim


# Plugin management
source "${HOME}/.zgen/zgen.zsh"  # load zgen
if ! zgen saved; then
  echo "(Re-)Generating a zgen init script"

  # oh-my-zsh
  zgen oh-my-zsh
  zgen plugins/git

  # other plugins
  zgen load jeffreytse/zsh-vi-mode
  zgen load romkatv/powerlevel10k powerlevel10k

  # generate the init script from plugins above
  zgen save
fi


# Don't auto cd
unsetopt autocd


# Specify options for saving shell history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000


# Completion setup (added by compinstall)
zstyle :compinstall filename '/home/johannes/.zshrc'
autoload -Uz compinit
compinit -D


# Configure powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh    # run config wizard or source config


# Load shell aliases
source ~/.sh_aliases
