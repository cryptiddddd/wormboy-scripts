#!/usr/bin/env bash

bats_require_minimum_version 1.13.0

DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
PATH="$DIR/../utils:$PATH"
unset DIR

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
