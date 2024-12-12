{
  stdenv,
  lib,
  izu,
  hotkeys ? [ ],
  formatter ? "sxhkd",
  pkgs,
  system,
}:
with lib;
let
  name = "izu";
  izu' = izu.packages.${system}.default;
  cfg = pkgs.writeScript "config" (concatStringsSep "\n\n" hotkeys);
in
stdenv.mkDerivation {
  inherit name version;

  buildInputs = [ izu' ];

  phases = "installPhase";

  installPhase = ''
    izu --config ${cfg} --formatter ${formatter} > "$out"
  '';

  meta = {
    description = "izu";
    platforms = lib.platforms.all;
  };
}
