#!/bin/bash

set -e

# configure git settings
if ! git config --global --get user.email >/dev/null 2>&1
then
    echo -n "Please provide Git user.email: "
    read useremail
    git config --global user.email "${useremail}"
fi

if ! git config --global --get user.name >/dev/null 2>&1
then
    echo -n "Please provide Git user.name: "
    read username
    git config --global user.name "${username}"
fi

# configure ssh keys
if [[ ! -e ~/.ssh/id_rsa ]]; then
    if [[ -z "${useremail}" ]]; then
        echo -n "Please provide Git user.email: "
        read useremail
    fi
    ssh-keygen -t rsa -b 4096 -C "${useremail}"
fi
