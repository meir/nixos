{ pkgs, ... }: {
  imports = [ ../../lib/user.nix ../../modules ];

  config = {

    user = "human";

    modules = {
      packages = with pkgs; [
        wallust
        prismlauncher
        btop
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
        libsForQt5.kdenlive
        spotify
        stremio
        xclip
        onefetch
        nixfmt
        lmms
      ];
    };
  };
}
