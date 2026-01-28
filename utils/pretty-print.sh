#!/usr/bin/bash

: '
pretty fruit printing for user feedback.
'

info() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 5 ] && echo -e "\e[1;34m🫐  $@\e[0m"; }

success() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 5 ] && echo -e "\e[1;32m🥝 $@\e[0m"; }

debug() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 4 ] && echo -e "\e[1;35m🍇  $@\e[0m"; }

warning() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 3 ] && echo -e "\e[1;33m🍋 $@\e[0m"; }

danger() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 2 ] && echo -e "\e[1;33m🍊 $@\e[0m"; }

error() { [ -z "$WB_SILENT" ] && [ ${WB_LOG_LV:-5} -ge 1 ] && echo -e "\e[1;31m🍓 $@\e[0m"; }
