#!/usr/bin/env bats

@test "version: parse version" {
  bin/version
}

@test "version: --invalid" {
  bin/version --invalid || return 0
}

@test "version: -h" {
  result="$(bin/version -h)"
  [[ "$result" == *Options* ]]
}

@test "version: --help" {
  result="$(bin/version --help)"
  [[ "$result" == *Options* ]]
}
