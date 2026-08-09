#!/usr/bin/bash

dir=$(dirname $0)

echo "0" > /tmp/worm/$USER/help-page

# echos all the modi parameters yay
echo-modi() {
    declare -i idx=0
    readarray catmap < <(yq e -I=0 '.categories[].title' $dir/help-keybinds.yaml)

    echo -n "-modi "

    while IFS=$'\t' read -r title _; do
        echo -n "$title:$dir/modi-keybind-page.sh,"
        (( idx ++ ))
    done < <(yq e '.categories[] | [.title] | @tsv' "$dir/help-keybinds.yaml")
}


rofi $(echo-modi) -show $(yq '.categories[0].title' $dir/help-keybinds.yaml) -theme message
echo-modi
# echo
