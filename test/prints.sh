#!/usr/bin/bash

source ./utils/pretty-print.sh

debug "this is a debug message"
info "this is an informational message."
success "this is a success message. good job!"
warning "this is a warning message... look out..."
danger "this is a danger message! be concerned!"
error "this is an error message. it's all over."

warning "now nothing will print...."

WB_LOG_LV=2

debug "this is a debug message"
info "this is an informational message."
success "this is a success message. good job!"
warning "this is a warning message... look out..."
danger "this is a danger message! be concerned!"
error "this is an error message. it's all over."
