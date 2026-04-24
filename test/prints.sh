#!/usr/bin/bash

source ./utils/pretty-print.sh


debug "this is a debug message"
log "this is an informational message."
success "this is a success message. good job!"
warning "this is a warning message... look out..."
danger "this is a danger message! be concerned!"
error "this is an error message. it's all over."
critical "this is an critical message. it's REALLY all over."


log "this is a logged message"
log -t 4 "this is a nested message"
log -t 4 "this is a nested message"
log -t 8 "this is a nested message"
log -t 4 "this is a nested message"


# function processWithLog() {
#     for i in 1 2 3 4; do
#         log "getting number..."
#         echo "number: $i"
#         success "number fetched: $i"
#     done
# }

# # processWithLog | grep --color=auto "4"
# # processWithLog | grep "🫐"

# log "running.."
# output=$(processWithLog | grep "4")

# log "calculating or something?"

# echo "$output"


