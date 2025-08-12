# Check if shell is interactive
if [[ $- != *i* ]]; then
    return
fi

# Enable programmable completion features
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

# Source global definitions
if [[ -f /etc/bashrc ]]; then
    source /etc/bashrc
fi

# Ignore doas and sudo for completion if available
type _root_command &>/dev/null && {
    complete -F _root_command doas
    complete -F _root_command sudo
}

# Use Vim mode
set -o vi

# Source user-defined functions/aliases
if [[ -d ~/.bashrc.d ]]; then
    shopt -s nullglob
    for rc in ~/.bashrc.d/*.sh; do
        [[ -f "$rc" ]] && source "$rc"
    done
    shopt -u nullglob
fi

# pnpm
export PNPM_HOME="/home/lucas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
