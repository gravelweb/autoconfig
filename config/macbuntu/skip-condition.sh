#!/bin/bash

set -e

uname -a | grep -q Ubuntu
test -d /sys/module/hid_apple
