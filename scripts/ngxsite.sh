# Autocomplete for ngxsite command.
_ngxsite_autocomplete() {
	# Fallback completion for 'add' command.
    [ "${COMP_WORDS[1]}" = "add" ] && return 1

    local opts=`ngxsite __autocomplete ${COMP_WORDS[@]:1}`
    # echo $opts
    COMPREPLY=( $(compgen -W "$opts" -- "${COMP_WORDS[COMP_CWORD]}") )
    return 0
}
complete -o default -F _ngxsite_autocomplete ngxsite

