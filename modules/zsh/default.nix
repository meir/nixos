{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.zsh.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.zsh.enable {
    modules.packages = with pkgs; [ zsh oh-my-zsh bash gnugrep ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      histSize = 10000;

      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
      };

      shellAliases = {
        cdd = "cd ~/Documents";
        bye = "exit";
        clear = "clear && printf '\\e[3J'";
        c = "clear";
      };
    };

    users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];
  };
}
