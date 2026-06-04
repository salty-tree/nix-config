{ pkgs, ... }:
{
  imports = [
    ../../home/common
    ../../home/gui
  ];

  home.username = "danielgu";
  home.homeDirectory = /Users/danielgu;

  home.packages = with pkgs; [
    # Misc
    google-chrome
    slack
    cloudflared

    yt-dlp

    # Darwin-specific
    ice-bar
    raycast
    #jetbrains.idea-ultimate
    karabiner-elements
    whisky
  ];

  # Init env vars with zsh
  programs.nushell.extraLogin = ''
    if not ("__ENV_INIT" in $env) {
      $env.__ENV_INIT = 1
      exec zsh -ilc "exec nu"
    }
  '';
}
