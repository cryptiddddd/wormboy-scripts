#!/usr/bin/bash

: '
pretty fruit printing for user feedback.
'

exec 3>&1

__base_log() {
    if [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge $1 ]; then
        echo -e "$2 $3\e[0m" >&3 3>&-
    fi
}

info() { __base_log 5 "\e[1;34m🫐 " "$@"; }

success() { __base_log 5 "\e[1;32m🥝" "$@"; }

debug() { __base_log 4 "\e[1;35m🍇 " "$@"; }

warning() { __base_log 3 "\e[1;33m🍋" "$@"; }

danger() { __base_log 2 "\e[1;33m🍊" "$@"; }

error() { __base_log 1 "\e[1;31m🍓" "$@"; }
