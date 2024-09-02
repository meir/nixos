{ config, pkgs, ... }:
pkgs.mkModule config "obs" {
  environment.packages = with pkgs; [
    (wrapOBS { plugins = with obs-studio-plugins; [ obs-pipewire-audio-capture ]; })
  ];
}
