{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  vrpathreg = "${config.user_home}/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh";
in
{
  options.modules.steamvr.enable = mkEnableOption "SteamVR support";

  config = mkIf config.modules.steamvr.enable {
    environment.systemPackages = with pkgs; [ wlx-overlay-s ];

    environment.variables = {
      STEAMVR_EMULATE_INDEX_CONTROLLER = "1";
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };

    services.monado = {
      enable = true;
      defaultRuntime = true;
    };

    programs.envision.enable = true;

    protocol.autostart = [
      ''[ -f "${vrpathreg}" ] && ${getExe pkgs.steam-run} ${vrpathreg} ${pkgs.monado}/share/steamvr-monado''
    ];

    protocol.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    hm.home.file = {
      ".config/wlxoverlay/keyboard.yaml".source = ../../config/wlxoverlay/keyboard.yaml;
      ".config/wlxoverlay/watch.yaml".source = ../../config/wlxoverlay/watch.yaml;
      # ".config/openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
      # ".config/openvr/openvrpaths.vrpath".text = ''
      #   {
      #     "config": [
      #       "${config.user_home}/.steam/steam/config"
      #     ],
      #     "external_drivers": null,
      #     "jsonid": "vrpathreg",
      #     "log": [
      #       "${config.user_home}/Steam/logs"
      #     ],
      #     "runtime": [
      #       "${pkgs.opencomposite}/lib/opencomposite",
      #       "${config.user_home}/.steam/steam/steamapps/common/SteamVR"
      #     ],
      #     "version": 1
      #   }
      # '';
    };

    desktop.entry = {
      wlx-overlay-s = {
        name = "WLX Overlay S";
        comment = "WLX Overlay for SteamVR";
        exec = "${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace";
      };
      monado =
        let
          script = pkgs.writeScript "start-monado" ''
            ${pkgs.monado}/bin/monado-service
          '';
        in
        {
          name = "Monado";
          comment = "Monado";
          exec = "${script}";
          terminal = true;
        };
    };

  };
}
