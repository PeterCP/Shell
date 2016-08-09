# Add local bin/ directory to path.
export PATH="$HOME/.bash/bin:$PATH"

# Load init script.
source "$HOME/.bash/scripts/_init.sh"

# Modify prompt.
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\W\[\033[m\]\$ "
export LSCOLORS=ExFxBxDxCxegedabagacad
export CLICOLOR=1

# VirtualEnvWrapper initialization.
export WORKON_HOME="$HOME/.virtualenvs"
source "/usr/local/bin/virtualenvwrapper_lazy.sh"

# Load AutoEnv
# source "/usr/local/bin/activate.sh"
