#!/usr/bin/env bats

@test "b64: input encode" {
  result="$(bin/b64 input "Hello World!")"
  [ "$result" = "SGVsbG8gV29ybGQh" ]
}

@test "b64: input decode" {
  result="$(bin/b64 input "SGVsbG8gV29ybGQh" --decode)"
  [ "$result" = "Hello World!" ]
}

@test "b64: pipe decode" {
  result="$(printf '%s' "Hello World!" | bin/b64)"
  [ "$result" = "SGVsbG8gV29ybGQh" ]
}
