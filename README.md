
# How to build and test the flatpak

The commands are listed in a `Justfile`, you basically need to install flatpak
(should be packaged in your ditro) and [Just](https://github.com/casey/just).
Then run `just init` once for the initial setup.

To build the flatpak, run `just build`. That will produce a
`dev.zoo.modeling-app.flatpak` bundle.

To install the flatpak bundle locally, run `just install`.

To start the locally installed application, `just run`.

# How to generate the offline build source files

Currently those files are bundled in the repo. They will need to be updated for
each new version of the app.

First of all, the `flatpak-builder-tools` submodule needs to be patched, as a
workaround for [this issue](https://github.com/flatpak/flatpak-builder-tools/issues/408):

```shell
pushd flatpak-builder-tools
cat ../node-generator.diff | patch -p1
pushd node
pipx install . --force
popd
popd
```

The NodeJS source files for offline build can then be generated with:

```shell
flatpak-node-generator --no-requests-cache -r -o node-sources.json yarn /path/to/kitty-cad-checkout/yarn.lock
```

And finally, the Rust crates source files for offline building:

```shell
python flatpak-builder-tools/cargo/flatpak-cargo-generator.py -o cargo-sources.json /path/to/kitty-cad-checkout/src-tauri/Cargo.lock
python flatpak-builder-tools/cargo/flatpak-cargo-generator.py -o cargo-wasm-sources.json /path/to/kitty-cad-checkout/src/wasm-lib/Cargo.lock
```
