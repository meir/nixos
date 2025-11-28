{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
  ];

  protocol.hotkeys = [
    ''
      super + e
        hyprland | exec, ${lib.getExe pkgs.nautilus}
        niri | spawn "${lib.getExe pkgs.nautilus}";
    ''
  ];
}

