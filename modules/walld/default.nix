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

  protocol.rules = [ "bspc rule -a Nsxiv state=floating" ];

  protocol.hotkeys = {
    "super + w" = ''
      wall-d -R -f -d ~/Pictures/backgrounds
    '';
  };
}
