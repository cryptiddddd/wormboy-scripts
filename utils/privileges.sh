
safe-elevate () {
    command="$@"
    if tty -s; then
        sudo $command
    else
        pkexec $command
    fi
    return $?
}
