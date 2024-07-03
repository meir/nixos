{
  config,
  options,
  pkgs,
  lib,
  ...
}:
let
  vencord = false;
in
with lib;
mkModule "discord" {
  environment.packages = with pkgs; [ (unstable.discord.override { withVencord = vencord; }) ];
}
