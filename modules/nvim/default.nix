{ config, options, pkgs, lib, ... }:
with lib; {
  options.nvim.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable nvim with dotfiles";
  };

  config = mkIf config.nvim.enable {
    environment.packages = with pkgs; [
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
      xclip
      nixfmt
    ];

  };
}
