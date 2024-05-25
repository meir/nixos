{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.polybar.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.polybar.enable {
    modules.packages = with pkgs; [ polybar ];

    systemd.user.services.polybar = {
      enable = true;
      wantedBy = [ "default.target" ];
      description = "Polybar";
      script = ''
        ${pkgs.polybar}/bin/polybar mon0 &
        ${pkgs.polybar}/bin/polybar mon1 
      '';
    };

    environment.file.polybar = {
      source = ./polybar;
      target = ".config/polybar";
    };
  };
}
