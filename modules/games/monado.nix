{
  config,
  pkgs,
  lib,
  wayvr_config ? null,
  ...
}:
with lib;
let
  skybox = pkgs.runCommand "skybox-unzip" {
    nativeBuildInputs = [ pkgs.brotli ];
  }
  ''
    mkdir -p $out
    brotli -d ${wayvr_config}/skybox.dds.br -o $out/skybox.dds
  '';
in
{
  environment.systemPackages = with pkgs; [
    unstable.wayvr
    lighthouse-steamvr
    monado_start
    
    xr-chaperone
    # baballonia-git
  ];

  services.monado = {
    enable = true;
    defaultRuntime = true;
    highPriority = true;
    package = pkgs.monado_custom;
  };

  systemd.user.services.monado = {
    serviceConfig.LimitNOFILE = 8192;
    environment = {
      STEAMVR_LH_ENABLE = "true";
      XRT_COMPOSITOR_COMPUTE = "1";
      XRT_COMPOSITOR_SCALE_PERCENTAGE = "150";
      XRT_COMPOSITOR_DESIRED_MODE = "0";
      U_PACING_COMP_PRESENT_TO_DISPLAY_OFFSET = "5";
      U_PACING_APP_USE_MIN_FRAME_PERIOD = "1";
    };
  };

  # Bigscreen Beyond Kernel patches from LVRA Discord Thread
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [
    {
      name = "bsb-kernel-patch";
      patch = ./patches/0001-bigscreen-beyond-kernel-latest.patch;
    }
  ];

  # Udev rules for Bigscreen devices
  services.udev.extraRules = ''
    # Bigscreen Beyond
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0101", MODE="0660", TAG+="uaccess"
    # Bigscreen Bigeye
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0660", TAG+="uaccess", GROUP="users"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0660", TAG+="uaccess", GROUP="users"
    # Bigscreen Beyond Audio Strap
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0105", MODE="0660", TAG+="uaccess"
    # Bigscreen Beyond Firmware Mode?
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="4004", MODE="0660", TAG+="uaccess"
  '';

  nix-fs.files = {
    ".config/openxr/1/active_runtime.json".source = "${pkgs.monado_custom}/share/openxr/1/openxr_monado.json";
    ".config/openvr/openvrpaths.vrpath".text = ''
      {
        "config" :
        [
          "${config.home}/.local/share/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
          "${config.home}/.local/share/Steam/logs"
        ],
        "runtime" :
        [
          "${pkgs.xrizer}/lib/xrizer",
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';

    # WayVR config
    ".config/wayvr/openxr_actions.json5".source = mkIf (wayvr_config != null) "${wayvr_config}/openxr_actions.json5";
    ".config/wayvr/skybox.dds".source = mkIf (wayvr_config != null) "${skybox}/skybox.dds";
    ".config/wayvr/conf.d/skybox.yaml".text = mkIf (wayvr_config != null) ''
      skybox_texture: skybox.dds
    '';
    ".config/wayvr/conf.d/config.yaml".source = mkIf (wayvr_config != null) "${wayvr_config}/config.yaml";
  };

  desktop.entry = {
    wayvr = {
      name = "WayVR";
      comment = "WayVR";
      exec = "${pkgs.unstable.wayvr}/bin/wayvr --replace --openxr";
    };
    # baballonia = {
    #   name = "Baballonia";
    #   comment = "Baballonia Eye/Face tracking";
    #   exec = "${pkgs.baballonia-git}/bin/baballonia";
    # };
  };
}
