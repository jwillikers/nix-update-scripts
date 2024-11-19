{
  lib,
  nushell,
  stdenvNoCC,
}:
if lib.versionOlder nushell.version "0.99" then
  throw "update-nix-direnv is not available for Nushell ${nushell.version}"
else
  stdenvNoCC.mkDerivation {
    pname = "update-nix-direnv";
    version = "0.1.0";

    src = ./.;

    doCheck = true;

    buildInputs = [ nushell ];

    checkPhase = ''
      runHook preCheck
      nu update-nix-direnv-tests.nu
      runHook postCheck
    '';

    installPhase = ''
      runHook preInstall
      install -D --mode=0755 --target-directory=$out/bin update-nix-direnv.nu
      runHook postInstall
    '';

    meta.mainProgram = "update-nix-direnv.nu";
  }
