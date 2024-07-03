{
  config,
  options,
  pkgs,
  lib,
  mkModule,
  ...
}:
let
  vencord = false;
in
mkModule "discord" {
  environment.packages = with pkgs; [ (unstable.discord.override { withVencord = vencord; }) ];
}
