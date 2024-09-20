{ ... }:
{
  user = "server";

  protocol = {
    type = "wayland";
  };

  modules = {
    docker.enable = true;
    nvim.enable = true;
    kitty.enable = true;
    zsh.enable = true;
  };

  # additional hardware configuration
  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  powerManagement.enable = true;
  hardware.bluetooth.enable = true;
}
