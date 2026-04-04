{
  stdenv,
  lib,
  fetchFromGitHub,
  godot_4_6,
  alsa-lib,
  libGL,
  libpulseaudio,
  libX11,
  libXcursor,
  libXext,
  libXi,
  libXrandr,
  udev,
  vulkan-loader,
  autoPatchelfHook,
  writableTmpDirAsHomeHook,
  makeDesktopItem,
  copyDesktopItems,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "PNGTuber-Plus";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "kaiakairos";
    repo = "PNGTuber-Plus";
    rev = "3173b213681152eb7fca55c63e757cfc42d2eb44";
    hash = "sha256-G5O1BBJGZ4ndjxQ7aMHPR9CEDVRIkfeCiySHHjqUUfk=";
  };

  desktopItems = [
    (makeDesktopItem {
      type = "Application";
      name = "PNGTuber-Plus";
      exec = "PNGTuber-Plus";
      icon = "PNGTuber-Plus";
      terminal = false;
      comment = "PngTuber Plus";
      desktopName = "PNGTuber-Plus";
      categories = [ "Application" ];
    })
  ];

  nativeBuildInputs = [
    autoPatchelfHook
    writableTmpDirAsHomeHook
    godot_4_6
    copyDesktopItems
  ];

  runtimeDependencies = map lib.getLib [
    alsa-lib
    libGL
    libpulseaudio
    libX11
    libXcursor
    libXext
    libXi
    libXrandr
    udev
    vulkan-loader
  ];

  passthru.updateScript = nix-update-script { };

  buildPhase = ''
    runHook preBuild

    ln -s "${godot_4_6.export-templates-bin}" $HOME/.local

    mkdir -p build
    godot4 --headless --export-release "Linux/X11" ./build/PNGTuber-Plus

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D -m 755 -t $out/libexec ./build/PNGTuber-Plus
    install -D -m 644 -t $out/libexec ./build/PNGTuber-Plus.pck

    install -d -m 755 $out/bin
    ln -s $out/libexec/PNGTuber-Plus $out/bin/PNGTuber-Plus

    install -vD icon.svg $out/share/icons/hicolor/scalable/apps/PNGTuber-Plus.svg

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/kaiakairos/PNGTuber-Plus";
    description = "PngTuber Plus";
    license = lib.licenses.mit;
    mainProgram = "PNGTuber-Plus";
    maintainers = with lib.maintainers; [ miampf ];
    platforms = lib.platforms.linux;
  };
})
