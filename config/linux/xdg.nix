{ pkgs, ... }:
let
  tfchooser = pkgs.xdg-desktop-portal-termfilechooser;
in
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;

    # xdg-desktop-portal-hyprland is added by programs.hyprland
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      tfchooser
    ];

    config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };
  };

  hm.xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${tfchooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    env=TERMCMD=kitty
    default_dir=$HOME/Downloads
  '';
}
