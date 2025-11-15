{ pkgs, lib, ... }:
let
  rofi_bin = lib.getExe pkgs.rofi;
  cliphist_bin = lib.getExe pkgs.cliphist;
in
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

  protocol.hotkeys = [
      ''
        super + {_, shift +} Space
          hyprland | exec, ${rofi_bin} -show {drun,run} &

        super + v
          hyprland | exec, ${cliphist_bin} list | rofi -dmenu | ${cliphist_bin} decode | wl-copy | wl-paste
      ''
    ];
}
