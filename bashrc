# Add local bin directory to path.
export PATH="$HOME/.bash/bin:$PATH"

# Load init script.
source "$HOME/.bash/init.sh"

# VirtualEnvWrapper initialization.
export WORKON_HOME="$HOME/.virtualenvs"
source "/usr/local/bin/virtualenvwrapper_lazy.sh"

# Load AutoEnv
# source "/usr/local/bin/activate.sh"
