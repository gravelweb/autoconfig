#!/bin/bash

set -e

SCRIPT_DIR=$(dirname $(readlink -f $0))

# directory for vim swap files
mkdir -p ~/tmp

# Create python3 environment for syntastic. Hopefully python3 becomes the
# default soon enough, at which point this extra config can be dropped.
venvdir=~/.python3venv
if [[ ! -d "${venvdir}" ]]; then
    virtualenv -p python3 "${venvdir}"
fi
pushd "${venvdir}"
source bin/activate
pip install pylint pytest
deactivate
popd

# Install fzf binary
pushd "${SCRIPT_DIR}/vim.symlink/pack/bundle/start"
./fzf/install --key-bindings --completion --update-rc
popd

# Install ncm2 dependencies
pip3 install neovim
pip3 install jedi        # ncm2-jedi dependency
