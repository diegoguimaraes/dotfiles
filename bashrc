parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@ \[\e[00;1m\]\W\[\e[32;1m\]\$(parse_git_branch)\[\033[00m\] $ "

if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix)/etc/bash_completion"
fi

# ipython editor
export EDITOR="/usr/local/bin/vim"

# Berry credentials (move somewhere else or handle it diferently)
# export CREDENTIALS_DIR=/meta/credentials

# Bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

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
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

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
eval "$(pyenv init -)"

# add a "gnubin" directory to your PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# `ls` colorized
alias ls="ls --color=always"

# This automatically sources the rc file under those circumstances where it
# would normally only process the profile.
. ~/.bashrc
