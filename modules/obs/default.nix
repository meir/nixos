{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule {
  environment.packages = with pkgs; [
    (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })
  ];
}
