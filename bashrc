# Language
#LANG=C
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

BREW_PREFIX="${HOMEBREW_PREFIX:-}"
if [[ -z "$BREW_PREFIX" ]] && hash brew 2>/dev/null; then
    BREW_PREFIX="$(brew --prefix)"
fi

export PATH="${BREW_PREFIX}/bin/:$PATH"

# GNU tools precedence over BSD
if [[ -d "${BREW_PREFIX}/opt/coreutils/libexec/" ]]; then
    export PATH="${BREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="${BREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
    export MANPATH="${BREW_PREFIX}/opt/coreutils/libexec/gnuman:$MANPATH"
    export MANPATH="${BREW_PREFIX}/opt/grep/libexec/gnuman:$MANPATH"
fi

if [[ -n "${BREW_PREFIX}" ]]; then
    export MANPATH="${BREW_PREFIX}/share/man:$MANPATH"
fi

# Starship prompt (replaces custom git branch parsing)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
else
    # Fallback to simple prompt if starship not available
    export PS1="\u@ \[\e[00;1m\]\W\[\033[00m\] $ "
fi

# Shell completions
# Homebrew bash-completion v2 requires Bash 4+. macOS /bin/bash is 3.2, so use
# Homebrew Bash (/opt/homebrew/bin/bash) for full completion support.
if (( BASH_VERSINFO[0] >= 4 )); then
    if [[ -n "${BREW_PREFIX}" && -f "${BREW_PREFIX}/share/bash-completion/bash_completion" ]]; then
        # shellcheck source=/dev/null
        . "${BREW_PREFIX}/share/bash-completion/bash_completion"
    elif [[ -n "${BREW_PREFIX}" && -f "${BREW_PREFIX}/etc/bash_completion" ]]; then
        # shellcheck source=/dev/null
        . "${BREW_PREFIX}/etc/bash_completion"
    fi
fi

# Git completion is provided by Apple's Command Line Tools when using /usr/bin/git.
if ! complete -p git >/dev/null 2>&1; then
    if [[ -f "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash" ]]; then
        # shellcheck source=/dev/null
        . "/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
    elif [[ -n "${BREW_PREFIX}" && -f "${BREW_PREFIX}/etc/bash_completion.d/git-completion.bash" ]]; then
        # shellcheck source=/dev/null
        . "${BREW_PREFIX}/etc/bash_completion.d/git-completion.bash"
    fi
fi

# GitHub CLI completion, if gh is installed.
if command -v gh >/dev/null 2>&1 && ! complete -p gh >/dev/null 2>&1; then
    eval "$(gh completion -s bash)"
fi

# History configuration
export HISTCONTROL=ignoreboth:erasedups

shopt -s histappend

HISTSIZE=-1
HISTFILESIZE=-1

# Ghostty can inject a shell hook into PROMPT_COMMAND. If tmux starts a fresh
# shell without the function definition, remove the stale hook to avoid errors.
if [[ "$(type -t __ghostty_hook 2>/dev/null)" != "function" ]]; then
    PROMPT_COMMAND="${PROMPT_COMMAND//__ghostty_hook; /}"
    PROMPT_COMMAND="${PROMPT_COMMAND//; __ghostty_hook/}"
    PROMPT_COMMAND="${PROMPT_COMMAND//__ghostty_hook/}"
fi

# Optimized history sharing (reduced overhead)
if [[ "$PROMPT_COMMAND" != *"history -a"* ]]; then
    export PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
fi

# Ghostty shell integration — defines __ghostty_hook; skipped inside tmux/SSH
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    # shellcheck source=/dev/null
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

# Vi mode for interactive terminal
if [[ $- == *i* ]]; then
    bind -m vi-insert '\C-l':clear-screen
    set -o vi
fi

# FZF configuration
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

# PyEnv (lazy loading for performance)
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    # Lazy load pyenv - only initialize when first used
    pyenv() {
        unset -f pyenv
        eval "$(command pyenv init --path)"
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
fi

alias ls="ls --color=always"
alias zaws=zalando-aws-cli
alias tig="lazygit"
alias lg="lazygit"
export ZKUBECTL_USE_OKTA=false

export BASH_SILENCE_DEPRECATION_WARNING=1

# User binaries
export PATH="$PATH:$HOME/.local/bin"

# Editor
if [[ -n "${BREW_PREFIX}" && -x "${BREW_PREFIX}/bin/vim" ]]; then
    export EDITOR="${BREW_PREFIX}/bin/vim"
else
    export EDITOR="vim"
fi

# Go
export GOPATH="$HOME/go"

# Bun JavaScript runtime
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
