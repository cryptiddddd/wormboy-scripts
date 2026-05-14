#!/usr/bin/bash

: '
screenshot utility. recommended to make a convenient keybind for yourself.
'

# shellcheck disable=SC1091
source "/usr/local/lib/wormboy-utils"


function displayclipboard() {
    log "displaying image"
    # xclip -o -selection -clipboard -t image/png | xviewer
    display <(xclip -o -t image/png -selection clipboard)
    # xclip -o -selection clipboard | feh
}

function showsuccess() {
    dimensions=$(identify -format "%w × %h" <(xclip -o -selection clipboard))

    action=$(dunstify -u "LOW" -i edit-paste -a "screenshot" "copied to clipboard" "png, ($dimensions)" --action "view,view")
    if [[ "$action" == "view" ]]; then
        displayclipboard
    fi
}

function screenshot() {
    maim -q -s -u | xclip -selection clipboard -t image/png -i
    return "${PIPESTATUS[0]}"
}


if ! screenshot ; then
    log "screenshot cancelled by user."
    exit 1
else
    showsuccess
fi
