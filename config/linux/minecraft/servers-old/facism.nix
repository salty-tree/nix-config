{ servers, mods, pkgs, ... }:
{
  enable = false;
  package = servers.fabric-1_20_4;
  openFirewall = true;
  serverProperties = {
    allow-flight = true;
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25568;
    view-distance = 16;
    online-mode = true;
    motd = "facism";
  };
  jvmOpts = "-Xms1024M -Xmx4096M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-facism"
      (mods.modrinth-fabric "1.20.4" [
        "appleskin" "servux"
        "lithium" "fabric-api" "carpet"
      ]);
  };
}
