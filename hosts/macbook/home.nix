{ pkgs, config, ... }:
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
    (callPackage ../../home/common/rebuild-script.nix {
      hostname = "dQw4w9WgXcQ";
      system = "aarch64-darwin";
    })
  ];

  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = "${config.home.homeDirectory}/.config/claude/macos-roots.pem";
  };

  # Init env vars with zsh
  programs.nushell.extraLogin = ''
    if not ("__ENV_INIT" in $env) {
      $env.__ENV_INIT = 1
      exec zsh -ilc "exec nu"
    }
  '';
}
