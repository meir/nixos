{
  stdenv,
  lib,
  nerd-font-patcher,
  cozette,
  ...
}:
let
  name = "cozette-nerdfont";
  version = "1.0";
in
stdenv.mkDerivation rec {
  inherit name version;

  buildInputs = [
    nerd-font-patcher
    cozette
  ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p "$out/share/fonts/"

    ${lib.getExe nerd-font-patcher} ${cozette}/share/fonts/misc/cozette.otb -out "$out/share/fonts"
  '';

  meta = {
    homepage = "";
    description = "Cozette font with Nerd Font patch";
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
