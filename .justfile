default: build

alias b := build

build derivation="update-nix-direnv":
    nix build '.#{{ derivation }}'

alias c := check

check: && format
    yamllint .
    asciidoctor **/*.adoc
    lychee --cache **/*.html

alias f := format
alias fmt := format

format:
    treefmt

alias r := run

run derivation="update-nix-direnv":
    nix run '.#{{ derivation }}'

alias t := test

test:
    nu update-nix-direnv-tests.nu
    nu update-nixos-release-tests.nu

alias u := update
alias up := update

update:
    nu update-nix-direnv.nu
    nu update-nixos-release.nu
    nix flake update
