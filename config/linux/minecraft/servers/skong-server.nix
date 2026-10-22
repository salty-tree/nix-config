{
  servers,
  mods,
  pkgs,
  ...
}:
{
  enable = true;
  package = servers.fabric-1_21_11;
  openFirewall = true;
  serverProperties = {
    difficulty = "normal";
    spawn-protection = 0;
    server-port = 25573;
    view-distance = 16;
    online-mode = true;
    enforce-whitelist = true;
    motd = "丁丁丁丁丁 電車ガ―タゴト 丁丁丁丁丁 はやいぜ快特 丁丁丁丁丁 電車ガ―タゴト 丁丁丁丁丁 はやいぜ快特";
  };
  jvmOpts = "-Xms1024M -Xmx16384M";

  symlinks = {
    mods = pkgs.linkFarmFromDrvs "mods-skong" (
      mods.modrinth-fabric "1.21.11" [
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
