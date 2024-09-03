{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.nvim.enable = mkEnableOption "nvim";

  config = mkIf config.modules.nvim.enable {
    environment.systemPackages = with pkgs; [
      neovim
      git
      curl
      gcc12
      cmake
      go
      gnumake
      nodejs_18
      fzf
      rustup
      ripgrep
      xclip
      nixfmt-rfc-style
      luajitPackages.luarocks
      lua
    ];
  };
}
