{ ... }:
{
  user = "server";

  modules = {
    docker.enable = true;
    nvim.enable = true;
    kitty.enable = true;
    zsh.enable = true;
    nas.enable = true;
  };

  # additional hardware configuration
  boot.initrd.availableKernelModules = [
    "usb_storage"
    "sd_mod"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.grub = {
    enable = true;

    configurationLimit = 5;

    device = "/dev/sda";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb.layout = "us";
  };

  powerManagement.enable = true;
  hardware.bluetooth.enable = true;
}
