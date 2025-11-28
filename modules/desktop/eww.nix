{ 
  pkgs,
  lib,
  widgets ? [],
  config_files ? null,
  ...
}:
with lib;
let
  eww_bin = lib.getExe pkgs.eww;
  eww_widgets = map (widget: "${eww_bin} open ${widget}") widgets;
in
{
  environment.systemPackages = with pkgs; [
    eww
    jq
    zscroll
  ];

  protocol.autostart = [
    "${(pkgs.writeScript "eww-autostart" ''
      sleep 1
      ${eww_bin} daemon
      ${concatStringsSep "\n" eww_widgets}
    '')}"
  ];
  nix-fs.files.".config/eww".source = mkIf (config_files != null) config_files;
}
