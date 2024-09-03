{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.zsh.enable = mkEnableOption "zsh";

  config = mkIf config.modules.zsh.enable {
    environment.systemPackages = with pkgs; [
      zsh
      oh-my-zsh
      gnugrep
      cdl
      starship
      onefetch
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      # syntaxHighlighting.enable = true;

      # shellAliases = {
      #   cdd = "cd ~/Documents";
      #   bye = "exit";
      #   clear = "clear && printf '\\e[3J'";
      #   c = "clear";
      # };

      # shellInit =
      #   builtins.readFile ./shellinit.sh
      #   + ''
      #     eval "$(starship init zsh)"
      #     source "${pkgs.cdl}/bin/cdl-alias"
      #   '';
    };
    #
    # environment.file.starship = {
    #   source = ./starship.toml;
    #   target = ".config/starship.toml";
    # };

    # users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];
  };
}
