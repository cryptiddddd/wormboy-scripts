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
readonly BATTERY_RECORD="/tmp/last.wormbattery"
readonly CHARGE_RECORD="/tmp/charging.wormbattery"

# define threshholds
readonly LVLS=(
    #  level%;title;msg;urgency
    "5;death imminent;plug me in now pls D:;dialog-danger;critical;1"
    "25;low battery;please plug into power;dialog-warning;low;1"
    "95;battery full;consider unplugging;power-plug;low"
)

# gather from system
BATTERY=$(acpi -b | awk -F', ' '{print $2}' | tr -d '%,')
declare -i -r BATTERY

### functions

# isolate condition for easy calling: compares the given battery levels 
function compareBattery() {

    declare -l -i threshold=$1
    declare -l -i compare=$2

    { (( threshold < 50 )) && ((compare <= threshold)); } || { ((threshold >= 50)) && ((compare >= threshold)); } && return 
    return 1
}

# current battery
function checkCurrentBattery() {
    compareBattery "$1" "$BATTERY"
}

# previous battery
function checkPreviousBattery() {
    compareBattery "$1" "$(cat "$BATTERY_RECORD")"
}


# current power
function isCharging() {
    acpi -b | grep -q 'Discharging' && return 1
    return 0
} 

# previous power
function wasCharging() {
    [ -f "$CHARGE_RECORD" ] && return 0
    return 1
}


# current combined
function checkCurrentCondition() {
    checkCurrentBattery "$1" && [ ! "$(isCharging)" ] && return 0
    return 1
}

# previous combined
function checkPreviousCondition() {
    checkPreviousBattery "$1" && [ ! "$(wasCharging)" ] && return 0
    return 1   
}


# verify
if [[ ! "$BATTERY" =~ ^[0-9]+$ ]]; then
    critical "Battery level could not be read properly."
    exit 1
fi

log "Battery at $BATTERY%"


# iterative checks
for lvl in "${LVLS[@]}"; do
    IFS=";" read -r -a arr <<< "${lvl}"

    # defaults for optionals
    urgency="normal"

    declare -i threshold="${arr[0]}"
    title="${arr[1]}"
    msg="${arr[2]}"
    icon="${arr[3]}"
    [ "${arr[4]}" ] && urgency="${arr[4]}"
    checkPower="${arr[5]}"

    if checkCurrentCondition "$threshold" && ! checkPreviousCondition "$threshold"; then

        log "Sending notification."
        debug -t 4 "battery: $BATTERY"
        debug -t 4 "level: $threshold"
        debug -t 4 "title: $title"
        debug -t 4 "msg: $msg"
        debug -t 4 "icon: $icon"
        debug -t 4 "urgency: $urgency"
        debug -t 4 "checkPower: $checkPower"

        $notify "$title" -b "$msg" -s "$icon" -u "$urgency" 
    fi
done

# logging for next cycle

if [ "$(isCharging)" ]; then
    touch "$CHARGE_RECORD"
else
    rm -f "$CHARGE_RECORD"
fi

echo -n "$BATTERY" > "$BATTERY_RECORD"
