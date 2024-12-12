{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = mkIf config.protocol.xorg.enable {
    services.xserver.windowManager.bspwm.sxhkd.configFile = buildHkdrc;

    environment.defaultPackages = with pkgs; [ sxhkd ];

    protocol.autostart = [ "sxhkd &" ];

    hm.home.file.".config/sxhkd/sxhkdrc".source = readFile "${
      (pkgs.izu.override {
        hotkeys = config.protocol.hotkeys;
        formatter = "sxhkd";
      })
    }";
  };
}
