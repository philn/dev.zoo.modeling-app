[private]
default:
    just --list --justfile {{ justfile() }}

build:
    flatpak run org.flatpak.Builder --user --force-clean --install-deps-from=flathub --jobs=12 flatpak_app/release dev.zoo.modeling-app.yml
