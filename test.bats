#!/usr/bin/env bats

#BATS_ERROR_STACK_TRACE=()

setup() {
    # Source in ecs-deploy
    TEST_ENV=true
    . "ecs-cf-deploy"
}

@test "check that usage() returns string and exits with status code 3" {
  run usage
  echo $status
  [ $status -eq 3 ]
}

@test "test assertRequiredArgumentsSet success" {
  ECS_SERVICE_STACK=true
  ECS_CLUSTER_STACK=false
  ACCOUNT_ID=false
  CROSS_ACCOUNT_ROLE=false
  run assertRequiredArgumentsSet
  [ ! -z $status ]
}
@test "test assertRequiredArgumentsSet missing ECS_SERVICE_STACK (status=5)" {
  run assertRequiredArgumentsSet
  [ $status -eq 5 ]
}
@test "test assertRequiredArgumentsSet missing ECS_CLUSTER_STACK (status=6)" {
  ECS_SERVICE_STACK=example
  run assertRequiredArgumentsSet
  [ $status -eq 6 ]
}
@test "test assertRequiredArgumentsSet missing ACCOUNT_ID (status=7)" {
  ECS_SERVICE_STACK=example
  ECS_CLUSTER_STACK=example
  run assertRequiredArgumentsSet
  [ $status -eq 7 ]
}
@test "test assertRequiredArgumentsSet missing CROSS_ACCOUNT_ROLE (status=8)" {
  ECS_SERVICE_STACK=true
  ECS_CLUSTER_STACK=false
  ACCOUNT_ID=false
  run assertRequiredArgumentsSet
  [ $status -eq 8 ]
}
@test "test require missing command (status=4)" {
  run require notexistingcommand
  [ $status -eq 4 ]
}
@test "test require sh (status=0)" {
  run require sh
  [ $status -eq 0 ]
}
