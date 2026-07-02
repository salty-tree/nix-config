{ pkgs, ... }:
let
  unityhubFHS = pkgs.buildFHSEnv {
    name = "unityhub-fhs";

    targetPkgs =
      pkgs: with pkgs; [
        unityhub
        git
        glib
        zlib
        openssl
        libGL
        xorg.libX11
      ];

    runScript = "unityhub";
  };
in
{
  home.packages = [ unityhubFHS ];
}
