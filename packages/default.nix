{ pkgs, unstablePkgs, ... }:
{
  # Nushell's hashing functions used in update-nix-direnv are only available in new versions.
  update-nix-direnv = unstablePkgs.callPackage ./update-nix-direnv/package.nix { };
  update-nixos-release = pkgs.callPackage ./update-nixos-release/package.nix { };
}
