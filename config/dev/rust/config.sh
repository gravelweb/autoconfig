#!/bin/bash

if [[ -z "$(which rustup)" ]]; then
    curl https://sh.rustup.rs -sSf | sh
fi

rustup update

rustup toolchain add nightly
rustup component add rust-src
rustup component add rustfmt-preview

if [[ -z "$(which racer)" ]]; then
    cargo +nightly install racer
fi
