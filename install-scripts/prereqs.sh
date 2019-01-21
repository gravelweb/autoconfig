#!/bin/bash

function install_prereqs {
    local suffix=$1
    local installer=($2)

    local prereqfiles=($(find "$SOURCE" "${findargs[@]}" -name prereqs.${suffix} -print))
    local prereqs=()
    local prereq=
    for prereq in "${prereqfiles[@]}"; do
        prereqs+=($(grep -v '^[\s]*#' ${prereq}))
    done

    if [[ ${#prereqs[@]} == 0 ]]; then
        echo "No ${suffix} prereqs found"
        return 1
    fi

    echo "Installing ${suffix} prereqs"
    "${installer[@]}" "${prereqs[@]}"
}

prereqs_installed=

if uname -a | grep -q Ubuntu >/dev/null 2>&1; then
    sudo apt update
    sudo apt upgrade -V -y
    if install_prereqs apt "sudo apt install --yes"; then
        prereqs_installed=true
    fi
    if which snap >/dev/null 2>&1; then
        install_prereqs snap.classic "sudo snap install --classic"
    fi
    sudo apt autoremove -V -y
fi

if uname -a | grep -q Darwin; then
    if which brew >/dev/null 2>&1; then
        brew_try_upgrade=
        if ! install_prereqs brew "brew install"; then
            brew_try_upgrade=1
        fi
        if ! install_prereqs brew.cask "brew cask install"; then
            brew_try_upgrade=1
        fi

        if [[ $brew_try_upgrade ]]; then
            # some packages may be out of date
            if brew outdated > /dev/null; then
                # run brew again, but do upgrades now
                brew upgrade
            fi

            # check everything is up to date now
            brew_success=1
            if ! install_prereqs brew "brew install"; then
                brew_success=
            elif ! install_prereqs brew.cask "brew cask install"; then
                brew_success=
            fi
            [[ success ]] && prereqs_installed=true
        else
            prereqs_installed=true
        fi
    else
        # TODO automate brew install
        echo "Error: Couldn't install prereqs: Brew not installed."
    fi
fi

if [[ -z "${prereqs_installed}" ]]; then
    echo "Error: Couldn't find any prerequisites, likely cause is unknown distribution." >&2
    exit 1
fi
