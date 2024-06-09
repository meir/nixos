{ stdenv, lib }:
stdenv.mkDerivation rec {
  pname = "cozette-nerdfont";
  version = "1.0";
  buildInputs = [
    nerdfont-patcher
    cozette
  ];
  installPhase = ''
    set -euo pipefail
    echo "Patching fonts..."
    mkdir -p "$out/share/fonts/"

    ${nerd-font-patcher} ${cozette}/share/fonts/misc/cozette.otb -out "$out/share/fonts"

    install -Dm644 -t "$out/share/fonts" "$out"/share/fonts/*.otb
  '';
}
