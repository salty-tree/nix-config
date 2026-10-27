{ pkgs, ... }:
let
  wallpaper = "${pkgs.runCommand "nixos-nord-dark.jpg" { nativeBuildInputs = [ pkgs.imagemagick ]; }
    ''
      convert ${../../extras/wallpapers/nixos-nord.jpg} -modulate 70,100,100 "$out"
    ''
  }";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "DP-1";
          path = wallpaper;
        }
        {
          monitor = "DP-4";
          path = wallpaper;
        }
        {
          monitor = "HDMI-A-1";
          path = wallpaper;
        }
      ];
    };
  };
}
