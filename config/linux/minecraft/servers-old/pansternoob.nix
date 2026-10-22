{ servers, mods, pkgs, ... }:
{
  enable = false;
  package = servers.fabric-1_19_4;
  openFirewall = true;
  serverProperties = {
    level-seed = "727wysi";
    difficulty = "hard";
    enable-status = false;
    snooper-enabled = false;
    spawn-protection = 0;
    view-distance = 16;
    server-port = 25566;
    online-mode = true;
    motd = "uwu";
  };
  jvmOpts = "-Xms1024M -Xmx8192M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-pansternoob"
      (mods.modrinth-fabric "1.19.4" [
        "fabric-api"
        "carpet" "carpet-extra" "carpet-tis-addition"
        "servux" "appleskin"
        "lithium"
      ]);
  };
}
