{ servers, mods, pkgs, ... }:
{
  enable = true;
  package = servers.fabric-1_21_1;
  openFirewall = true;
  serverProperties = {
    difficulty = "normal";
    snooper-enabled = false;
    spawn-protection = 0;
    view-distance = 10;
    server-port = 25567;
    online-mode = true;
    motd = "zao shang hao";
  };
  jvmOpts = "-Xms512M -Xmx2048M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-drs"
      (mods.modrinth-fabric "1.21.1" [
        "fabric-api"
        "appleskin"
        "lithium"
      ]);
  };
}
