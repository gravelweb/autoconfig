#!/bin/bash

symlinkfiles=($(find "$SOURCE" "${findargs[@]}" -name '*.symlink' -print))
for symlink in "${symlinkfiles[@]}"; do
    basename=${symlink##*/}
    dest=~/.${basename%.*}
    if [[ -e "${dest}" ]]; then
        echo "Skipping override of ${dest}..."
        continue
    fi
    ln -vs ${symlink} ${dest}
done
