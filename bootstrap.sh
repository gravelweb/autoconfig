#!/bin/bash

set -eu

GIT_REPO=autoconfig
AUTOCONFIG_ZIP=~/.${GIT_REPO}.zip
AUTOCONFIG_DIR=~/.${GIT_REPO}

fatal() {
    echo "Error: $*"
    exit 1
}

user=${1:-gravelweb}
branch=${2:-master}

if [[ -d "${AUTOCONFIG_DIR}" ]]; then
    echo "Info: ${AUTOCONFIG_DIR} directory already exists. Trying to update..."
    if [[ -z "$(which git)" ]]; then
        fatal "Git is not installed."
    fi

    pushd "${AUTOCONFIG_DIR}"
    if ! git config --local remote.origin.url; then
        git remote add origin git@github.com:${user}/${GIT_REPO}.git
    fi
    git remote update
    git branch -u origin/master
    #git reset --hard origin/master  # Dangerous
    git pull --rebase
    git submodule update --init
    for extra in ${#extras[@]} != 0 ]]; do
        echo "Info: Cloning config for extra="${extra}"..."
        if [[ "${extra}" == corsa ]]; then
            # TODO parameterize
            (cd config && \
                git clone git@git.corp:jgravel/autoconfig-corsa.git corsa)
        else
            fatal "Unknown extra."
        fi
    done
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
