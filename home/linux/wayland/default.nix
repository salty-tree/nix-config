{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar/default.nix
  ];

  home.packages = [ pkgs.wl-clipboard ];
}
