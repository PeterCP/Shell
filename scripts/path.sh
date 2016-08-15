### All PATH extensions should go here

# Note that the last entry in this file will be the first entry in
# the PATH variable.

# Helper function.
add_to_path() {
    export PATH="$@:$PATH"
}

# Add PHP 7 Composer to PATH
add_to_path "~/.composer/vendor/bin"

# Add local bin directory to path.
add_to_path "~/.bash/bin"
