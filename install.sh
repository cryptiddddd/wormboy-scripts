#!/usr/bin/bash

# config vars
SRC_DIR="$(dirname "$0")"

UTIL_INSTALL_PATH="/usr/local/lib/wormboy-utils"
SCRIPT_INSTALL_DIR="/usr/local/bin/"

# prep
source "$SRC_DIR/utils/pretty-print.sh"
source "$SRC_DIR/utils/checks.sh"
rootcheck


# compile/install utilities
log "rendering and installing..."
cat "$SRC_DIR"/utils/*.sh > $UTIL_INSTALL_PATH
chmod 554 "$UTIL_INSTALL_PATH"

success "utility library installed."


# install scripts

log "installing scripts...."
cp "$SRC_DIR"/scripts/* "$SCRIPT_INSTALL_DIR"
chmod 554 "$SCRIPT_INSTALL_DIR"/worm-*.sh
success "script library installed"

