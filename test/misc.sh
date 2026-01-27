#!/usr/bin/bash

source ./utils/pretty-print.sh
source ./utils/process-control.sh

success "Script running :3"

info "Defining a test function..."

function doSomething() {
    info "Doing something with '$1'!"
    sleep ${1:-5}
}

for x in 1 2 3; do
    track doSomething $x
    warning "Some task has begun but may not complete."
done

info "Now awaiting all for completion"

# await-all
await-all info "Awaiting completion..."

success "All done!"

