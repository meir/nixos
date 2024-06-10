{
  stdenv,
  lib,
  gcc,
  fetchFromGitHub,
  ...
}:
let
  name = "cdl";
  version = "0.1.0";
in
stdenv.mkDerivation rec {
  inherit name version;

  src = fetchFromGitHub {
    owner = "meir";
    repo = "cdl";
    rev = "main";
    sha256 = "sha256-kaazkqHDzUxuz4RpK7SQg17h3cswtHcU7y8Funf1yh0=";
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

    chmod +x $out/bin/cdls
    chmod +x $out/bin/cdp
    chmod +x $out/bin/cdr
    chmod +x $out/bin/cds
  '';

  shellHook = ''
    cdl() {
      cd "$(cdp $1)";
    }
  '';

  outputs = [ "out" ];

  meta = {
    homepage = "https://github.com/meir/cdl";
    description = "Change Directory List (cdl) is a small directory waypoint tool for zsh";
    platforms = lib.platforms.all;
    maintainers = [ ];
    mainProgram = [
      "cdl"
      "cdls"
      "cdp"
      "cdr"
      "cds"
    ];
  };
}
