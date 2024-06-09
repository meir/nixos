{
  stdenv,
  lib,
  gcc,
  environment,
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
    rev = "v${version}"; # https://github.com/meir/cdl/tree/v0.1.0
    hash = "sha256-TwK1Mh5+8arSQ6K9OFtJfigRae3ovYpNZJgmW6yjt0c=";
  };

  buildInputs = [ gcc ];

  phases = "installPhase";

  installPhase = ''
    mkdir -p $out/bin

    gcc -o $out/bin/cdl src/cache/cache.c src/cdls.c
    gcc -o $out/bin/cdl src/cache/cache.c src/cdp.c
    gcc -o $out/bin/cdl src/cache/cache.c src/cdr.c
    gcc -o $out/bin/cdl src/cache/cache.c src/cds.c

    chmod +x $out/bin/cdls
    chmod +x $out/bin/cdp
    chmod +x $out/bin/cdr
    chmod +x $out/bin/cds
  '';

  environment.shellInit = ''
    cdl() {
      cd "$(cdp $1)";
    }
  '';

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
