{
  config,
  pkgs,
  lib,
  config_file ? null,
  ...
}:
with lib;
let
  startup = concatStringsSep "\n" (map (value: "spawn-at-startup \"${value}\"") config.niri.autostart);
  hotkey_item = value: if value.spawn != null then "spawn " + (concatStringsSep " " (map (value: "\"" + value + "\"") (splitString " " value.spawn))) else value.op;
  hotkeys = "binds {\n" + (concatStringsSep "\n" (map (item: "  ${item.name} { ${hotkey_item item.value}; }") (attrsToList config.niri.hotkeys))) + "\n}";
  config_file_content = if config_file != null then builtins.readFile config_file else "";

  niriconfig = pkgs.writeScript "niri" ''
    ${startup}
    ${hotkeys}
    ${config_file_content}
  '';
in
{
  options.niri = {
    hotkeys = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            spawn = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
            op = mkOption {
              type = types.nullOr types.str;
              default = null;
            };
          };
        }
      );
      default = {};
    };
    autostart = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    nix-fs.files.".config/niri/config.kdl" = {
      source = niriconfig;
    };

    environment.systemPackages = with pkgs; [ 
      socat
      wl-clipboard
      xwayland-satellite # xwayland support
      xwayland-run
    ];

    security.polkit.enable = true;

    services.greetd = {
      enable = true;
      package = pkgs.unstable.greetd;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd 'niri-session'";
        };
      };
    };

    niri.hotkeys = {
      "Super+Return".spawn = "kitty";
      "XF86AudioPrev".spawn = "playerctl previous";
      "XF86AudioPlay".spawn = "playerctl play-pause";
      "XF86AudioNext".spawn = "playerctl next";
      "Super+Q".op = "close-window";
      "Super+O".op = "open-overview";
      # "Super+Shift+Q" = 
      "Super+T".op = "maximize-column";
      "Super+S".op = "toggle-window-floating";
      "Super+F".op = "fullscreen-window";

      "Super+H".op = "focus-column-left";
      "Super+J".op = "focus-workspace-down";
      "Super+K".op = "focus-workspace-up";
      "Super+L".op = "focus-column-right";

      "Super+Shift+H".op = "move-column-left";
      "Super+Shift+J".op = "move-column-to-workspace-down";
      "Super+Shift+K".op = "move-column-to-workspace-up";
      "Super+Shift+L".op = "move-column-right";

      "Super+1".op = "focus-workspace \"ws_1\"";
      "Super+2".op = "focus-workspace \"ws_2\"";
      "Super+3".op = "focus-workspace \"ws_3\"";
      "Super+4".op = "focus-workspace \"ws_4\"";
      "Super+5".op = "focus-workspace \"ws_5\"";
      "Super+6".op = "focus-workspace \"ws_6\"";
      "Super+7".op = "focus-workspace \"ws_7\"";
      "Super+8".op = "focus-workspace \"ws_8\"";
      "Super+9".op = "focus-workspace \"ws_9\"";
      "Super+0".op = "focus-workspace \"ws_10\"";

      "Super+Shift+1".op = "move-column-to-workspace \"ws_1\"";
      "Super+Shift+2".op = "move-column-to-workspace \"ws_2\"";
      "Super+Shift+3".op = "move-column-to-workspace \"ws_3\"";
      "Super+Shift+4".op = "move-column-to-workspace \"ws_4\"";
      "Super+Shift+5".op = "move-column-to-workspace \"ws_5\"";
      "Super+Shift+6".op = "move-column-to-workspace \"ws_6\"";
      "Super+Shift+7".op = "move-column-to-workspace \"ws_7\"";
      "Super+Shift+8".op = "move-column-to-workspace \"ws_8\"";
      "Super+Shift+9".op = "move-column-to-workspace \"ws_9\"";
      "Super+Shift+0".op = "move-column-to-workspace \"ws_10\"";

      "Super+Shift+P".op = "screenshot";
    };
  };
}
