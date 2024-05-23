{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.obs.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.modules.obs.enable {
    modules.packages = with pkgs;
      [
        (obs-studio.override {
          plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ];
        })
      ];
  };
}
