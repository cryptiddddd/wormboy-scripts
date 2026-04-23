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
    "5;death imminent;plug me in now pls D:;dialog-danger;critical;1"
    "25;low battery;please plug into power;dialog-warning;low;1"
    "95;battery full;consider unplugging;power-plug;low"
)

# gather from system
BATTERY=$(acpi -b | awk -F', ' '{print $2}' | tr -d '%,')

# 0 for false, 1 for true
function isCharging() {
    if [ "$(acpi -b | grep -c 'Discharging')" -gt 0 ]; then
        echo 0
    else
        echo 1
    fi
} 

# isolate condition for easy calling
function checkLevelAgainst() {
    if { [ "$BATTERY" -le "$1" ] && [ "$1" -lt 50 ]; } || { [ "$BATTERY" -ge "$1" ] &&  [ "$1" -ge 50 ]; }; then
        echo 1
    fi
}

# verify
if [[ ! "$BATTERY" =~ ^[0-9]+$ ]]; then
    critical "Battery level could not be read properly."
    exit 1
fi

info "Battery at $BATTERY%"


# iterative checks
for lvl in "${LVLS[@]}"; do
    IFS=";" read -r -a arr <<< "${lvl}"

    # defaults for optionals
    urgency="normal"

    level="${arr[0]}"
    title="${arr[1]}"
    msg="${arr[2]}"
    icon="${arr[3]}"
    [ "${arr[4]}" ] && urgency="${arr[4]}"
    checkPower="${arr[5]}"

    if [ "$(checkLevelAgainst "$level")" ]; then
        debug "Met threshold"

        # if existing, check the last alert time/percentage: continue if it also raised alert.
        [ -f "$RECORD" ] && [ "$(checkLevelAgainst "$(cat "$RECORD")")" ] && continue

        # if this level wants us to check charging status, check that and continue
        [ "$checkPower" ] && [ "$(isCharging)" -eq 1 ] && continue

        info "Sending notification."
        debug "battery: $BATTERY"
        debug "level: $level"
        debug "title: $title"
        debug "msg: $msg"
        debug "icon: $icon"
        debug "urgency: $urgency"
        debug "checkPower: $checkPower"

        $notify "$title" -b "$msg" -s "$icon" -u "$urgency" 
    fi
done

# logging last check
echo "$BATTERY" > "$RECORD"
