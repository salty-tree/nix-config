# The ArtCraft apps use the `rfd` crate for native file dialogs, which dlopens
# the unversioned `libdbus-1.so` to talk to the xdg-desktop-portal file chooser
# over D-Bus. artcraft-nix's package.nix puts plain `dbus` (the daemon's "out"
# output, which ships no libraries at all) on the RPATH instead of `dbus.lib`
# (which has both `libdbus-1.so.3` and the unversioned `libdbus-1.so` symlink),
# so the dlopen fails, rfd falls back to spawning the `zenity` binary, and that
# isn't installed either — so no dialog ever opens.
#
# Fixed here by wrapping the installed launchers with the missing lib on
# LD_LIBRARY_PATH instead of patching the upstream flake.
{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  apps = [
    "photocraft"
    "vectorcraft"
    "pdfcraft"
  ];

  libPath = lib.makeLibraryPath [ pkgs.dbus.lib ];

  wrapped = pkgs.symlinkJoin {
    name = "artcraft-wrapped";
    paths = map (app: pkgs.artcraft.${app}) apps;
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      for prog in $out/bin/*; do
        wrapProgram "$prog" --prefix LD_LIBRARY_PATH : "${libPath}"
      done
    '';
  };
in
{
  nixpkgs.overlays = [ inputs.artcraft.overlays.default ];

  programs.artcraft = {
    enable = true;
    # Installed below as `wrapped` instead, so the launchers get the libPath fix.
    apps = [ ];
    linkFonts = false;
  };

  environment.systemPackages = [ wrapped ];
}
