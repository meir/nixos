{ config, pkgs, lib, ... }: {
  security = {
    sudo.enable = true;
    doas = {
      enable = true;
      extraRules = [{
        users = [ config.user ];
        keepEnv = true;
        persist = true;
      }];
    };

    protectKernelImage = true;
  };
}
