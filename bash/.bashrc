# Check if shell is interactive
if [[ $- != *i* ]] ; then
    return
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Ignore doas and sudo for completion
complete -F _root_command doas
complete -F _root_command sudo

# Allow scripts to use aliases
shopt -s expand_aliases

# Use Vim mode
set -o vi

# Source user-defined functions/aliases
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        [ -f "$rc" ] && . "$rc"
    done
fi
