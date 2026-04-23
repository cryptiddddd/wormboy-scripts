#!/usr/bin/bash

pick-random() {
    expressions=("$@")
    if [ ${#expressions[@]} -eq 1 ]; then
        echo "${expressions[0]}"
        return
    fi
    RANDOM=$$$(date +%s)

    echo "${expressions[ $RANDOM % ${#expressions[@]} ]}"
}
