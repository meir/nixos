{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "walld" {
  environment.packages = with pkgs; [
    (nsxiv.override { conf = lib.readFile ./nsxiv.conf.h; })
    walld
  ];

  bspwm.rules = [ "bspc rule -a Nsxiv state=floating" ];

  sxhkd.keybind = {
    "super + w" = ''
      wall-d -R -f -d ~/Pictures/backgrounds
    '';
  };
}
