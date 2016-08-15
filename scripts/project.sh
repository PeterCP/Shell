# cd into desired project
project() {
    local PROJECT_PATH
    local PROJECT_MAXDEPTH=3 # Max recursion depth for the find command.

    if [[ $1 != "" ]]; then
        PROJECT_PATH=$(find $WORKSPACE -maxdepth $PROJECT_MAXDEPTH -name $1 | head -n 1)
        if [[ -d $PROJECT_PATH ]]; then
            cd $PROJECT_PATH
            echo "Switched into project '$1'."
            if [[ -e ".env" ]]; then
                read -p "Found .env file. Should it be sourced? (y/N) " src
                if [[ $src != "y" && $src != "Y" ]]; then
                    echo ".env file was not sourced."
                else
                    source ".env"
                    echo "Sourced .env file."
                fi
            fi
        else
            echo "Couldn't find project '$1'."
        fi
    else
        echo "Specify a project."
    fi
}

# Autocomplete for 'project' command.
_project_autocomplete() {
    local opts=""
    for dir in $( ls "$WORKSPACE" ); do
        for item in $( ls "$WORKSPACE/$dir" ); do
            if [[ -d "$WORKSPACE/$dir/$item" ]]; then
                opts="$opts $(basename $item)"
            fi
        done
    done
    COMPREPLY=( $(compgen -W "$opts" -- "${COMP_WORDS[COMP_CWORD]}") )
    return 0
}

complete -o nospace -F _project_autocomplete project
