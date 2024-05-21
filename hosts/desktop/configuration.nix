{ pkgs, ... }:
{
  imports = [
     ../../lib/user.nix
     ../../modules
  ];


  config = {

    user = "human";

    modules = {
      _1password.enable = true;
      discord.enable = true;
      kitty.enable = true;
      polybar.enable = true;
      qmk.enable = true;
      qutebrowser.enable = true;
      rofi.enable = true;
      steam.enable = true;
      zsh.enable = true;
      feh.enable = true;

      packages = with pkgs; [
        wallust
        prismlauncher
        btop
        fastfetch
        nvtop
        neovim
        git
        curl
        gcc
        cmake
        gnumake
        nodejs_18
        fzf
        rustup
        ripgrep
        obs-studio
        libsForQt5.kdenlive
        spotify
        stremio
        xclip
        onefetch
      ];
    };
  };
}
