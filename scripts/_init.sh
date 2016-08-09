# Load RVM into a shell session as a function
# [[ -s "$HOME/.rvm/scripts/rvm" ]] &&
#     source "$HOME/.rvm/scripts/rvm"

# Export workspace home variable
export WORKSPACE="$HOME/Desktop/workspace"

### Load other scripts

# Helper to load scripts
_load_script() {
    local _dir="$HOME/.bash/scripts"
    source "$_dir/$1"
}

_load_script "cd.sh"
_load_script "aliases.sh"
_load_script "path.sh"
_load_script "workspace.sh"
_load_script "project.sh"

unset _load_script # Unset helper
