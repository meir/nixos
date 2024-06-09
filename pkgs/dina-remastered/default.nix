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
    hash = "sha256-0ZJ0Z2Y6wvZJm1YQr4O2Rr5Q9vJtLW1u3m6Tl4Z1n3w=";
  };

  buildInputs = [ nerd-font-patcher ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p "$out/share/fonts/"

    ${nerd-font-patcher}/bin/nerd-font-patcher $out/Fonts/DinaRemasterII.ttc -out "$out/share/fonts"
  '';

  meta = {
    homepage = "";
    description = "Dina Remaster font with Nerd Font patch";
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
