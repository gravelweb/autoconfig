#!/bin/bash

suffix=
installer=
if which apt >/dev/null 2>&1; then
    # debian
    suffix=apt
    installer=(apt install --yes)
fi

if [[ -z "{suffix}" ]]; then
    echo "Error: Unknown distribution, can't install prerequisites." >&2
    exit 1
fi

prereqfiles=($(find "$SOURCE" "${findargs[@]}" -name prereqs.${suffix} -print))
prereqs=()
for prereq in "${prereqfiles[@]}"; do
    prereqs+=($(grep -v '^[\s]*#' ${prereq}))
done

sudo "${installer[@]}" "${prereqs[@]}"
