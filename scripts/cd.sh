# Wrap cd around pushd and popd
function cd {
    # typing just `cd` will take you $HOME ;)
    if [ "$1" == "" ]; then
        pushd "$HOME" > /dev/null

    # use `cd -` to visit previous directory
    elif [ "$1" == "-" ]; then
        pushd $OLDPWD > /dev/null

    # use `_cd -n` to go n directories back in history
    elif [[ "$1" =~ ^-[0-9]+$ ]]; then
        for i in `seq 1 ${1/-/}`; do
            popd > /dev/null
        done

    # use `cd -- <path>` if your path begins with a dash
    elif [ "$1" == "--" ]; then
        shift
        pushd -- "$@" > /dev/null

    # basic case: move to a dir and add it to history
    else
        pushd "$@" > /dev/null
    fi
}
