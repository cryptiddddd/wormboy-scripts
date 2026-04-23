#!/usr/bin/bash

: '
battery monitor. checks in with your battery level and then sends a notification if necessary.
this also pays attention to whether or not you are currently plugged into power, *and* the last time of check, so as to prevent spamming.
'

# shellcheck disable=SC1091
source "/usr/local/lib/wormboy-utils"

# configure notification cmd, aka shortcut...
notify="worm-alert -n root-notify-send -a battery"

# define temp recordkeeper
RECORD="/tmp/last.wormbattery"

# define threshholds
LVLS=(
    #  %level;title;msg;urgency
    "5;death imminent;plug me in now pls D:;critical"
    "25;low battery;please plug into power;dialog-warning"
    "95;battery full;consider unplugging;power-plug;low"
)

# gather from system
LEVEL=$(acpi -b | awk -F', ' '{print $2}' | tr -d '%,')
POWER=$(acpi -b | grep -c 'Discharging') # 0 -> not charging, anything else -> charging




if [[ ! "$LEVEL" =~ ^[0-9]+$ ]]; then
    critical "Battery level could not be read properly."
    exit 1
fi

info "Battery at $LEVEL%"


# isolate condition for easy calling
checkLevelAgainst() {
    if { [ "$LEVEL" -le "$1" ] && [ "$1" -lt 50 ]; } || { [ "$LEVEL" -ge "$1" ] &&  [ "$1" -ge 50 ]; }; then
        echo true
    fi
}

# iterative checks
for lvl in "${LVLS[@]}"; do
    # defaults for optionals
    urgency="normal"

    arr=()
    IFS=";" read -r -a arr <<< "${lvl}"

    level="${arr[0]}"
    title="${arr[1]}"
    msg="${arr[2]}"
    icon="${arr[3]}"
    [ "${arr[4]}" ] && urgency="${arr[4]}"

    if [ "$(checkLevelAgainst "$level")" ]; then
        # this check will be replaced by a check to the last alert time/percentage
        if [ "$POWER" -ne 0 ]; then
            info "Sending notification."
            debug "level: $level"
            debug "title: $title"
            debug "msg: $msg"
            debug "icon: $icon"

            $notify "$title" -b "$msg" -s "$icon" -u "$urgency" 
        fi
    fi
done

# logging last check
echo "$LEVEL" > "$RECORD"
