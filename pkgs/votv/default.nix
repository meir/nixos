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
  version ? "a09j_0001",
  versionHash ? "sha256-3qpCNHhx1PDU5zts1mW3UVfCtjty/7kJawCSx+EV6X8=",
  ...
}:
let
  name = "votv-${version}";
  desktopItem = makeDesktopItem {
    name = name;
    desktopName = "Voices of the Void";
    comment = "Voices of the Void";
    exec = "votv";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "votv";
  inherit name version desktopItem;

  src = fetchurl {
    url = "https://archive.votv.zip/VDMR/archive-mrdrnose-votv/${version}.7z";
    sha256 = versionHash;
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
