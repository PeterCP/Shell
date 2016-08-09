# Add shorcut aliases for 'ls' command.
alias ls="ls -GFh"
alias la="ls -a"
alias ll="ls -l"
alias lal="ls -al"
lm(){
	ls -al "$@" | more
}
# Alias for digging the external IP.
alias externalip="dig +short myip.opendns.com @resolver1.opendns.com"

# Alias shorcut for 'python manage.py'
pymanage() {
    if [[ "$PYMANAGE_FILE" ]]; then
        python "$PYMANAGE_FILE" "$@"
    else
        python "manage.py" "$@"
    fi
}
