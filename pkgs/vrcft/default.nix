{
    pkgs,
    makeDesktopItem,
    appimageTools,
    ...
}:
let
    pname = "VRCFaceTracking";
    version = "1.1.1.0";

    src = pkgs.fetchurl {
        url = "https://github.com/dfgHiatus/VRCFaceTracking.Avalonia/releases/download/v${version}/VRCFaceTracking.Avalonia.${version}.x64.AppImage";
        hash = "sha256-oW8tsrJfC8woL2rCVyItFk4oR8M1SlQ/Y0vA1EaOhGQ=";
    };

    desktopItem = makeDesktopItem {
        name = pname;
        exec = pname;
        terminal = false;
        type = "Application";
        icon = pname;
        desktopName = "VRCFaceTracking";
        comment = "Face Tracking Utility for VRC";
        categories = [ "Utility" ];
    };
in
appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs =
        pkgs: with pkgs; [
            xorg.libICE
            xorg.libSM
            icu
        ];

    extraInstallCommands =
        let
            extracted = appimageTools.extract { inherit pname version src; };
        in
        ''
            mkdir -p $out/share/icons/hicolor/256x256/apps/
            cp ${extracted}/VRCFaceTracking.Avalonia.png $out/share/icons/hicolor/256x256/apps/${pname}.png

            mkdir -p $out/share/applications
            cp ${desktopItem}/share/applications/* $out/share/applications/
        '';

    meta = with pkgs.lib; {
        description = "VRCFaceTracking Avalonia for NixOS";
        homepage = "https://github.com/dfgHiatus/VRCFaceTracking.Avalonia";
        platforms = platforms.linux;
        mainProgram = pname;
    };
}
