{ pkgs, ... }:
{
  update-nix-direnv = pkgs.callPackage ./update-nix-direnv/package.nix { };
  update-nixos-release = pkgs.callPackage ./update-nixos-release/package.nix { };
}
