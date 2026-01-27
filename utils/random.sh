#!/usr/bin/bash

pick-random() {
    expressions=("$@")
    RANDOM=$$$(date +%s)

    echo ${expressions[ $RANDOM % ${#expressions[@]} ]}
}
