{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      # deadnix: skip
      self,
      nixpkgs,
      flake-utils,
      pre-commit-hooks,
      treefmt-nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ ];
        pkgs = import nixpkgs { inherit system overlays; };
        lib = import ./lib { inherit self system; };
        packages = import ./packages { inherit pkgs; };
        pre-commit = pre-commit-hooks.lib.${system}.run (
          import ./pre-commit-hooks.nix { inherit pkgs treefmtEval; }
        );
        treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
      in
      with pkgs;
      {
        apps =
          builtins.listToAttrs (
            builtins.map (package: pkgs.lib.attrsets.nameValuePair package (lib.mkApp package)) (
              builtins.attrNames packages
            )
          )
          // {
            default = self.apps.${system}.update-nix-direnv;
          };
        devShells.default = mkShell {
          inherit (pre-commit) shellHook;
          nativeBuildInputs =
            with pkgs;
            [
              asciidoctor
              fish
              just
              lychee
              nushell
              treefmtEval.config.build.wrapper
              # Make formatters available for IDE's.
              (builtins.attrValues treefmtEval.config.build.programs)
            ]
            ++ pre-commit.enabledPackages;
        };
        formatter = treefmtEval.config.build.wrapper;
        packages = packages // {
          default = self.packages.${system}.update-nix-direnv;
        };
      }
    );
}
