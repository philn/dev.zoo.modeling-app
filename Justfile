app_name := "dev.zoo.modeling-app"

[private]
default:
    just --list --justfile {{ justfile() }}

build:
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak run org.flatpak.Builder --user --force-clean --install-deps-from=flathub --jobs=12 --repo=repo flatpak_app {{ app_name }}.yml
    flatpak build-bundle repo {{ app_name }}.flatpak {{ app_name }}

install:
    flatpak uninstall --user -y {{ app_name }}
    flatpak install --user -y {{ app_name }}.flatpak

run:
    flatpak run --env=GST_DEBUG=3 --user {{ app_name }}
