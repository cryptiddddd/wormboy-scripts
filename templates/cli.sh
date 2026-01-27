#!/usr/bin/bash

NAME="script-name"
VERSION="0.1a"

help() {
    cat << EOL
${NAME} ${VERSION}
Tool description goes here.

USAGE: ./${NAME} [OPTIONS...]

ACTIONS:
    --help, -h: View this help menu.

PARAMETERS:

OPTIONS:

Crane Presents... ${NAME}, ${VERSION}
EOL
    exit 0
}

# parse argument
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            help
            ;;
        # arguments here.
        
        -*|--**)
            error "flag '$1' is not recognized."
            exit 1
            ;;
        *)
            POS_ARGS+=("$1")
            shift
            ;;
    esac
done
        

# additional functions and such go here.