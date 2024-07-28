{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "walld" {
  environment.packages = with pkgs; [
    (nsxiv.override { conf = ./nsxiv.conf.h; })
    walld
  ];

  bspwm.rules = [
    "bspc rule -a sxiv state=floating"
    "bspc rule -a nsxiv state=floating"
  ];

  sxhkd.keybind = {
    "super + w" = ''
      wall-d -R -f -d ~/Pictures/backgrounds
    '';
  };
}
