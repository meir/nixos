{
  pkgs,
  ...
}:
{
  user = "human";
  hostname = "glorpnet";

  environment.systemPackages = with pkgs; [

  ];

  # stick with cli graphics
  protocol.wayland.enable = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  services.home-assistant = {
    enable = true;
    extraComponents = [

    ];
    config = {

    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];

  modules = {
    containerization.enable = true;
    nvim.enable = true;
  };
}
