{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = {
    fonts.packages = with pkgs; [
      nerd-font-patcher

      mononoki
      dina-font
      (nerdfonts.override {
        fonts = [
          "Mononoki"
          "RobotoMono"
        ];
      })
    ];

    services.xserver.displayManager.sessionCommands = ''
      nerd-font-patcher Dina
    '';
  };
}
