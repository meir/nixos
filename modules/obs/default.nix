{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.obs.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.obs.enable {
    modules.packages = with pkgs;
      [
        (wrapOBS {
          plugins = with obs-studio-plugins; [
            obs-pipewire-audio-capture
          ];
        })
      ];
  };
}
