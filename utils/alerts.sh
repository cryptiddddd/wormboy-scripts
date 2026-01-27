#!/usr/bin/bash

function worm-alert() {
    # set defaults
    app="app"
    icon="info"
    urgency="normal"
    sound="message"
    body=""
    soundpath="/usr/share/sounds/freedesktop/stereo"

    sounds=()

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

            *)
                POS_ARGS+=("$1")
                shift;;
        esac
    done

    # pick one of random sounds.
    if [ ${#sounds[@]} != 0 ]; then
        sound=$(pick-random ${sounds[*]})
    fi

    # play and notify.
    play -q $soundpath/$sound.oga &>/dev/null &
    notify-send -u "$urgency" -i "$icon" -a "wormboy-$app" "${POS_ARGS[*]}" "$body"
}
