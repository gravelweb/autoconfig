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
    sudo "${installer[@]}" "${prereqs[@]}"
}

prereqs_installed=

if which apt >/dev/null 2>&1; then
    if install_prereqs apt "apt install --yes"; then
        prereqs_installed=true
    fi
fi

if which snap >/dev/null 2>&1; then
    if install_prereqs snap.classic "snap install --classic"; then
        prereqs_installed=true
    fi
fi

if [[ -z "${prereqs_installed}" ]]; then
    echo "Error: Couldn't find any prerequisites, likely cause is unknown distribution." >&2
    exit 1
fi
