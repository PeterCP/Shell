# VirtualEnvWrapper initialization.
[ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ] &&
    source "/usr/local/bin/virtualenvwrapper_lazy.sh"

# Load homebrew bash completion.
[ -f "$(brew --prefix)/etc/bash_completion" ] &&
    source "$(brew --prefix)/etc/bash_completion"

# Helper to load scripts
_load_script() {
    local DIR="$HOME/.bash/scripts"
    source "$DIR/$1"
}

# Load scripts.
_load_script "variables.sh"
_load_script "path.sh"
_load_script "aliases.sh"
_load_script "cd.sh"
_load_script "workspace.sh"
_load_script "project.sh"
_load_script "ngxsite.sh"

unset _load_script # Unset helper
