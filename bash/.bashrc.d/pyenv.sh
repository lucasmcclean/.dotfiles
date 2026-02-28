if command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"

    if [ -d "$PYENV_ROOT/bin" ]; then
        export PATH="$PYENV_ROOT/bin:$PATH"
    fi

    eval "$(pyenv init - bash)"
    eval "$(pyenv virtualenv-init -)"
fi
