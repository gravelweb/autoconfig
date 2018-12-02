#!/bin/bash

bindir=$HOME/bin
mkdir -p "${bindir}"

binfiles=($(find "$SOURCE" "${findargs[@]}" -print | egrep '[^/]\.bin$'))
for bin in "${binfiles[@]}"; do
    basename=${bin##*/}
    dest=${bindir}/${basename%.*}
    if [[ -e "${dest}" ]]; then
        if [[ "$(readlink -- "${dest}")" == "${bin}" ]]; then
            echo "Bin already set: ${dest}"
            continue
        fi
        echo "Bin ${dest} exists: "
        echo "options:"
        echo "  * [o]verride"
        echo "  * [b]ackup and override"
        echo "  * [s]kip"
        echo -n "Choose an option: "
        fini="false"
        skip="false"
        while [[ "${fini}" == "false" ]]; do
            read bin__option
            fini="true"
            case "${bin__option}" in
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
                    echo "Unknown option: ${bin__option}"
                    fini="false"
                    ;;
            esac
        done
        if [[ "${skip}" == "true" ]]; then
            echo "Skipped ${dest}"
            continue
        fi
    fi
    ln -vs ${bin} ${dest}
done
