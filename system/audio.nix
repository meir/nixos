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
    wireplumber = {
      enable = true;
      extraConfig = {
        "99-alsa-config" = {
          "context.properties" = {
            "api.alsa.headroom" = 8192;
            "api.alsa.period-size" = 128;
          };
        };
      };
    };
    extraConfig.pipewire = {
      context.properties = {
        default.clock.rate = 384000;
        defautlt.allowed-rates = [
          44100
          48000
          88200
          96000
          192000
          384000
        ];
        default.clock.quantum = 256;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 1024;
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
