{ pkgs, ... }: {
  # home.packages = [
  #   (pkgs.discord.override { withVencord = false; })
  # ];

  programs.vesktop.enable = true;

  xdg.configFile = {
    # "Vencord/themes/ctp-mocha.theme.css".source = ../extras/discord-ctp-mocha.theme.css;
    # "Vencord/settings/settings.json".source = ./extras/vencord-settings.json;
  };
}
