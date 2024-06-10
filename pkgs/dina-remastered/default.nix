{
  stdenv,
  lib,
  nerd-font-patcher,
  fetchFromGitHub,
  ...
}:
let
  name = "dina-remastered";
  version = "1.0";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchFromGitHub {
    owner = "zshoals";
    repo = "Dina-Font-TTF-Remastered";
    rev = "master";
    hash = "sha256-TwK1Mh5+8arSQ6K9OFtJfigRae3ovYpNZJgmW6yjt0c=";
  };

  buildInputs = [ nerd-font-patcher ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p "$out/share/fonts/"

    ${lib.getExe nerd-font-patcher} ${src}/Fonts/DinaRemasterII.ttc -out "$out/share/fonts"
  '';

  meta = {
    homepage = "";
    description = "Dina Remaster font with Nerd Font patch";
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
