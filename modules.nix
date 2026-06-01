{
  # compositor
  niri = ./modules/desktop/compositor/niri.nix;

  # desktop
  eww = ./modules/desktop/programs/eww.nix;
  mako = ./modules/desktop/programs/mako.nix;
  nautilus = ./modules/desktop/programs/nautilus.nix;
  rofi = ./modules/desktop/programs/rofi.nix;
  awww = ./modules/desktop/programs/awww.nix;
  quickshell = ./modules/desktop/programs/quickshell.nix;
  
  # games
  steam = ./modules/games/steam.nix;
  steamvr = ./modules/games/steamvr.nix;
  monado = ./modules/games/monado.nix;
  modding = ./modules/games/modding.nix;

  # hardware
  amdgpu = ./modules/hardware/amdgpu.nix;
  intel = ./modules/hardware/intel.nix;

  # social
  discord = ./modules/social/discord.nix;
  spotify = ./modules/social/spotify.nix;
  mprisence = ./modules/social/mprisence.nix;
  qutebrowser = ./modules/social/qutebrowser.nix;
  zenbrowser = ./modules/social/zenbrowser.nix;

  # terminal
  neovim = ./modules/terminal/neovim.nix;

  # utility
  bluetooth = ./modules/utility/bluetooth.nix;
  onepassword = ./modules/utility/onepassword.nix;
  qmk = ./modules/utility/qmk.nix;
  obs = ./modules/utility/obs.nix;
  rtl-sdr = ./modules/utility/rtl-sdr.nix;

  # virtualization
  docker = ./modules/virtualization/docker.nix;
}
