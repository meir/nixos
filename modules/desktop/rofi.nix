{ pkgs, lib, config_files ? null, ... }:
with lib;
let
  rofi_bin = getExe pkgs.rofi;
  cliphist_bin = getExe pkgs.cliphist;
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

  nix-fs.files.".config/rofi".source = mkIf (config_files != null) config_files;

  protocol.hotkeys = [
      ''
        super + {_, shift +} Space
          hyprland | exec, ${rofi_bin} -show {drun,run} &

        super + v
          hyprland | exec, ${cliphist_bin} list | rofi -dmenu | ${cliphist_bin} decode | wl-copy | wl-paste
      ''
    ];
}
