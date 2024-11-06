# Basic zsh configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Basic completion
autoload -Uz compinit
compinit

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f ${vcs_info_msg_0_}$ '

# Useful aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color=auto'
alias emacs='emacs -nw'
alias doom='~/.config/emacs/doom-emacs/bin/doom'

# Key bindings
bindkey -e  # Emacs key bindings
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Path additions
path=("$HOME/.local/bin" $path)
path=("$HOME/.config/emacs/doom-emacs/bin" $path)
export PATH

# Doom Emacs environment variables
export DOOMDIR="$HOME/.config/emacs/doom.d"
export DOOMLOCAL="$HOME/.config/emacs/doom-local"

# Load any local configuration if it exists
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
