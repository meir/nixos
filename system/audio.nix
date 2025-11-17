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
    pulseaudio
  ];

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    extraConfig.pipewire = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.force-rate = 48000;
        default.allowed-rates = [
          44100
          48000
          88200
          96000
          192000
          384000
        ];
        default.clock.quantum = 4096;
        default.clock.min-quantum = 1024;
        default.clock.max-quantum = 8192;
      };
    };
  };

  protocol.hotkeys = [
    ''
      XF86Audio{Prev,Play,Next}
        hyprland | exec, ${lib.getExe pkgs.playerctl} {previous,play-pause,next}
        ${lib.getExe pkgs.playerctl} {previous,play-pause,next}
    ''
  ];
}
