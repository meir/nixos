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
        default.clock.rate = 44100;
        defautlt.allowed-rates = [ 44100 ];
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
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
