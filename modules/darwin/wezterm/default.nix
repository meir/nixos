{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options.modules.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf config.modules.wezterm.enable {
    hm.programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = ''
        local wezterm = require 'wezterm'
                local config = wezterm.config_builder()

                config.font_size = 15.0
                config.window_decorations = "RESIZE"
                config.hide_tab_bar_if_only_one_tab = true
                config.window_background_opacity = 0.6
                config.macos_window_background_blur = 20

                config.default_cursor_style = 'SteadyBar'

                config.colors = {
                  foreground = "#ffffff",
                  background = "#000408",
                  cursor_bg = "#c0cdc7",
                  cursor_border = "#c0cdc7",

                  ansi = {
                    '#073642', -- black
                    '#dc322f', -- maroon
                    '#859900', -- green
                    '#b58900', -- olive
                    '#268bd2', -- navy
                    '#d33682', -- purple
                    '#2aa198', -- teal
                    '#eee8d5', -- silver
                  },

                  brights = {
                    '#08404f', -- grey
                    '#e35f5c', -- red
                    '#9fb700', -- lime
                    '#d9a400', -- yellow
                    '#4ba1de', -- blue
                    '#dc619d', -- fuchsia
                    '#32c1b6', -- aqua
                    '#ffffff', -- white
                  }
                }
                config.font = wezterm.font { family = "JetBrainsMonoNL Nerd Font Mono" }

                return config
      '';
    };
  };
}
