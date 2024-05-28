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
        libsForQt5.kdenlive
        spotify
        stremio
        onefetch
        lmms
      ];
    };
  };
}
