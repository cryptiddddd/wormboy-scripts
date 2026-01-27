#!/usr/bin/bash

source ./utils/alerts.sh
source ./utils/random.sh

worm-alert -u low -a testing -s bell -s message "this is my title" -b "test message"

worm-alert -u critical -a testing "message 2" -b "this sound does not exist" -s "LA"
