{ pkgs, lib }:

let
  makeDesktopItem = pkgs.makeDesktopItem;
in
pkgs.stdenv.mkDerivation rec {
  pname = "seanime";
  version = "2.8.4";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-desktop-${version}_Linux_x86_64.AppImage";
    hash = "sha256-H8yqsgWEj+e0VvTDpvavsC0AVf9voI2nVDwsCzq8X8U=";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
    pkgs.squashfsTools
  ];

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  unpackPhase = ''
    mkdir -p squashfs-root
    ${pkgs.squashfsTools}/bin/unsquashfs -f -d squashfs-root "$src"

    if [ -f squashfs-root/seanime.png ]; then
      cp squashfs-root/seanime.png .
    elif [ -f squashfs-root/usr/share/icons/hicolor/256x256/apps/seanime.png ]; then
      cp squashfs-root/usr/share/icons/hicolor/256x256/apps/seanime.png .
    fi
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/share/icons/hicolor/256x256/apps

    cp -r squashfs-root/* $out/

    makeWrapper $out/AppRun $out/bin/${pname} \
      --set PATH ${lib.makeBinPath [ pkgs.xdg-utils ]}

    if [ -f seanime.png ]; then
      cp seanime.png $out/share/icons/hicolor/256x256/apps/
    fi

    ${
      makeDesktopItem {
        name = "seanime";
        desktopName = "SeAnime";
        exec = pname;
        icon = "seanime";
        comment = "Open-source media server with a web interface and desktop app for anime and manga";
        categories = [
          "AudioVideo"
          "Network"
        ];
      }
    }/share/applications/seanime.desktop > $out/share/applications/seanime.desktop

    runHook postInstall
  '';

  meta = with lib; {
    description = "Open-source media server with a web interface and desktop app for anime and manga";
    homepage = "https://github.com/5rahim/seanime";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
