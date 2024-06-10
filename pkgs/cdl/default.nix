{
  stdenv,
  lib,
  gcc,
  fetchFromGitHub,
  ...
}:
let
  name = "cdl";
  version = "0.1.1";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchFromGitHub {
    owner = "meir";
    repo = "cdl";
    rev = "v${version}";
    sha256 = "sha256-UO5717EiCDHIDc0suQ82GJUM+Hbnq5HwvSJZ4xHJEGs=";
  };

  buildInputs = [ gcc ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin
    rm -rf $out/bin/*

    ${lib.getExe gcc} -o $out/bin/cdls ${src}/src/cache/cache.c ${src}/src/cdls.c
    ${lib.getExe gcc} -o $out/bin/cdp ${src}/src/cache/cache.c ${src}/src/cdp.c
    ${lib.getExe gcc} -o $out/bin/cdr ${src}/src/cache/cache.c ${src}/src/cdr.c
    ${lib.getExe gcc} -o $out/bin/cds ${src}/src/cache/cache.c ${src}/src/cds.c

    echo 'cdl() { cd "$(cdp $1)" }' > $out/bin/cdl-alias

    chmod +x $out/bin/cdls
    chmod +x $out/bin/cdp
    chmod +x $out/bin/cdr
    chmod +x $out/bin/cds
    chmod +x $out/bin/cdl-alias
  '';

  outputs = [ "out" ];

  meta = {
    homepage = "https://github.com/meir/cdl";
    description = "Change Directory List (cdl) is a small directory waypoint tool for zsh";
    platforms = lib.platforms.all;
    maintainers = [ ];
    mainProgram = [
      "cdls"
      "cdp"
      "cdr"
      "cds"
    ];
  };
}
