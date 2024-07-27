{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "walld" {
  environment.packages = with pkgs; [
    walld
    sxiv
  ];

  bspwm.rules = [ "bspc rule -a sxiv state=floating" ];

  sxhkd.keybind = {
    "super + w" = ''
      wall-d -R -f -d ~/Pictures/backgrounds
    '';
  };
}
