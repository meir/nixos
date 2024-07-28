{
  stdenv,
  lib,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  pname = "walld";
  version = "02db1883195dbd27509b9a87e20e898201ba0140";

  src = fetchFromGitHub {
    owner = "ronniedroid";
    repo = "Wall-d";
    rev = "02db1883195dbd27509b9a87e20e898201ba0140";
    hash = "sha256-CCLX9pbZE3K4MZbWfpX1STc09Zb1AbNvmPK1Djs4sak=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp ./wall-d $out/bin
    sed -i 's|sxiv|nsxiv|g' $out/bin/wall-d
  '';

  meta = {
    mainProgram = "wall-d";
    description = "A simple and fast wallpaper manager";
    homepage = "https://github.com/ronniedroid/Wall-d";
  };
}
