{
  servers,
  mods,
  pkgs,
  ...
}:
{
  enable = true;
  package = servers.fabric-1_21_5;
  openFirewall = true;
  serverProperties = {
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25572;
    view-distance = 16;
    online-mode = true;
    motd = "best server";
  };
  jvmOpts = "-Xms1024M -Xmx16384M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-bestserver" (
      mods.modrinth-fabric "1.21.5" [
        "appleskin"
        "servux"
        "distanthorizons"
        "c2me-fabric"
        "ferrite-core"
        "krypton"
        "lithium"
        # "carpet" "carpet-extra" "carpet-tis-addition"
        "fabric-api"
      ]
    );
  };
}
