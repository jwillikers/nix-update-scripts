{
  lib,
  nushell,
  stdenvNoCC,
}:
let
  pname = "update-nixos-release";
in
if lib.versionOlder nushell.version "0.94" then
  throw "${pname} is not available for Nushell ${nushell.version}"
else
  stdenvNoCC.mkDerivation {
    pname = "update-nixos-release";
    version = "0.1.0";

    src = ./.;

    doCheck = true;

    buildInputs = [ nushell ];

    checkPhase = ''
      nu update-nixos-release-tests.nu
    '';

    installPhase = ''
      mkdir --parents $out/bin
      cp update-nixos-release.nu $out/bin/
    '';

    meta.mainProgram = "update-nixos-release.nu";
  }
