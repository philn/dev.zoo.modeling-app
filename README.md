# Generate zoo-desktop sources for use with cargo
<path-to flatpak-builder-tools>/cargo/flatpak-cargo-generator.py -o cargo-sources.json <path-to zoo-desktop>/src-tauri/Cargo.lock

# Generate zoo and zoo-desktop sources for use with npm
flatpak-node-generator --no-requests-cache -r -o node-sources.json yarn <path-to zoo-desktop>/yarn.lock
