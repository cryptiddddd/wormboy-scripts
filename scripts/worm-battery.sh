#!/usr/bin/bash

: '
battery monitor. checks in with your battery level and then sends a notification if necessary.
this also pays attention to whether or not you are currently plugged into power, *and* the last time of check, so as to prevent spamming.
'

# shellcheck disable=SC1091
source "/usr/local/lib/wormboy-utils"

# define threshholds
HIGH_THRESHOLD=95
LOW_THRESHOLD=25
CRIT_THRESHOLD=5

LEVEL=$(acpi -b | awk -F', ' '{print $2}' | tr -d '%,')
POWER=$(acpi -b | grep -c 'Discharging') # 0 -> not charging, anything else -> charging

notify="worm-alert -n root-notify-send -a battery"

CRIT_TITLE="death imminent"
CRIT_MSG="plug me in now pls D:"

LOW_TITLE="low battery"
LOW_MSG="please plug in charger"

HIGH_TITLE="battery full"
HIGH_MSG="consider unplugging"

if [[ ! "$LEVEL" =~ ^[0-9]+$ ]]; then
    error "FATAL Battery level could not be read properly."
    exit 1
fi

info "Battery at $LEVEL%"


# begin checks
if [ "$LEVEL" -le "$CRIT_THRESHOLD" ]; then

    debug "Battery at critical level."

    # this check will be replaced by a check to the last alert time/percentage
    if [ "$POWER" -ne 0 ]; then
        info "Sending critical warning."
        $notify -u "critical" "$CRIT_TITLE" -b "$CRIT_MSG" -s "phone-outgoing-busy" 
    fi

elif [ "$LEVEL" -le "$LOW_THRESHOLD" ]; then


    if [ "$POWER" -ne 0 ]; then
        info "Sending low power warning."
        $notify "$LOW_TITLE" -b "$LOW_MSG" -s "dialog-warning"
    fi

elif [ "$LEVEL" -ge "$HIGH_THRESHOLD" ]; then

    if [ "$POWER" -eq 0 ]; then
        info "Sending high battery notice."
        $notify -u "low" "$HIGH_TITLE" -b "$HIGH_MSG" -s "power-plug"
    fi

else
    info "No action necessary."

fi
