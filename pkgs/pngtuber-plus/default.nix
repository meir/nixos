{
  stdenv,
  lib,
  p7zip,
  fetchurl,
  version ? "v2025.07.22-build62",
  versionHash ? "sha256-Xxh5UE6MfD3fWOoOs2RA9daMkd3r+Lcdn0tHcDsw8zg=",
  ...
}:
let
  name = "pngtuber-plus-${version}";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchurl {
    url = "https://github.com/litruv/PNGTuber-Plus/releases/download/${version}/PNGTuber-Plus.exe";
    sha256 = versionHash;
  };

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin

    cp ${src} $out/bin/PNGTuber-Plus.exe
  '';

  outputs = [ "out" ];

  meta = {
    homepage = "https://github.com/litruv/PNGTuber-Plus";
    description = "PNGTuber-Plus";
    platforms = lib.platforms.all;
    maintainers = [ ];
    mainProgram = "PNGTuber-Plus.exe";
  };
}
