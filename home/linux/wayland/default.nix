{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar/default.nix
  ];

  home.packages = [ pkgs.wl-clipboard ];
}
