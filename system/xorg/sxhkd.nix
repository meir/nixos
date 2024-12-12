{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = mkIf config.protocol.xorg.enable {
    environment.defaultPackages = with pkgs; [ sxhkd ];

    protocol.autostart = [ "sxhkd &" ];

    hm.home.file.".config/sxhkd/sxhkdrc".source = "${
      (pkgs.izu.override {
        hotkeys = config.protocol.hotkeys;
        formatter = "sxhkd";
      })
    }";
  };
}
