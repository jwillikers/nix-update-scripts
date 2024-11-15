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
      runHook preCheck
      nu update-nixos-release-tests.nu
      runHook postCheck
    '';

    installPhase = ''
      runHook preInstall
      install -D --mode=0755 --target-directory=$out/bin update-nixos-release.nu
      runHook postInstall
    '';

    meta.mainProgram = "update-nixos-release.nu";
  }
