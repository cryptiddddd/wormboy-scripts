#!/usr/bin/bash

source ./utils/pretty-print.sh

# debug "this is a debug message"
# info "this is an informational message."
# success "this is a success message. good job!"
# warning "this is a warning message... look out..."
# danger "this is a danger message! be concerned!"
# error "this is an error message. it's all over."


function processWithLog() {
    for i in 1 2 3 4; do
        info "getting number..."
        echo "number: $i"
        success "number fetched: $i"
    done
}

# processWithLog | grep --color=auto "4"
# processWithLog | grep "🫐"

info "running.."
output=$(processWithLog | grep "4")

info "calculating or something?"

echo "$output"


