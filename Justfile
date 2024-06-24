app_name := "dev.zoo.modeling-app"

[private]
default:
    just --list --justfile {{ justfile() }}

init:
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install --user -y org.flatpak.Builder

build:
    flatpak run org.flatpak.Builder --user --force-clean --install-deps-from=flathub --jobs=12 --repo=repo flatpak_app {{ app_name }}.yml
    flatpak build-bundle repo {{ app_name }}.flatpak {{ app_name }}

install:
    flatpak uninstall --user -y {{ app_name }}
    flatpak install --user -y {{ app_name }}.flatpak

run:
    flatpak run --user {{ app_name }}
