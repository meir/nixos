inputs:
{
  # desktop
  eww = config: import ./desktop/eww.nix (inputs // config);
  mako = config: import ./desktop/mako.nix (inputs // config);
  nautilus = config: import ./desktop/nautilus.nix (inputs // config);
  rofi = config: import ./desktop/rofi.nix (inputs // config);
  swww = config: import ./desktop/swww.nix (inputs // config);

  # games
  steam = config: import ./games/steam.nix (inputs // config);
  steamvr = config: import ./games/steamvr.nix (inputs // config);
  monado = config: import ./games/monado.nix (inputs // config);

  # hardware
  amdgpu = config: import ./hardware/amdgpu.nix (inputs // config);

  # social
  discord = config: import ./social/discord.nix (inputs // config);
  qutebrowser = config: import ./social/qutebrowser.nix (inputs // config);
  zenbrowser = config: import ./social/zenbrowser.nix (inputs // config);

  # terminal
  neovim = config: import ./terminal/neovim.nix (inputs // config);

  # utility
  bluetooth = config: import ./utility/bluetooth.nix (inputs // config);
  onepassword = config: import ./utility/onepassword.nix (inputs // config);
  qmk = config: import ./utility/qmk.nix (inputs // config);

  # virtualization
  docker = config: import ./virtualization/docker.nix (inputs // config);
}
