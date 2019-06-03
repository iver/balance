#!/usr/bin/env bash

# Version: 0.0.8-a0eca17
@test "No parameters" {
  run bash version.sh
  [ "$status" -eq 0 ]
  [[ "$output" =~ Version\:[0-9]+\.[0-9]+\.[0-9]+\-[[:alnum:]]{6,7} ]]
}
@test "With git source" {
  run bash version.sh -s git
  [ "$status" -eq 0 ]
  [[ "$output" =~ Version\:[0-9]+\.[0-9]+\.[0-9]+\-[[:alnum:]]{6,7} ]]
}
@test "With empty source" {
  run bash version.sh -s empty
  [ "$status" -eq 0 ]
  [[ "$output" =~ Version\:[0-9]+\.[0-9]+\.[0-9]+\-[[:alnum:]]{6,7} ]]
}
@test "With wildcard only" {
  run bash version.sh -s
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage: version.sh -s [git|empty]" ]
}
