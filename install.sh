#!/usr/bin/bash

INSTALL_PATH="/usr/local/lib/wormboy-utils"

source $(dirname $0)/utils/pretty-print.sh
source $(dirname $0)/utils/checks.sh
rootcheck

cat $(dirname $0)/utils/*.sh > $INSTALL_PATH
chmod 554 "$INSTALL_PATH"
