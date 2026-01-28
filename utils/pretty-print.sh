#!/usr/bin/bash

: '
pretty fruit printing for user feedback.
'

exec 3>&1

function __base_log() {
    if [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge $1 ]; then
        echo -e "$2 $3\e[0m" >&3 3>&-
    fi
}

function info() { __base_log 5 "\e[1;34m🫐 " "$@"; }

function success() { __base_log 5 "\e[1;32m🥝" "$@"; }

function debug() { __base_log 4 "\e[1;35m🍇 " "$@"; }

function warning() { __base_log 3 "\e[1;33m🍋" "$@"; }

function danger() { __base_log 2 "\e[1;33m🍊" "$@"; }

function error() { __base_log 1 "\e[1;31m🍓" "$@"; }
