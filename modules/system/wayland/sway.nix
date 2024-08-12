{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  buildSway = pkgs.writeScript "init" (''
    ${concatStringsSep "\n" config.protocol.rules}

    ${concatStringsSep "\n" (
      mapAttrsToList (key: value: "bindsym ${key} ${value}") config.protocol.hotkeys
    )}
  '');
in
{
  environment.defaultPackages = with pkgs; [ xorg.xf86videonouveau ];

  programs.sway = {
    enable = true;

    xwayland.enable = true;
  };

  environment.file.sway = {
    source = buildSway;
    target = ".config/sway/config";
  };

  protocol = {
    rules = [ "set $mod Mod4" ];
    hotkeys = {
      "$mod + Return" = "exec kitty";
      "$mod + shift + r" = "reload";

      "$mod + s" = "floating";
      "$mod + f" = "fullscreen";

      "$mod + h" = "focus left";
      "$mod + j" = "focus down";
      "$mod + k" = "focus up";
      "$mod + l" = "focus right";

      "$mod + q" = "close";
      "$mod + shift + q" = "kill";

      "$mod + 1" = "workspace number 1";
      "$mod + 2" = "workspace number 2";
      "$mod + 3" = "workspace number 3";
      "$mod + 4" = "workspace number 4";
      "$mod + 5" = "workspace number 5";
      "$mod + 6" = "workspace number 6";
      "$mod + 7" = "workspace number 7";
      "$mod + 8" = "workspace number 8";
      "$mod + 9" = "workspace number 9";
      "$mod + 0" = "workspace number 10";

      "$mod + shift + 1" = "move container to workspace number 1";
      "$mod + shift + 2" = "move container to workspace number 2";
      "$mod + shift + 3" = "move container to workspace number 3";
      "$mod + shift + 4" = "move container to workspace number 4";
      "$mod + shift + 5" = "move container to workspace number 5";
      "$mod + shift + 6" = "move container to workspace number 6";
      "$mod + shift + 7" = "move container to workspace number 7";
      "$mod + shift + 8" = "move container to workspace number 8";
      "$mod + shift + 9" = "move container to workspace number 9";
      "$mod + shift + 0" = "move container to workspace number 10";
    };
  };
}
