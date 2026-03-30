{
  stdenv,
  lib,
  p7zip,
  fetchurl,
  version ? "a09i_0001",
  versionHash ? "sha256-ZPetxvyZFO9xIbeQsnf7mRlesHckJADhaadu4PjGHvo=",
  ...
}:
let
  name = "votv-${version}";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchurl {
    url = "https://archive.votv.zip/VDMR/archive-mrdrnose-votv/${version}.7z";
    sha256 = versionHash;
  };

  buildInputs = [ p7zip ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin

    7z x ${src}

    mv ./*/WindowsNoEditor/* $out/bin/
  '';

  outputs = [ "out" ];

  meta = {
    homepage = "https://mrdrnose.itch.io/votv";
    description = "Voices of the Void";
    platforms = lib.platforms.all;
    maintainers = [ ];
    mainProgram = "votv";
  };
}
