{ pkgs, ... }:
{
  imports = [
    ./mtd-bus.nix
  ];

  programs.waybar = {
    enable = true;
    # Waybar 0.15.0 sends legacy `dispatch workspace N` on workspace clicks, which
    # Hyprland rejects when using the Lua config. Upstream master translates these
    # to hl.dsp.* calls (Alexays/Waybar#5231); drop this once a release includes it.
    package = pkgs.waybar.overrideAttrs (old: {
      version = "0.15.0-unstable-2026-10-19";
      src = pkgs.fetchFromGitHub {
        owner = "Alexays";
        repo = "Waybar";
        rev = "c15ec02ede4343592a59eb5c2ff4443c9c045f7c";
        hash = "sha256-mBDWjeeIuFfDZQuBxHu+EpbJ+GMbbSxpRz0WVM2N+ZI=";
      };
      # master adds a ModemManager-backed wwan module that nixpkgs doesn't provide deps for
      mesonFlags = old.mesonFlags ++ [ "-Dwwan=disabled" ];
      # `waybar --version` reports 0.15.0, not our unstable version string
      doInstallCheck = false;
      # master requires libcava >= 1.0.0, nixpkgs vendors 0.10.7-beta
      postUnpack =
        let
          libcava = pkgs.fetchFromGitHub {
            owner = "LukashonakV";
            repo = "cava";
            rev = "1.0.0";
            hash = "sha256-0r5aAmTs+FcmS501tNYKxG9H+Pq6i32BDRBEjWW6M74=";
          };
        in
        ''
          pushd "$sourceRoot"
          cp -R --no-preserve=mode,ownership ${libcava} subprojects/cava-1.0.0
          patchShebangs .
          popd
        '';
    });
    systemd.enable = true;
    settings.mainbar = {
      position = "top";
      exclusive = true;

      modules-left = [
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = [
        "clock"
        "custom/separator"
        "custom/mtd_bus"
      ];
      modules-right = [
        "cpu"
        "temperature#cpu"
        "memory"
        "network"
        "pulseaudio"
      ];

      clock = {
        format-alt = "{:%a, %d. %b %H:%M}";
      };

      cpu = {
        interval = 1;
        format-alt = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}";
        format-icons = [
          " "
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        states = {
          warning = 20;
          critical = 50;
        };
      };

      "temperature#cpu" = {
        interval = 1;
        hwmon-path = "/sys/class/thermal/thermal_zone0/temp";
        critical-threshold = 70;
        format = "{icon} {temperatureC}°";
        format-icons = [ "" ];
      };

      tray = {
        icon-size = 18;
        spacing = 8;
      };

      "custom/separator" = {
        "format" = "|";
        "tooltip" = false;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: 600;
        color: @text;
      }

      #waybar>box {
        border-radius: 0;
        border: 0;
        background-color: @mantle;
      }

      .modules-center,
      #tray,
      #workspaces,
      .modules-right {
        border-radius: 1.5em;
        border: 2px solid @overlay0;
      }

      .modules-left {
        background-color: transparent;
      }

      .modules-center,
      .modules-right {
        background-color: @base;
        padding: 0 1em;
      }

      #custom-separator {
        margin: 0 0.5em;
      }

      #tray {
        padding: 0 0.5em;
      }

      #cpu,
      #temperature,
      #memory,
      #network,
      #pulseaudio {
        margin: 0.25em;
      }

      #workspaces button {
        padding: 0 0.4em;
        margin: 0.15em;
        border-radius: 1em;
        background-color: @surface0;
        background-image: none;
        border: 2px solid @surface0;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button label {
        text-shadow: none;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button.empty {
        color: @overlay0;
      }

      #workspaces button.visible {
        border-color: @blue;
      }

      #workspaces button:hover {
        background-color: @surface2;
      }

      #workspaces button.active {
        background-color: @blue;
        border-color: @blue;
      }

      #workspaces button.active label {
        color: @crust;
      }

      #workspaces button.active:hover {
        background-color: shade(@blue, 0.9);
        border-color: @blue;
      }

      #workspaces button:active {
        background-color: @yellow;
        border-color: @blue;
      }

      #workspaces button.urgent {
        border-color: @red;
      }
    '';
  };
}
