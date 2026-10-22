{ servers, mods, pkgs, ... }:
{
  enable = true;
  package = servers.fabric-1_20_4;
  openFirewall = true;
  serverProperties = {
    level-seed = -7516476896363864782;
    difficulty = "hard";
    spawn-protection = 0;
    server-port = 25570;
    view-distance = 16;
    online-mode = true;
    motd = "IBDP SMP";
  };
  jvmOpts = "-Xms1024M -Xmx4096M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-ibdp"
      (mods.modrinth-fabric "1.20.4" [
        "appleskin" "servux"
        "plasmo-voice" "pv-addon-groups"
        "c2me-fabric" "ferrite-core" "krypton" "lithium"
        "fabric-api"
      ]);
  };
}
