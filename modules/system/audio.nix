{
  config,
  options,
  pkgs,
  lib,
  ...
}:
let
  hotkeys = with pkgs; {
    xorg = {
      "XF86Audio{Prev,Play,Next}" = "${lib.getExe playerctl} {previous,play-pause,next}";
    };
    wayland = {
      "XF86AudioPrev" = "${lib.getExe playerctl} previous";
      "XF86AudioPlay" = "${lib.getExe playerctl} play-pause";
      "XF86AudioNext" = "${lib.getExe playerctl} next";
    };
  };
in
with lib;
{

  environment.packages = with pkgs; [
    alsa-utils
    libdrm
    pavucontrol
    alsa-oss
    helvum
    playerctl
  ];

  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  protocol.hotkeys = hotkeys."${config.protocol.type}";
}
