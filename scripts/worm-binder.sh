#!/usr/bin/bash

# shellcheck disable=SC1091
source "/usr/local/lib/wormboy-utils"
source /usr/local/lib/lib_ini.sh


NAME="worm-binder"
VERSION="0.1a"


# dependent values
CONF_PATH="/home/$USER/.config/worm/binder.ini"
CACHE_PATH="/tmp/worm/$USER/binder-exec" # this will hold the default after first use


help() {
    cat << EOL
${NAME} ${VERSION}
This tool caches a certain script or command, for easy 
re-use in spam-like testing scenarios.

It is advised to bind this tool's -r and -x commands to 
dedicated keys via your WM, for convenience.

USAGE: ./${NAME} [OPTIONS...]

ACTIONS:
    --help, -h: View this help menu.

OPTIONS:
    --clear, -x: Un-binds the current command, and returns to the default.
    --default, -d: Sets a new default (saved to configuration file).
    --show-config, -c: Shows the location and parsed values of the current configuration file.
    --run, -r: Runs the currently binded command.

ROADMAP:
    - Add support for multiple "slots".
    - Add support for custom hashbangs.
    - Add support for error reporting on failed exit status (rofi?)

Crane Presents... ${NAME}, ${VERSION}
EOL
    exit 0
}


## executes bound command.
execute() {
    # if cache dne, reset to default (ie, load)
    if [[ ! -f "$CACHE_PATH" ]]; then
        reset-exec
    fi

    "$CACHE_PATH"
}


## loads configuration to environment
load-config() {
    ini_to_env "$CONF_PATH" "CFG"
}


## prints the config location and contents
print-config() {
    echo "current config path: $CONF_PATH"
    if [[ -f "$CONF_PATH" ]]; then
        ini_get_all "$CONF_PATH" "binder"
    else
        echo "does not exist, no default action applies."
    fi
}

## resets to configured default
reset-exec() {
    load-config
    update-exec-cache "$CFG_binder_default"
}


## updates the cached command
update-exec-cache() {
    # prints command/script to cache path
    mkdir -p $(dirname $CACHE_PATH)
    echo "#!/usr/bin/bash" > $CACHE_PATH
    echo "$@" >> $CACHE_PATH
    chmod +x $CACHE_PATH
}


# parse argument
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            help
            ;;
        # arguments here.
        -x|--clear)
            reset-exec
            shift
            ;;
        
        -c|--show-config)
            print-config
            shift
            ;;

        -r|--run)
            execute
            shift
            ;;

        -*)
            error "flag '$1' is not recognized."
            exit 1
            ;;
        *)
            POS_ARGS+=("$1")
            shift
            ;;
    esac
done
   

if [[ "$POS_ARGS" ]]; then
    update-exec-cache ${POS_ARGS[@]}
fi