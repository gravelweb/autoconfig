#!/bin/bash

configfiles=($(find "$SOURCE" "${findargs[@]}" -name config.sh -print))
for config in "${configfiles[@]}"; do
    echo "Running ${config}..."
    if [[ ! -x "${config}" ]]; then
        echo "Error: ${config} is not executable."
        exit 1
    fi
    "${config}"
done
