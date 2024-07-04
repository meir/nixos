{
  config,
  pkgs,
  mkModule,
  ...
}:
let
  vencord = false;
in
mkModule config "discord" {
  environment.packages = with pkgs; [ (unstable.discord.override { withVencord = vencord; }) ];
}
