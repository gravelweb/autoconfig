#!/bin/bash

set -eu

GIT_REPO=autoconfig
AUTOCONFIG_ZIP=~/.${GIT_REPO}.zip
AUTOCONFIG_DIR=~/.${GIT_REPO}

fatal() {
    echo "Error: $*"
    exit 1
}

user=gravelweb
branch=master
extras=()
for opt in "$@"; do
    case "${opt}" in
        user=*)     user=("${opt##user=}") ;;
        branch=*)   branch=("${opt##branch=}") ;;
        extra=*)    extras+=("${opt##extra=}") ;;
        *)
            fatal "Unrecognized argument ${opt}."
            ;;
    esac
done

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
    for extra in "${extras[@]}"; do
        echo "Info: Cloning config for extra="${extra}"..."
        if [[ "${extra}" == corsa ]]; then
            # TODO parameterize
            CORSA_CONFIG_DIR=config/corsa
            if [[ ! -d $CORSA_CONFIG_DIR ]]; then
                (git clone git@git.corp:jgravel/autoconfig-corsa.git \
                    $CORSA_CONFIG_DIR)
            fi
            CORSA_VIM_PLUGIN_DIR=config/vim/vim.symlink/plugin/corsa
            if [[ ! -d $CORSA_VIM_PLUGIN_DIR ]]; then
                (git clone git@git.corp:jgravel/autoconfig-corsa-vim.git \
                    $CORSA_VIM_PLUGIN_DIR)
            fi

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
