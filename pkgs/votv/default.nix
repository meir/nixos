{
  stdenv,
  lib,
  p7zip,
  fetchurl,
  version ? "a09e_0008",
  versionHash ? "sha256-2T00hIv2g7IiGUAudj0zvRyXG7bfkf0zEn9BtqtIEDg=",
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
