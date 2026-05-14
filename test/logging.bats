#!/usr/bin/env bats

load 'test_helper/common-setup'

load pretty-print.sh


setup() {
    unset WB_SILENT
    unset WB_LOG_V
}

@test "can run file" {
    run pretty-print.sh
}

@test "basic log level" {
    output=$( log "blueberry!" 3>&1 )
    assert_output --partial "🫐"
}

@test "success log level" {
    output=$( success "kii!" 3>&1 )
    assert_output --partial "🥝"
}

@test "debug log level" {
    output=$( debug "grapes!" 3>&1 )
    assert_output --partial "🍇"
}

@test "warning log level" {
    output=$( warning "lemon!" 3>&1 )
    assert_output --partial "🍋"
}

@test "danger log level" {
    output=$( danger "orange!" 3>&1 )
    assert_output --partial "🍊"
}

@test "error log level" {
    output=$( error "strawberry!" 3>&1 )
    assert_output --partial "🍓"
}

@test "critical log level" {
    output=$( critical "explosion!" 3>&1 )
    assert_output --partial "💥💥💥"
}


# ## tab levels
@test "tab level test" {
    output=$(success -t 4 "hello world" 3>&1)
    assert_output --partial "    🥝"

    output=$(warning -t 8 "hello world" 3>&1)
    assert_output --partial "    🍋"
}


# ## silence levels
@test "silent" {
    output=$(error "hello!" 3>&1)
    assert_output

    export WB_SILENT=1
    output=$( warning "helo" 3>&1 )
    refute_output
}

@test "hide level output" {
    output=$(log "should see!" 3>&1)
    assert_output

    export WB_LOG_LV=4
    output=$( log "should not see!" 3>&1 )
    refute_output 

    export WB_LOG_LV=2
    output=$( danger "should not see!" 3>&1 )
    refute_output 

    export WB_LOG_LV=5
    output=$( success "should see!" 3>&1 )
    assert_output
}
