{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "zsh" {
  environment.packages = with pkgs; [
    zsh
    oh-my-zsh
    bash
    gnugrep
  ];

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

    shellInit = ''
      source $(which cdl-alias)
    '';
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];
}
