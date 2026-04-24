#!/bin/bash/env bats

DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
PATH="$DIR/../utils:$PATH"
unset DIR

bats_require_minimum_version 1.12.0

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

load pretty-print.sh

# exec 3>/dev/null

@test "can run file" {
    run pretty-print.sh
    assert_output ""
}


@test "lemon" {
    run warning "lemon?" 
    [ "$status" -eq 0 ]
}
