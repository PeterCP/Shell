# cd into desired workspace
workspace() {
    cd "$WORKSPACE/$1"
}

# Autocomplete for 'workspace' command.
_workspace_autocomplete() {
    local opts=""
    for item in $( ls $WORKSPACE ); do
    	[[ -d "$WORKSPACE/$item" ]] &&
    		opts="$opts $(basename $item)"
    done
    # opts=$( ls $WORKSPACE )
    COMPREPLY=( $(compgen -W "$opts" -- "${COMP_WORDS[COMP_CWORD]}") )
    return 0
}

complete -o nospace -F _workspace_autocomplete workspace
