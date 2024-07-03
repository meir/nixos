{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "feh" {
  environment.packages = with pkgs; [ feh ];

  services.xserver.displayManager.sessionCommands = ''
    if [ -f "${config.user_home}/.fehbg" ]; then
      ${config.user_home}/.fehbg ;
    fi
  '';
}
