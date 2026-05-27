{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
  ];

  programs.niri.useNautilus = true;

  niri.hotkeys = {
    "Super+E".spawn = "nautilus";
  };
}

