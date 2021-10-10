# Path to your oh-my-zsh installation.
export ZSH=/home/eggerk/.oh-my-zsh
export TERM=xterm-256color

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode cp fancy-ctrl-z cargo z)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# User configuration
source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f "/home/$USER/software/nvim-linux64/bin/nvim" ]; then
  alias nvim="/home/$USER/software/nvim-linux64/bin/nvim"
fi
if which nvim > /dev/null ; then
  export EDITOR=nvim
elif which vim > /dev/null ; then
  EXPORT EDITOR=vim
else
  EXPORT EDITOR=vi
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

source ~/dotfiles/ros/setupros.sh

alias zshrc='source ~/.zshrc'
alias vim=nvim
alias -s cc='nvim'
alias -s cpp='nvim'
alias -s h='nvim'
alias -s patch='nvim'

# Octave
alias octave-gui='octave'
alias octave='octave-cli'
alias git_amend_no_edit='git commit -a --amend --no-edit'

# Xclip
alias xclip_mid='xclip -selection primary'
alias xclip_cp='xclip -selection clipboard'

# Disable built-in time.
disable -r time
alias time='time -p'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SSH agent.
if [ ! -n "$SSH_CLIENT" ] && [ ! -n "$SSH_TTY" ]; then
  if ! pgrep -u "$USER" ssh-agent > /dev/null; then
      ssh-agent > ~/.ssh-agent-thing
  fi
  if [[ "$SSH_AGENT_PID" == "" ]]; then
      eval "$(<~/.ssh-agent-thing)" > /dev/null
  fi
fi

alias kitty_image='kitty +kitten icat'

if which g++-8 > /dev/null; then
  export CXX="g++-8"
fi

# Keep title from `fg` to original jobname.
function preexec_fg_title {
  local fg_title
  if [[ $* == fg* ]]; then
     if [[ $* == *%* ]]; then
        fg_title=($(jobs ${${(z)1}[2]})) 2> /dev/null
     else
        fg_title=($(jobs %%)) 2> /dev/null
     fi
     title "${fg_title[4,-1]}"
  else
     title $*
  fi
}

preexec_functions+=(preexec_fg_title)

[ -f ~/.zprofile ] && . ~/.zprofile || true

function help {
  bash -c "help $@"
}

function one_line {
  tr '\n' ' '
}

function strip_file_prefix {
  sed 's,file://,,g'
}

source /home/eggerk/dotfiles/tools/path.sh
