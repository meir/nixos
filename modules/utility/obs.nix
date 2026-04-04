{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      ndi-6 = prev.ndi-6.overrideAttrs (oldAttrs: {
        src = prev.fetchurl {
          url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/${oldAttrs.installerName}.tar.gz";
          hash = "sha256-wLXfFzJIiGJ7ZSF8e4UNdQKHxS4z6WSF4qprESKeYD4=";
        };
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    ndi-6
  ];

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
      distroav
    ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Camera O" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
