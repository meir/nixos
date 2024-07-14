{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "droidcam" {
  security.polkit.enable = true;

  programs.droidcam.enable = true;
}
