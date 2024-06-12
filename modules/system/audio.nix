{
  config,
  options,
  pkgs,
  lib,
  ...
}:
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

  services.pipewire = {
    enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  sxhkd.keybind = with pkgs; {
    "XF86AudioPrev" = "${lib.getExe playerctl} previous";
    "XF86AudioPlay" = "${lib.getExe playerctl} play-pause";
    "XF86AudioNext" = "${lib.getExe playerctl} next";
  };
}
