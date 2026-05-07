{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./i3status-rust.nix
  ];

  xsession.enable = true;
  xsession.initExtra = ''
    LEFT='DP-2'
    RIGHT='DP-4'
    ${pkgs.xorg.xrandr}/bin/xrandr \
      --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 \
      --output $LEFT --mode 1920x1080 --rate 75 --rotate left
    ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --pos 1080x240
  '';

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    fonts = {
      names = [ "JetBrains Mono Nerd Font" ];
      style = "Regular";
      size = 11.0;
    };
    terminal = "kitty";

    gaps.inner = 10;
    gaps.outer = 5;

    keybindings =
      let
        pactl = "${pkgs.pulseaudio}/bin/pactl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        mod = config.xsession.windowManager.i3.config.modifier;
        rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
      in
      lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute 0 toggle";

        "XF86AudioPlay" = "exec ${playerctl} play";
        "XF86AudioPause" = "exec ${playerctl} pause";
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";

        "${mod}+shift+b" = "exec btop";
        "${mod}+shift+d" = "exec discord";
        "${mod}+shift+o" = "exec obsidian";
        "${mod}+shift+z" = "exec zen";
        "${mod}+underscore" = "exec set-sink hdmi-stereo";
        "${mod}+plus" = "exec set-sink Jabra_SPEAK_510";

        "${mod}+v" = null;
        "${mod}+bracketleft" = "split vertical";
        "${mod}+bracketright" = "split horizontal";

        "${mod}+k" = "focus up";
        "${mod}+shift+k" = "move up";
        "${mod}+h" = "focus left";
        "${mod}+shift+h" = "move left";
        "${mod}+j" = "focus down";
        "${mod}+shift+j" = "move down";
        "${mod}+l" = "focus right";
        "${mod}+shift+l" = "move right";
        "${mod}+9" = "workspace S";
        # "${mod}+shift+9" = "move container to workspace S";

        "${mod}+shift+s" = "exec flameshot gui";

        "${mod}+d" = null;
        "${mod}+space" = "exec ${rofi} -show drun";
        "${mod}+c" = "exec ${rofi} -modi calc -show calc -no-show-match -no-sort";
      };

    startup =
      let
        no-notif = cmd: {
          command = cmd;
          notification = false;
        };
      in
      [
        (no-notif "${pkgs.picom}/bin/picom -b")
        (no-notif "${pkgs.flameshot}/bin/flameshot")
        (no-notif "${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image" // { always = true; })
        # (no-notif "${pkgs.noisetorch}/bin/noisetorch -i")
        (no-notif "${pkgs.openrgb}/bin/openrgb -p default")
        (no-notif "/run/current-system/sw/bin/fcitx5")
      ];

    bars = [
      {
        position = "bottom";
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
        trayOutput = "primary";
        # Catppuccin-mocha
        colors =
          let
            crust = "#11111b";
            mantle = "#181825";
            base = "#1e1e2e";
            surface0 = "#313244";
            surface1 = "#45475a";
            text = "#cdd6f4";
            blue = "#89b4fa";
            lavender = "#b4befe";
            red = "#f38ba8";

            bg-border-text = bg: border: text: {
              background = bg;
              border = border;
              text = text;
            };
          in
          {
            background = mantle;
            focusedWorkspace = bg-border-text blue blue crust;
            activeWorkspace = bg-border-text surface1 blue text;
            inactiveWorkspace = bg-border-text surface0 surface0 text;
            urgentWorkspace = bg-border-text red red crust;
          };
      }
    ];

    workspaceOutputAssign =
      let
        left = "DP-2";
        right = "DP-4";
        ws = workspace: output: { inherit workspace output; };
      in
      [
        (ws "1" right)
        (ws "2" right)
        (ws "3" right)
        (ws "4" right)
        (ws "5" left)
        (ws "6" left)
        (ws "7" left)
        (ws "8" left)
        (ws "S" right)
      ];

    window.commands =
      let
        mkCmd = command: criteria: { inherit command criteria; };
        borderless = criteria: mkCmd "border none" criteria;
      in
      [
        (borderless { class = "^discord$"; })
        (borderless { class = "^Zen$"; })
      ];

    floating.criteria = [
      { title = "^预览$"; }
      {
        class = "^steam$";
        title = "^(?!Steam).*";
      }
    ];
  };

  xsession.windowManager.i3.extraConfig = ''
    assign [class="^steam$"] S
    no_focus [class="flameshot"]
  '';

  home.file.".background-image".source = ../../extras/wallpapers/nixos-nord.jpg;

  services.picom = {
    enable = true;
    activeOpacity = 1;
    inactiveOpacity = 0.9;
    menuOpacity = 0.9;
  };
}
