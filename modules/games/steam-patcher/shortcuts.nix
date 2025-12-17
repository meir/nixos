{
  pkgs ? import <nixpkgs> { },
}:
let
  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      vdf
    ]
  );

  myShortcuts = {
    "Testing application" = {
      path = "ghostty -e 'btop'";
    };
  };

  helperScript = pkgs.writeScript "add-steam-shortcuts.py" ''
    #!${pythonEnv.interpreter}
    import json, os, sys, vdf, pathlib, zlib

    def find_userdata():
        base = pathlib.Path.home()/".steam/steam/userdata"
        if not base.exists():
            base = pathlib.Path("C:/Program Files (x86)/Steam/userdata")
        for d in base.iterdir():
            if (d/"config").exists():
                return d/"config"
        raise FileNotFoundError("No Steam userdata/config found")

    def main():
        cfg   = find_userdata()
        scvdf = cfg/"shortcuts.vdf"
        shortcuts = {"shortcuts":{}}
        if scvdf.exists():
            with scvdf.open("rb") as f:
                shortcuts = vdf.binary_load(f)

        # read JSON list from stdin
        games = json.load(sys.stdin)

        for g in games:
            name = g["name"]
            exe  = g["path"]
            icon = g.get("icon","")

            unique = (exe+name).encode()
            appid  = str(zlib.crc32(unique) | 0x80000000)

            # remove old entry with same name
            shortcuts["shortcuts"] = {k:v for k,v in shortcuts["shortcuts"].items()
                                        if v.get("appname") != name}

            idx = max([int(k) for k in shortcuts["shortcuts"]]+[-1]) + 1
            shortcuts["shortcuts"][str(idx)] = {
                "appid"        : appid,
                "appname"      : name,
                "exe"          : f'{exe}',
                "StartDir"     : f'{os.path.dirname(exe)}',
                "icon"         : (f'"{icon}"' if icon else ""),
                "LaunchOptions": "",
                "IsHidden"     : 0,
                "AllowDesktopConfig": 1,
                "OpenVR"       : 0,
                "tags"         : {}
            }
            print(f"Added/updated '{name}' (appid {appid})")

        with scvdf.open("wb") as f:
            vdf.binary_dump(shortcuts, f)

    if __name__ == "__main__":
        main()
  '';

  # convert the attribute set to a JSON list for the helper
  shortcutsJson = pkgs.writeText "shortcuts.json" (
    builtins.toJSON (
      pkgs.lib.mapAttrsToList (n: v: {
        name = n;
        path = v.path;
        icon = v.icon or "";
      }) myShortcuts
    )
  );

in
pkgs.writeShellScriptBin "steam-shortcuts" ''
  echo "Applying shortcuts..."
  ${helperScript} < ${shortcutsJson}
  echo "Done. Restart Steam to see the shortcuts."
''
