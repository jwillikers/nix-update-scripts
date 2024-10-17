{
  nushell,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "update-nix-direnv";
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
