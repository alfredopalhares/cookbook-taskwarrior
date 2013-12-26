#! /usr/bin/env bats

@test "Finding task binary is a start" {
  run which task
  [ "$status" -eq 0 ]
}
