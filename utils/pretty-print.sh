#!/usr/bin/bash

: '
pretty fruit printing for user feedback.

vars for silencing:
WB_SILENT : shuts it all up, just define this cariable
WB_LOG_LV : restricts the level logging to that level or higher (ie, a value of 3 means warning/danger/error/critical messages only.)

universal flags:
    -l : the log level/urgency, 0 being greater urgency
    -t : amount of spaces to preface
'
declare -i -g WB_LOG_LV=5

exec 3>&1

function __base_log() {
    declare -a args=()
    declare -i level=5
    declare tabs=""

    while (( $# > 0 )); do 
        case $1 in
            # arguments here.
            -l|--level)
                level="$2"
                shift;shift;;
            
            -t|--tabs)
                tabs="$(printf ' %.0s' $(seq 1 "$2"))"
                shift;shift;;

            # ANYTHING else is part of the message body
            *)
                args+=("$1")
                shift;;
        esac
    done

    # ensure logging is appropriate
    { [ ! -z "$WB_SILENT" ] || (( WB_LOG_LV < level )) ; } && return 0

    echo -e "$tabs""${args[*]}\e[0m" >&3 3>&-
}

function log() { __base_log -l 5 "🫐 \e[1;34m" "$@" ; }

function success() { __base_log -l 5 "🥝\e[1;32m" "$@" ; }

function debug() { __base_log -l 4 "🍇 \e[1;35m" "$@" ; }

function warning() { __base_log -l 3 "🍋\e[1;33m" "$@" ; }

function danger() { __base_log -l 3 "🍊\e[1;33m" "$@" ; }

function error() { __base_log -l 2 "🍓\e[1;31m" "$@" ; }

function critical() { __base_log -l 1 "💥💥💥\e[1;41m" "$@" ; }

export -f log success debug warning danger error critical
