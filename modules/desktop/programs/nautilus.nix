{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
  ];

  niri.hotkeys = {
    "Super+E".spawn = "nautilus";
  };
}

