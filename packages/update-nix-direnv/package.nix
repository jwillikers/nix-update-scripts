{
  lib,
  nushell,
  stdenv,
}:
let
  pname = "update-nix-direnv";
in
if lib.versionOlder nushell.version "0.99" then
  throw "${pname} is not available for Nushell ${nushell.version}"
else
  stdenv.mkDerivation {
    inherit pname;
    version = "0.1.0";

    src = ./.;

    doCheck = true;

    buildInputs = [ nushell ];

    checkPhase = ''
      nu update-nix-direnv-tests.nu
    '';

    installPhase = ''
      mkdir --parents $out/bin
      cp update-nix-direnv.nu $out/bin/
    '';

    meta.mainProgram = "update-nix-direnv.nu";
  }
