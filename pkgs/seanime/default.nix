{ pkgs, makeDesktopItem }:

pkgs.stdenv.mkDerivation rec {
  pname = "seanime";
  version = "2.8.4";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-desktop-${version}_Linux_x86_64.AppImage";
    hash = "sha256-H8yqsgWEj+e0VvTDpvavsC0AVf9voI2nVDwsCzq8X8U=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "SeAnime";
      desktopName = "SeAnime";
      exec = "${pname}";
      icon = "seanime";
      type = "Application";
      categories = [
        "AudioVideo"
        "Network"
      ];
    })
  ];

  meta = {
    description = "Open-source media server with a web interface and desktop app for anime and manga";
    homepage = "https://github.com/5rahim/seanime";
    license = pkgs.lib.licenses.gpl3Only;
  };
}
