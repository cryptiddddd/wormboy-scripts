#!/usr/bin/bash

# xset s activate  ## starts screensaver whenever

# check it
status=$(xset q | rg 'timeout:\s+([0-9]+)' -or '$1')


# determine an set
if [ $status -eq 0 ]; then
    xset s on +dpms
    status_update="enabled"
    icon="weather-clear-night"
else
    xset s off -dpms
    status_update="disabled"
    icon="weather-clear"
fi

# alert
notify-send -u LOW -i $icon -a "screensaver toggle" $status_update "screensaver and DPMS $status_update"