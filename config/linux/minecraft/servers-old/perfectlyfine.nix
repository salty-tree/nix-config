{ servers, mods, pkgs, ... }:
{
  enable = true;
  package = servers.fabric-1_21_3;
  openFirewall = true;
  serverProperties = {
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25569;
    view-distance = 16;
    online-mode = true;
    motd = "whatevercraft";
  };
  jvmOpts = "-Xms1024M -Xmx16384M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-ibdp"
      (mods.modrinth-fabric "1.21.3" [
        "appleskin" "servux" "distanthorizons"
        "c2me-fabric" "ferrite-core" "krypton" "lithium"
        "carpet" "carpet-extra" "carpet-tis-addition"
        "fabric-api"
      ]);
  };
}
