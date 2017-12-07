#!/bin/bash

sudo apt update
sudo apt upgrade -V -y

git submodule update --init

SOURCE="$(pwd)/config/"

skiplist=()
for skiptest in $(find "$SOURCE" -name 'skip-condition.*'); do
    if ! "$skiptest"; then
        skiplist+=($(dirname "$skiptest"))
    fi
done

findargs=()
if [[ -n "${skiplist[@]}" ]]; then
    findargs+=(-type d \()
    echo "Blacklisted the following directories:"

    for skipdir in "${skiplist[@]}"; do
        echo " * ${skipdir}"
        findargs+=(-path "${skipdir}" -o)
    done

    echo

    # remove last '-o'
    unset 'findargs[${#findargs[@]}-1]'
    findargs+=(\) -prune -o)
fi

echo "Installing prerequisites........."
source ./install-scripts/prereqs.sh
echo ".............................done"

echo ""

echo "Installing symlinks.............."
source ./install-scripts/symlinks.sh
echo ".............................done"

echo ""

echo "Installing configuration........."
source ./install-scripts/configs.sh
echo ".............................done"
