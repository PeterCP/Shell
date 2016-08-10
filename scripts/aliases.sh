# Add shorcut aliases for 'ls' command.
alias ls="ls -GFh"
alias la="ls -a"
alias ll="ls -l"
alias lal="ls -al"
alias lg="lal | grep"
lm(){
    lal "$@" | more
}

# Alias for 'brew services'
alias service="brew services"

# Alias for digging the external IP.
alias externalip="dig +short myip.opendns.com @resolver1.opendns.com"

# Alias for 'python manage.py'
pyman() {
    if [[ "$PYMANAGE_FILE" ]]; then
        python "$PYMANAGE_FILE" "$@"
    else
        python "manage.py" "$@"
    fi
}
