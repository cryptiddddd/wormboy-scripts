#!/usr/bin/env bats

load 'test_helper/common-setup'

load alerts.sh


@test "low-urgency alert" {
    worm-alert -u low -a "bats-test" "hello world" -b "this is a test notification"
    dunstctl close
    data=$(dunstctl history | jq -r '.data[0][0]')
    assert_equal "$(echo "$data" | jq -r '.body.data')" "this is a test notification"
    assert_equal "$(echo "$data" | jq -r '.summary.data')" "hello world"
    assert_equal "$(echo "$data" | jq -r '.urgency.data')" "LOW"
}

@test "normal alert" {
    worm-alert -a "bats-test" "hello world" -b "this is a test notification"
    dunstctl close

    data=$(dunstctl history | jq -r '.data[0][0]')
    assert_equal "$(echo "$data" | jq -r '.urgency.data')" "NORMAL"
}

@test "urgent alert" {
    worm-alert -u critical -a "bats-test" "hello world" -b "this is an emergency notification"
    dunstctl close

    data=$(dunstctl history | jq -r '.data[0][0]')
    assert_equal "$(echo "$data" | jq -r '.urgency.data')" "CRITICAL"

}
