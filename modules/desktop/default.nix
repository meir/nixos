{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  widgetScripts = pkgs.writeScript "eww-start" (
    concatStringsSep "\n" (
      map (widget: ''
        ${pkgs.eww}/bin/eww open ${widget}
      '') config.modules.eww.widgets
    )
  );
in
{
  options.modules = {
    eww = {
      enable = mkEnableOption "eww";
      widgets = mkOption {
        type = types.listOf types.str;
        default = [ ];
      };
    };
    rofi.enable = mkEnableOption "rofi";
    mako.enable = mkEnableOption "mako";
    swww.enable = mkEnableOption "swww";
  };

  config = (
    mkMerge [
      (mkIf config.modules.eww.enable {
        environment.systemPackages = with pkgs; [
          jq
          eww
          zscroll
        ];

        protocol.autostart = [
          "${pkgs.eww}/bin/eww daemon &"
          "${widgetScripts}"
        ];

        hm.home.file.".config/eww".source = ../config/eww;
      })

      (mkIf config.modules.rofi.enable {
        environment.systemPackages = with pkgs; [
          rofi
          cliphist
        ];

        protocol.autostart = [
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];

        hm.home.file.".config/rofi".source = ../config/rofi;

        protocol.hotkeys =
          let
            rofi = "${getExe pkgs.rofi}";
          in
          [
            ''
              super + {_, shift +} Space
                hyprland | exec, ${rofi} -show {drun,run} &

              super + v
                hyprland | exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy | wl-paste
            ''
          ];
      })

      (mkIf config.modules.mako.enable {
        environment.systemPackages = with pkgs; [
          mako
        ];

        protocol.autostart = [
          "${getExe pkgs.mako}"
        ];

        hm.home.file.".config/mako/config".source = ../config/mako/config;
      })

      (mkIf config.modules.swww.enable {
        environment.systemPackages = with pkgs; [
          swww
          waypaper
        ];

        protocol.autostart = [
          "${pkgs.swww}/bin/swww-daemon"
          "${getExe pkgs.swww} restore"
        ];
      })
    ]
  );
}
