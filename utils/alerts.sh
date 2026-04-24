#!/usr/bin/bash

: '
    proxy to notify-send, complete with notif sound playback.
    parameters:
        -a, --app:        appname
        -i, --icon:       icon
        -u, --urgency:    urgency level, "LOW", "NORMAL", or "CRITICAL"
        -b, --body:       notification body text
        -s, --sound:      sound file name, can be used multiple times.
        -S, --soundpath:  base directory for sound files.

    positional arguments:
        used as title.
'
function worm-alert() {
    # set defaults
    args=()
    app="app"
    icon="info"
    urgency="normal"
    sound="message"
    body=""
    soundpath="/usr/share/sounds/freedesktop/stereo"

    sounds=()

    notifier="notify-send"

    # parse args
    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--app)
                app="$2"
                shift;shift;;
            -i|--icon)
                icon="$2"
                shift;shift;;
            -u|--urgency)
                urgency="$2"
                shift;shift;;    

            -b|--body)
                body="$2"
                shift;shift;; 

            -s|--sound)
                sounds+=("$2")
                shift;shift;;
            -S|--soundpath)
                soundpath="$2"
                shift;shift;;  

            -n|--notifier)
                notifier="$2"
                shift;shift;;

            *)
                args+=("$1")
                shift;;
        esac
    done

    # pick one of random sounds.
    if [ ${#sounds[@]} != 0 ]; then
        # shellcheck disable=SC2086
        # shellcheck disable=SC2048
        sound=$(pick-random ${sounds[*]})
    fi

    # play and notify.
    play -q "$soundpath/$sound.oga" &>/dev/null &
    $notifier -u "$urgency" -i "$icon" -a "wormboy-$app" "${args[*]}" "$body"
}

alias root-worm-alert="worm-alert -n \"root-notify-send\""

export -f worm-alert
