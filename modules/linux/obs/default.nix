{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.obs.enable = mkEnableOption "obs";

  config = mkIf config.modules.obs.enable {
    environment.systemPackages = with pkgs; [
      (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })
    ];
  };
}
