{
  config,
  options,
  pkgs,
  lib,
  ...
}:
let
  xorg = config.protocol.xorg.enable;
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

  protocol.hotkeys =
    with pkgs;
    mkIf xorg { "XF86Audio{Prev,Play,Next}" = "${lib.getExe playerctl} {previous,play-pause,next}"; };
}
