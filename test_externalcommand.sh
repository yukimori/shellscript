#!/usr/bin/env bash

exec 1> >(tee log.test_externalcommand_sh)
echo_pid() { echo "$@ $$ $BASHPID $BASH_SUBSHELL"; }

echo_pid 1

python test_externalcommand.py


