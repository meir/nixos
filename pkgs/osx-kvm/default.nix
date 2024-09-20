{
  stdenv,
  lib,
  pkgs,
  fetchFromGitHub,
  diskSize ? 50,
  ramSize ? 16,
  cores ? 4,
  resolution ? "1920x1080",
  ...
}:
let
  pname = "osx-kvm";
  version = "1.0";
in
stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "kholia";
    repo = "OSX-KVM";
    sha256 = "";
  };

  buildInputs = [
    pkgs.python3
    pkgs.qemu
    pkgs.curl
    pkgs.unzip
  ];

  phases = "installPhase";

  installPhase = ''
    set -e

    mkdir -p "$out/osx"
    osx="$out/osx"

    cp -r * "$osx"
    cd $osx

    if [ ! -e BaseSystem.dmg ]; then
      ${pkgs.python3}/bin/python ./fetch-macOS-v2.py
    fi
            
    if [ ! -e BaseSystem.img ]; then
      ${pkgs.qemu}/bin/qemu-img convert BaseSystem.dmg -O raw BaseSystem.img
    fi
            
    if [ ! -e mac_hdd_ng.img ]; then
      ${pkgs.qemu}/bin/qemu-img create -f qcow2 mac_hdd_ng.img ${toString diskSize}G
    fi

    sed -i "s/ALLOCATED_RAM=\"4096\"/ALLOCATED_RAM=\"${toString ramSize}000\"/" OpenCore-Boot.sh
    sed -i "s/CPU_CORES=\"2\"/CPU_CORES=\"${toString cores}\"/" OpenCore-Boot.sh
    sed -i "s/CPU_THREADS=\"4\"/CPU_THREADS=\"$((cores * 2))\"/" OpenCore-Boot.sh
    sed -i "s/1920x1080/${resolution}/" OpenCore/config.plist

    # Automatically detect GPU PCI addresses
    GPU_PCI=$(lspci -nn | grep VGA | grep -oP '^[0-9a-fA-F:.]+')
    AUDIO_PCI=$(lspci -nn | grep Audio | grep -oP '^[0-9a-fA-F:.]+')

    # Add GPU passthrough configuration to OpenCore-Boot.sh
    if [ -n "$GPU_PCI" ] && [ -n "$AUDIO_PCI" ]; then
      sed -i "/-enable-kvm/a\
      -device vfio-pci,host=$GPU_PCI,multifunction=on,x-vga=on \\\n\
      -device vfio-pci,host=$AUDIO_PCI \\
      " OpenCore-Boot.sh
    else
      echo "Warning: GPU or Audio PCI address not found. Skipping GPU passthrough configuration."
    fi

    mkdir -p "$out/share/applications"
    cat > "$out/share/applications/osx-kvm.desktop" <<EOF
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=OSX-KVM
    Exec=$osx/OpenCore-Boot.sh
    Icon=computer
    Terminal=true
    Categories=System;
    EOF
  '';

  meta = {
    homepage = "https://github.com/kholia/osx-kvm";
    description = "Run macOS on QEMU/KVM. With OpenCore + Monterey + Ventura + Sonoma support now!";
    platforms = lib.platforms.all;
    maintainers = [ ];
  };
}
