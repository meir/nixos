{
  pkgs,
  lib,
  ...
}:
{
  config = {
    # TODO: make themeing in nix somehow
    
    # temporarily unset variables to fix prismlauncher and stremio with QT
    environment.etc."profile.d/unset-qt.sh".text = ''
      #!/bin/sh
      # Unset Qt env vars so apps that bundle Qt don't break
      unset QT_PLUGIN_PATH
      unset QT_QPA_PLATFORMTHEME
      unset QT_STYLE_OVERRIDE
      unset QTWEBKIT_PLUGIN_PATH
    '';
  };
}
