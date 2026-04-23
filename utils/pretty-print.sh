#!/usr/bin/bash

: '
pretty fruit printing for user feedback.

vars for silencing:
WB_SILENT : shuts it all up, just define this cariable
WB_LOG_LV : restricts the level logging to that level or higher (ie, a value of 3 means warning/danger/error/critical messages only.)
'

exec 3>&1

function __base_log() {
    # todo parse arguments and interpret a -t flag for indentation level.

    if [ -z "$WB_SILENT" ] && [ "${WB_LOG_LV:-5}" -ge "$1" ]; then
        echo -e "$2 $3\e[0m" >&3 3>&-
    fi
}

function info() { __base_log 5 "\e[1;34m🫐 " "$@"; }

function success() { __base_log 5 "\e[1;32m🥝" "$@"; }

function debug() { __base_log 4 "\e[1;35m🍇 " "$@"; }

function warning() { __base_log 3 "\e[1;33m🍋" "$@"; }

function danger() { __base_log 2 "\e[1;33m🍊" "$@"; }

function error() { __base_log 1 "\e[1;31m🍓" "$@"; }

function critical() { __base_log 0 "\e[1;41m💥💥💥" "$@"; }
