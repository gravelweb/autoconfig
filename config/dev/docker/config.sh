#!/bin/bash

# install docker if missing
if [[ -z "$(which docker)" ]]; then
    curl -fsSL get.docker.com | sh
fi
sudo usermod -aG docker $USER
