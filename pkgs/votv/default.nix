{
  stdenv,
  lib,
  p7zip,
  fetchurl,
  makeDesktopItem,
  makeWrapper,
  copyDesktopItems,
  umu-launcher,
  proton-ge-bin,
  steam-run,
  ...
}:
let
  desktopItem = makeDesktopItem {
    name = "votv";
    desktopName = "Voices of the Void";
    exec = "votv";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
  };
in
stdenv.mkDerivation (finalAttrs: {
  name = "votv";
  version = "0.9.0m";
  inherit desktopItem;

  src = fetchurl {
    url = "https://satellite9.com/VDMR/archive-mrdrnose-votv/a09m.7z";
    sha256 = "sha256-tEYNAiPp8pwkhIpQm46EjcN/rrcnOzEoafQQ0shGOR0=";
  };

  buildInputs = [ p7zip ];
  nativeBuildInputs = [ makeWrapper copyDesktopItems ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin $out/share/votv

    7z x ${finalAttrs.src}
    mv ./*/WindowsNoEditor/* $out/share/votv/

    cat > $out/bin/votv <<EOF
      #!/usr/bin/env bash
      set -euo pipefail

      export GAMEID="0"
      export PROTONPATH="${proton-ge-bin.steamcompattool}"
      export WINEPREFIX="\$HOME/.local/share/votv/prefix"
      mkdir -p "\$WINEPREFIX"

      cd "$out/share/votv"
      exec ${lib.getExe steam-run} ${lib.getExe umu-launcher} ./VotV.exe
    EOF

    chmod +x $out/bin/votv
  '';

  outputs = [ "out" ];
  
  desktopItems = [ desktopItem ];

  meta = {
    homepage = "https://mrdrnose.itch.io/votv";
    description = "Voices of the Void";
    platforms = lib.platforms.all;
    maintainers = [ ];
    mainProgram = "VotV";
  };
})
