# Path to your oh-my-zsh installation.
export ZSH=/home/eggerk/.oh-my-zsh
export TERM=xterm-256color

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(git vi-mode)

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Powerlevel theme.
POWERLEVEL9K_COLOR_SCHEME='dark'

POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='black'

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  prompt_color="red"
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode host dir vcs)
else
  prompt_color="white"
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vi_mode dir vcs)
fi

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time custom_ckws)

POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{${prompt_color}%}%F{0%} $ %k%F{${prompt_color}%}%f "
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX"

POWERLEVEL9K_VI_INSERT_MODE_STRING="INS"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="NOR"
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='cyan'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='0'
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_CUSTOM_CKWS="echo ${CATKIN_WS/\/home\/eggerk*\//}"
POWERLEVEL9K_CUSTOM_CKWS_BACKGROUND="blue"

# User configuration
export GOPATH="/home/eggerk/software/go"
export PATH="$PATH:$GOPATH/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

if which nvim > /dev/null ; then
  export EDITOR=nvim
elif which vim > /dev/null ; then
  EXPORT EDITOR=vim
else
  EXPORT EDITOR=vi
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source ~/dotfiles/ros/setupros.sh

alias vim=nvim
alias -s cc='nvim'
alias -s cpp='nvim'
alias -s h='nvim'
alias -s patch='nvim'
export PATH="/usr/lib/ccache:$PATH"

alias octave-gui='octave'
alias octave='octave-cli'
alias cpr='rsync -azP'
alias git_amend_no_edit='git commit -a --amend --no-edit'

# Vi mode.
function zle-line-init {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-line-finish {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-keymap-select {
  powerlevel9k_prepare_prompts
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N ale-line-finish
zle -N zle-keymap-select

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

# xclip
alias xclip_mid='xclip -selection primary'
alias xclip_cp='xclip -selection clipboard'

export PATH="$HOME/.yarn/bin:$PATH"

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

[ -f ~/.zprofile ] && . ~/.zprofile
