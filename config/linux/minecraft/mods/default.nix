{ pkgs, lib, ... }:
# let
#   make-mods = mod-info: mods:
#     pkgs.linkFarmFromDrvs "mods"
#     (mods (builtins.mapAttrs (_: pkgs.fetchurl) mod-info));
# in
#   lib.attrsets.mapAttrs'
#   (path: type_: lib.attrsets.nameValuePair
#     ("make-" + lib.strings.removeSuffix ".nix" path)
#     (make-mods (import (./. + "/${path}")))
#   )
#   (lib.attrsets.filterAttrs
#     (path: type_: path != "default.nix" && lib.strings.hasSuffix ".nix" path)
#     (builtins.readDir ./.)
#   )

with builtins;
let
  mod-data = fromJSON (readFile ./modrinth-mods.json);
in {
  modrinth-fabric = version: slugs:
    map (slug: pkgs.fetchurl mod-data.${version}.${slug}) slugs;
}
