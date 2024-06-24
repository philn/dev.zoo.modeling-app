#!/bin/sh
set -eux

export HOME=$PWD
export CARGO_HOME=/run/build/ZooModelingApp/cargo-home
export PATH=$PATH:$CARGO_HOME/bin
export RUSTUP_HOME=/run/build/ZooModelingApp/rustup

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable
rustup target add wasm32-unknown-unknown

yarn config --offline set yarn-offline-mirror /run/build/ZooModelingApp/flatpak-node/yarn-mirror
yarn install --offline
yarn build:wasm
yarn build:local
yarn tauri build --no-bundle --features "" -c src-tauri/tauri.release.conf.json
