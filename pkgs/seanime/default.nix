{
  pkgs,
  lib,
  makeDesktopItem,
}:
pkgs.stdenv.mkDerivation rec {
  pname = "seanime";
  version = "2.8.4";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-desktop-${version}_Linux_x86_64.AppImage";
    hash = "sha256-H8yqsgWEj+e0VvTDpvavsC0AVf9voI2nVDwsCzq8X8U=";
  };

  desktopItem = makeDesktopItem {
    name = "seanime";
    desktopName = "SeAnime";
    exec = pname;
    icon = "application-x-executable"; # Using a generic icon
    comment = "Open-source media server with a web interface and desktop app for anime and manga";
    categories = [
      "AudioVideo"
      "Network"
    ];
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications $out/opt/${pname}

    # Copy the AppImage
    cp $src $out/opt/${pname}/${pname}.AppImage
    chmod +x $out/opt/${pname}/${pname}.AppImage

    # Create wrapper script
    makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/${pname} \
      --add-flags "$out/opt/${pname}/${pname}.AppImage"

    cat ${desktopItem} > $out/share/applications/${pname}.desktop

    runHook postInstall
  '';

  meta = with lib; {
    description = "Open-source media server with a web interface and desktop app for anime and manga";
    homepage = "https://github.com/5rahim/seanime";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
