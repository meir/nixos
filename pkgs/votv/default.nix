{
  stdenv,
  lib,
  p7zip,
  fetchurl,
  version ? "a09_0015_1",
  versionHash ? "sha256-k8YQK4HlLHY0ezwyh1pffiwpcNiBj6MrWU3wd0Qg3KE=",
  ...
}:
let
  name = "votv";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchurl {
    url = "https://archive.votv.zip/VDMR/${version}.7z";
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
