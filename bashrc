# MACOSX
# add a "gnubin" directory to your PATH
if hash brew 2> /dev/null; then
    BREW_PREFIX="$(brew --prefix)"
else
    BREW_PREFIX=""
fi

if [[ -d "${BREW_PREFIX}/opt/coreutils/libexec/" ]]; then
    export PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="${BREW_PREFIX}/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Change man path to look for gnu-binaries first
export MANPATH=/usr/local/share/man/:$MANPATH

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@ \[\e[00;1m\]\W\[\e[32;1m\]\$(parse_git_branch)\[\033[00m\] $ "

# Bash completion
if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix)/etc/bash_completion"
fi

# ipython editor
export EDITOR="/usr/local/bin/vim"

# avoid duplicates in history
export HISTCONTROL=ignoredups:erasedups

# append history entries..
shopt -s histappend

# Bash history size
HISTSIZE= 
HISTFILESIZE=

# Bash history avoid duplicate entries
export HISTCONTROL="ignoreboth:erasedups"

# After each command, save and reload history
# History made available through all tty
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Vi mode for interactive terminal:
if [[ $- == *i* ]]; then
    bind -m vi-insert '\C-l':clear-screen
    set -o vi
fi

# fzf should be configured after vi mode:
if [[ -f "$HOME/.fzf.bash" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.fzf.bash"
    if hash ag 2> /dev/null; then
        export FZF_DEFAULT_COMMAND='ag -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    export FZF_DEFAULT_OPTS="--height 100%"
    export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"
fi

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


# Aliases
alias ls="ls --color=always"

export BASH_SILENCE_DEPRECATION_WARNING=1
