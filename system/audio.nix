{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{

  environment.systemPackages = with pkgs; [
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

  protocol.hotkeys = [
    ''
      XF86Audio{Prev,Play,Next}
        ${lib.getExe pkgs.playerctl} {previous,play-pause,next}
    ''
  ];
}
