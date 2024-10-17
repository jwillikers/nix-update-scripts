{
  nushell,
  stdenv,
}:
stdenv.mkDerivation {
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
