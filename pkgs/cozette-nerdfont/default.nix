{ stdenv, lib }:
let
  name = "cozette-nerdfont";
  version = "1.0";
in
stdenv.mkDerivation rec {
  inherit name version;

  buildInputs = [
    nerdfont-patcher
    cozette
  ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p "$out/share/fonts/"

    ${nerd-font-patcher} ${cozette}/share/fonts/misc/cozette.otb -out "$out/share/fonts"

    install -Dm644 -t "$out/share/fonts" "$out"/share/fonts/*.otb
  '';

  meta = {
    homepage = "";
    description = "Cozette font with Nerd Font patch";
    license = lib.licenses.ofPackage cozette;
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
