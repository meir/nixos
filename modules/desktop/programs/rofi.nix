{ pkgs, lib, assets, ... }:
with lib;
{
  environment.systemPackages = with pkgs; [
    rofi
    cliphist
  ];

  niri.autostart = [
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"
  ];

  niri.hotkeys = {
    "Super+Space".spawn = "rofi -show drun";
    "Super+Shift+Space".spawn = "rofi -show run";
  };

  nix-fs.files.".config/rofi/config.rasi".source = mkIf (assets.rofi_config != null) assets.rofi_config;
}
