#!/usr/bin/bash
: '
    parameters: 1 is idx
'

declare -i IDX=$(cat /tmp/worm/$USER/help-page)

export mod=👽

print-options() {
    yq '.categories['$IDX'].entries[]' "$(dirname $0)/help-keybinds.yaml" | envsubst
}

# show as a message.

echo -en "\0message\x1f"$(print-options)""

echo $((IDX + 1)) > /tmp/worm/$USER/help-page

