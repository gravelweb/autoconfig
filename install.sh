#!/bin/bash

sudo --validate  # refresh sudo timeout

# Ensure the script is always ran from the same location
ABS_PATH=~/.autoconfig
if ! cd "$ABS_PATH"; then
    echo "Expected installation location: $ABS_PATH"
    exit 1
fi

git submodule update --init
git pull --rebase

SOURCE="$(pwd)/config"

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

echo "Running configuration........."
source ./install-scripts/configs.sh
echo ".............................done"

echo ""

echo "Installing symlinks.............."
source ./install-scripts/symlinks.sh
echo ".............................done"
