# --- Enable Powerlevel10k instant prompt
# ---     should stay close to the top of ~/.zshrc
# ---     initialization code that may require console input (password prompts, [y/n] confirmations, etc.)
# ---         must go above this block; everything else may go below
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# =============================================================================
# === PLUGIN MANAGEMENT =======================================================
# =============================================================================

source "${HOME}/.zgen/zgen.zsh"  # load zgen
if ! zgen saved; then

  echo "(Re-)Generating a zgen init script"

  # --- Oh-my-zsh
  zgen oh-my-zsh
  zgen plugins/git

  # --- Other plugins
  zgen load jeffreytse/zsh-vi-mode
  zgen load romkatv/powerlevel10k powerlevel10k

  # --- Generate the init script from plugins above
  zgen save

fi

# =============================================================================
# === BASIC SETTING ===========================================================
# =============================================================================

# --- Set default editor nvim
export EDITOR=nvim

# --- Set default editor for psql
export PSQL_EDITOR=/run/current-system/sw/bin/nvim

# --- Don't auto cd
unsetopt autocd

# --- Specify options for saving shell history
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000


# --- Completion setup (added by compinstall)
zstyle :compinstall filename '/home/johannes/.zshrc'
autoload -Uz compinit
compinit -D  # -D option set so that there aren't excessively many zcompdump files


# --- Configure powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh    # run config wizard or source config


# --- Load shell aliases
source ~/.sh_aliases


# --- Hook direnv into shell
eval "$(direnv hook zsh)"

