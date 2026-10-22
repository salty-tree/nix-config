{
  inputs,
  pkgs,
  lib,
  ...
}@args:
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers =
      let
        server-args = {
          servers = pkgs.minecraftServers;
          mods = import ./mods args;
          inherit pkgs;
        };
      in
      builtins.readDir ./servers
      |> lib.attrsets.mapAttrsToList (path: type_: path)
      |> builtins.filter (path: lib.strings.hasSuffix ".nix" path)
      |> builtins.map (
        name:
        lib.attrsets.nameValuePair (lib.strings.removeSuffix ".nix" name) (
          import (./servers + "/${name}") server-args
        )
      )
      |> builtins.listToAttrs;
  };
}
