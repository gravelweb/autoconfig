#!/bin/bash

set -eu

GIT_REPO=autoconfig
AUTOCONFIG_ZIP=~/.${GIT_REPO}.zip
AUTOCONFIG_DIR=~/.${GIT_REPO}

user=${1:-gravelweb}
branch=${2:-master}

if [[ -d "${AUTOCONFIG_DIR}" ]]; then
    echo "Info: ${AUTOCONFIG_DIR} directory already exists."
    if ! (cd "${AUTOCONFIG_DIR}" && git pull --rebase); then
        echo "Error: Failed to update git repo."
    fi
else
    # Download autoconfig project from github
    # TODO convert to git clone over https
    wget \
        "https://github.com/${user}/${GIT_REPO}/archive/${branch}.zip" \
        -O "${AUTOCONFIG_ZIP}"
    unzip "${AUTOCONFIG_ZIP}" -d "${AUTOCONFIG_DIR}"
    mv "${AUTOCONFIG_DIR}/${GIT_REPO}-${branch}"/* "${AUTOCONFIG_DIR}/"
    rm -r "${AUTOCONFIG_DIR}/${GIT_REPO}-${branch}"
fi


# Run the autoconfig!
(cd ${AUTOCONFIG_DIR} && ./install.sh)
