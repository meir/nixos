{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "seanime";
  version = "2.8.4";

  src = pkgs.fetchurl {
    url = "https://github.com/5rahim/seanime/releases/download/v${version}/seanime-desktop-${version}_Linux_x86_64.AppImage";
    hash = "sha256-Yjt+Oq42QMd4H6MtzZlSaDYav5EEOakYkWTCxzyc8M4=";
  };

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    mv $src $out/bin
  '';

  desktopItems = [
    {
      name = "SeAnime";
      exec = "${pname}";
      icon = "seanime";
      type = "Application";
      categories = [
        "AudioVideo"
        "Network"
      ];
    }
  ];

  meta = {
    description = "Open-source media server with a web interface and desktop app for anime and manga";
    homepage = "https://github.com/5rahim/seanime";
    license = pkgs.lib.licenses.gpl3Only;
  };
}
