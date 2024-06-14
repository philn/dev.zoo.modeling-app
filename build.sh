#!/bin/sh
set -eux

export HOME=$PWD
export PATH=$PATH:/app/cargo/bin

yarn config --offline set yarn-offline-mirror /run/build/ZooModelingApp/flatpak-node/yarn-mirror
yarn install --offline

pushd src/wasm-lib
wasm-pack build --target web --out-dir pkg -- --offline
cargo test -p kcl-lib export_bindings
popd
cp src/wasm-lib/pkg/wasm_lib_bg.wasm public

yarn build:local

yarn tauri build --no-bundle
