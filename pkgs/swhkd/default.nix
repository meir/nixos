{
  lib,
  rustPlatform,
  fetchurl,
  fetchFromGitHub,
  pkg-config,
  scdoc,
  libgcc,
  systemd,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "swhkd";
  version = "1.3.0-dev-7999a9bcf55e72455afc8c6dbd7c856d54435352";

  outputs = [
    "bin"
    "man"
    "out"
  ];

  src = fetchFromGitHub {
    owner = "waycrate";
    repo = "swhkd";
    rev = "7999a9bcf55e72455afc8c6dbd7c856d54435352";
    hash = "sha256-mpE+//a44wwraCCpBTnWXslLROF2dSIcv/kdpxHLD4M=";
  };

  nativeBuildInputs = [
    scdoc
    pkg-config
  ];

  buildPhase = ''
    runHook preBuild
    make DESTDIR="$out" POLKIT_DIR="$out/share/polkit-1/actions" MAN1_DIR="$out/share/man/man1" MAN5_DIR="$out/share/man/man5" TARGET_DIR=$out/bin build
    runHook postBuild
  '';

  installPhase = ''
        runHook preInstall

        mkdir -p $out $bin $man/share
        find ./docs -type f -iname "*.1.gz" -exec install -Dm 644 {} -t $out/share/man/man1 \;
    	  find ./docs -type f -iname "*.5.gz" -exec install -Dm 644 {} -t $out/share/man/man5 \;
    	  install -Dm 755 ./target/release/swhkd -t $out/bin
    	  install -Dm 755 ./target/release/swhks -t $out/bin
    	  install -Dm 644 ./com.github.swhkd.pkexec.policy -t $out/share/polkit-1/actions

    	  if [ ! -f $out/etc/swhkd/swhkdrc ]; then \
    		  touch ./swhkdrc; \
    		  install -Dm 644 ./swhkdrc -t $out/etc/swhkd; \
    	  fi

        mv $out/bin $bin/bin
        mv $out/share/man $man/share/man

        runHook postInstall
  '';

  cargoHash = "sha256-gQsnb0WzDLYg43sZ8EiTkfRQQAA2LuTGYVR0e+GzRgU=";

  buildInputs = [
    systemd
    libgcc
  ];

  meta = with lib; {
    description = "A drop-in replacement for sxhkd that works with wayland";
    homepage = "https://github.com/waycrate/swhkd";
    changelog = "https://github.com/waycrate/swhkd/blob/${src.rev}/CHANGELOG.md";
    license = licenses.bsd2;
    maintainers = with maintainers; [ binarycat ];
  };
}
