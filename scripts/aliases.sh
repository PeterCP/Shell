# Alias to add color to 'grep' command.
alias grep="grep --color=auto"

# Add shorcut aliases for 'ls' command.
alias ls="ls -GFh"
alias la="ls -A"
alias l="ls -l"
alias ll="la -l"
alias lg="ll | grep"
lm(){
    ll "$@" | more
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
