# Load RVM into a shell session as a function
# [[ -s "$HOME/.rvm/scripts/rvm" ]] &&
#     source "$HOME/.rvm/scripts/rvm"

# Modify prompt.
export PS1="\[\033[32m\]\u\[\033[m\]@\[\033[33;1m\]\h\[\033[m\]:\[\033[36m\]\W\[\033[m\]$ "
export LSCOLORS=ExFxBxDxCxegedabagacad
export CLICOLOR=1

# Export workspace home variable
export WORKSPACE="$HOME/Desktop/workspace"

### Load other scripts

# Helper to load scripts
_load_script() {
    local DIR="$HOME/.bash/scripts"
    source "$DIR/$1"
}

_load_script "cd.sh"
_load_script "aliases.sh"
_load_script "path.sh"
_load_script "workspace.sh"
_load_script "project.sh"

unset _load_script # Unset helper
