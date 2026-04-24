#!/usr/bin/bash
: '
these functions and variables are here to help control any child/sub-processes spawned by a script.

example usage:

    $ track child_process argument argument2 --flag
    $ await-all echo "print before each wait"

where `await-all` will not exit until each child process is complete.
'


pids=()

function track() {
    # shellcheck disable=SC2068
    $@ &
    pids+=("$!")
}


function await-all() {
    # shellcheck disable=SC2048
    for pid in ${pids[*]}; do
        # shellcheck disable=SC2068
        [ "$@" ] && $@
        wait "$pid"
    done
}
