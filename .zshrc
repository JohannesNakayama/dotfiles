# Enable Powerlevel10k instant prompt
# -- should stay close to the top of ~/.zshrc
# -- initialization code that may require console input (password prompts, [y/n]
#    confirmations, etc.) must go above this block; everything else may go below
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# IDEA JDK
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Chrome executable for Flutter development
export CHROME_EXECUTABLE="/usr/bin/brave-browser"

# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH                                 # base PATH
export PATH=$HOME/.npm-packages/bin:$PATH                                  # npm packages
export PATH=$HOME/utilities/diff-so-fancy:$PATH                            # diff-so-fancy
export PATH=$HOME/.gem/bin:$PATH                                           # Ruby
export GEM_HOME=$HOME/.gem                                                 # where the Ruby gems live
export PATH=$PATH:$JAVA_HOME/bin                                           # default java
export PATH=$PATH:$HOME/.local/share/coursier/bin
export PATH=$PATH:$HOME/.local/bin

export PATH=$PATH:~/utilities/node-v16.17.0-linux-x64/bin

export PATH=$PATH:/usr/local/go/bin                                        # Go
# export GOPATH=$HOME/go                                                     # Gopath

# TODO: decide
# export PATH=$PATH:"home/johannes/intellij-idea/idea-IC-222.3345.118/bin/"  # Intellij idea
# export PATH=$PATH:/home/johannes/.local/bin/                               # add terminal image displaying
# export PATH="$PATH:/home/johannes/.local/share/coursier/bin"               # coursier
# export PATH=$PATH:/$GOPATH/bin


# Set default editor nvim
export EDITOR=nvim


# Set default editor for psql
export PSQL_EDITOR=/usr/bin/nvim


# Plugin management
source "${HOME}/utilities/.zgen/zgen.zsh"  # load zgen
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
HISTSIZE=100000
SAVEHIST=100000


# Completion setup (added by compinstall)
zstyle :compinstall filename '/home/johannes/.zshrc'
autoload -Uz compinit
compinit -D  # -D option set so that there aren't excessively many zcompdump files


# Configure powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh    # run config wizard or source config


# Load shell aliases
source ~/.sh_aliases


# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
