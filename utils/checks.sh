#!/usr/bin/bash

function rootcheck() {
    if [ $EUID -ne 0 ]; then
        error "you must run as root."
        exit 1
    fi
}


