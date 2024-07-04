{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "dunst" { environment.packages = with pkgs; [ dunst ]; }
