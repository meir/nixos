{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    rofi
    cliphist
  ];

  protocol.autostart = [
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"
  ];

  files.".config/rofi".source = ../config/rofi;

  protocol.hotkeys =
    let
      rofi = "${lib.getExe pkgs.rofi}";
    in
    [
      ''
        super + {_, shift +} Space
          hyprland | exec, ${rofi} -show {drun,run} &

        super + v
          hyprland | exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy | wl-paste
      ''
    ];
}
