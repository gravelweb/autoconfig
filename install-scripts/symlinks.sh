#!/bin/bash

symlinkfiles=($(find "$SOURCE" "${findargs[@]}" -name '*.symlink' -print))
for symlink in "${symlinkfiles[@]}"; do
    basename=${symlink##*/}
    dest=~/.${basename%.*}
    if [[ -e "${dest}" ]]; then
        if [[ "$(readlink -- "${dest}")" == "${symlink}" ]]; then
            echo "Symlink already set: ${dest}"
            continue
        fi
        echo "Symlink ${dest} exists: "
        echo "options:"
        echo "  * [o]verride"
        echo "  * [b]ackup and override"
        echo "  * [s]kip"
        echo -n "Choose an option: "
        fini="false"
        skip="false"
        while [[ "${fini}" == "false" ]]; do
            read symlink__option
            fini="true"
            case "${symlink__option}" in
                o|override)
                    rm -rf "${dest}"
                    ;;
                b|backup)
                    mv "${dest}" "${dest}.bkp"
                    ;;
                s|skip)
                    skip="true"
                    ;;
                *)
                    echo "Unknown option: ${symlink__option}"
                    fini="false"
                    ;;
            esac
        done
        if [[ "${skip}" == "true" ]]; then
            echo "Skipped ${dest}"
            continue
        fi
    fi
    ln -vs ${symlink} ${dest}
done
