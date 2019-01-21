#!/bin/bash

if [[ -z "$(which rustup)" ]]; then
    curl https://sh.rustup.rs -sSf | sh
fi

rustup update

rustup component add rust-src
rustup component add rustfmt
rustup component add rls

if [[ -z "$(which racer)" ]]; then
    # racer not yet available on stable
    rustup install nightly
    cargo +nightly install racer
fi
