{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  environment.systemPackages = with pkgs; [
    kitty
    lact

    # terminal tools
    btop-rocm
    fastfetch
    xdotool
    cargo
    rustc

    # zsh
    zsh
    oh-my-zsh
    bash
    gnugrep
    cdl
    starship
    onefetch
    fastfetch
  ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  programs = {
    gnupg.agent.enable = true;
    direnv.enable = true;
  };

  protocol.hotkeys = [
    ''
      super + return
        hyprland | exec, kitty
        kitty
    ''
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "golang"
        "kubectl"
      ];
    };

    shellAliases = {
      cdd = "cd ~/Documents";
      bye = "exit";
      clear = "clear && printf '\\e[3J'";
      c = "clear";
    };

    shellInit = ''
      # init all completions
      autoload -U compinit && compinit
      compinit

      HIST_STAMPS="yyyy/mm/dd"

      [ -d ".git" ] && onefetch || fastfetch
              
      eval "$(starship init zsh)"
      source "${pkgs.cdl}/bin/cdl-alias"
    '';
  };

  hm.home.file = {
    ".cache/oh-my-zsh/completions/_cdl".source = "${pkgs.cdl}/shared/.oh-my-zsh/completions/_cdl";
    ".config/starship.toml".text = ''
      format = ' (blue)$directory(green)‣ '
      add_newline = false
    '';
    ".config/kitty/kitty.conf".text = ''
      map ctrl+c copy_and_clear_or_interrupt
      map ctrl+v paste_from_clipboard

      enable_audio_bell no

      background_opacity 0.5

      font_family DinaRemasterII Nerd Font
      font_size 12

      enable_audio_bell no
    '';
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [
    pkgs.zsh
    pkgs.bash
  ];
}
