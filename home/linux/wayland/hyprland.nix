{
  pkgs,
  config,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings =
      let
        args2 = a1: a2: {
          _args = [
            a1
            a2
          ];
        };
        args3 = a1: a2: a3: {
          _args = [
            a1
            a2
            a3
          ];
        };
      in
      {
        mod = {
          _var = "SUPER";
        };
        terminal = {
          _var = "kitty";
        };

        config = {
          general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 2;
            col = {
              active_border = {
                colors = [
                  "rgba(cba6f7ee)"
                  "rgba(89b4faee)"
                ];
                angle = 45;
              };
              inactive_border = "rgba(45475aaa)";
            };
            resize_on_border = false;
            allow_tearing = false;
            layout = "dwindle";
          };

          decoration = {
            rounding = 5;
            rounding_power = 2;
            active_opacity = 1.0;
            inactive_opacity = 0.9;
            fullscreen_opacity = 1.0;

            blur = {
              enabled = true;
              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };

          dwindle = {
            preserve_split = true;
          };

          master = {
            new_status = "master";
          };

          input = {
            accel_profile = "flat";
            sensitivity = -0.3;
          };
        };

        curve =
          let
            bezier = x1: y1: x2: y2: {
              type = "bezier";
              points = [
                [
                  x1
                  y1
                ]
                [
                  x2
                  y2
                ]
              ];
            };
          in
          [
            (args2 "easeOutQuint" (bezier 0.23 1 0.32 1))
            (args2 "easeInOutCubic" (bezier 0.65 0.05 0.36 1))
            (args2 "linear" (bezier 0 0 1 1))
            (args2 "almostLinear" (bezier 0.5 0.5 0.75 1))
            (args2 "quick" (bezier 0.15 0 0.1 1))
          ];

        animation =
          let
            mkAnim = leaf: speed: bezier: {
              inherit leaf speed bezier;
              enabled = true;
            };
            mkAnim' = leaf: speed: bezier: style: {
              inherit
                leaf
                speed
                bezier
                style
                ;
              enabled = true;
            };
          in
          [
            (mkAnim "global" 10 "default")
            (mkAnim "border" 5.39 "easeOutQuint")
            (mkAnim' "windows" 4.79 "easeOutQuint" "popin 87%")
            (mkAnim' "windowsIn" 4.1 "easeOutQuint" "popin 87%")
            (mkAnim' "windowsOut" 1.49 "linear" "popin 87%")
            (mkAnim "fadeIn" 1.73 "almostLinear")
            (mkAnim "fadeOut" 1.46 "almostLinear")
            (mkAnim "fade" 3.03 "quick")
            (mkAnim "layers" 3.81 "easeOutQuint")
            (mkAnim' "layersIn" 4 "easeOutQuint" "fade")
            (mkAnim' "layersOut" 1.5 "linear" "fade")
            (mkAnim "fadeLayersIn" 1.79 "almostLinear")
            (mkAnim "fadeLayersOut" 1.39 "almostLinear")
            (mkAnim' "workspaces" 1.94 "almostLinear" "fade")
            (mkAnim' "workspacesIn" 1.21 "almostLinear" "fade")
            (mkAnim' "workspacesOut" 1.94 "almostLinear" "fade")
          ];

        window_rule = {
          match.class = "kitty";
          # kitty sends a maximize request on its first window map; Hyprland
          # honors it by stretching the window to fill the screen even though
          # the tiling layout still thinks it's a normal tile. This stops it.
          suppress_event = "maximize";
        };

        monitor = [
          {
            output = "DP-1";
            mode = "2560x1440@144";
            position = "0x0";
            scale = 1;
          }
          {
            output = "DP-4";
            mode = "2560x1440@240";
            position = "0x0";
            scale = 1;
          }
          {
            output = "HDMI-A-1";
            mode = "2560x1440@144";
            position = "0x0";
            scale = 1;
          }
        ];

        exec_cmd = [
          "fcitx5"
          # "hyprctl setcursor HollowKnight 32"
        ];

        bind =
          let
            rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
            grimblast = "${pkgs.grimblast}/bin/grimblast";
            swappy = "${pkgs.swappy}/bin/swappy";

            # Hyprland's native Lua config takes key combos as "MOD + MOD + key"
            # strings (unlike hyprlang's "mod, key" syntax), so modifiers are
            # joined with the `mod` Lua variable via string concatenation.
            key = suffix: lib.generators.mkLuaInline ''mod .. " ${suffix}"'';
            dispatch = expr: lib.generators.mkLuaInline expr;
          in
          [
            (args2 (key "+ space") (dispatch ''hl.dsp.exec_cmd("${rofi} -show drun")''))
            (args2 (key "+ C") (
              dispatch ''hl.dsp.exec_cmd("${rofi} -modi calc -show calc -no-show-match -no-sort")''
            ))
            (args2 (key "+ return") (dispatch "hl.dsp.exec_cmd(terminal)"))
            (args2 (key "+ E") (dispatch ''hl.dsp.exec_cmd("kitty yazi")''))
            (args2 (key "+ S") (dispatch ''hl.dsp.exec_cmd("${grimblast} --freeze copy area")''))
            (args2 (key "+ SHIFT + S") (
              dispatch ''hl.dsp.exec_cmd("${grimblast} --freeze save area - | ${swappy} -f -")''
            ))

            (args2 (key "+ F") (dispatch "hl.dsp.window.fullscreen()"))
            (args2 (key "+ SHIFT + Q") (dispatch "hl.dsp.window.close()"))
            (args2 (key "+ SHIFT + M") (dispatch "hl.dsp.exit()"))
            (args2 (key "+ SHIFT + space") (dispatch ''hl.dsp.window.float({ action = "toggle" })''))

            (args2 (key "+ H") (dispatch ''hl.dsp.focus({ direction = "left" })''))
            (args2 (key "+ J") (dispatch ''hl.dsp.focus({ direction = "down" })''))
            (args2 (key "+ K") (dispatch ''hl.dsp.focus({ direction = "up" })''))
            (args2 (key "+ L") (dispatch ''hl.dsp.focus({ direction = "right" })''))
            (args2 (key "+ tab") (dispatch "hl.dsp.window.cycle_next()"))

            (args2 (key "+ 1") (dispatch "hl.dsp.focus({ workspace = 1 })"))
            (args2 (key "+ 2") (dispatch "hl.dsp.focus({ workspace = 2 })"))
            (args2 (key "+ 3") (dispatch "hl.dsp.focus({ workspace = 3 })"))
            (args2 (key "+ 4") (dispatch "hl.dsp.focus({ workspace = 4 })"))
            (args2 (key "+ 5") (dispatch "hl.dsp.focus({ workspace = 5 })"))
            (args2 (key "+ 6") (dispatch "hl.dsp.focus({ workspace = 6 })"))
            (args2 (key "+ 7") (dispatch "hl.dsp.focus({ workspace = 7 })"))
            (args2 (key "+ 8") (dispatch "hl.dsp.focus({ workspace = 8 })"))
            (args2 (key "+ 9") (dispatch "hl.dsp.focus({ workspace = 9 })"))
            (args2 (key "+ 0") (dispatch "hl.dsp.focus({ workspace = 10 })"))

            (args2 (key "+ SHIFT + 1") (dispatch "hl.dsp.window.move({ workspace = 1 })"))
            (args2 (key "+ SHIFT + 2") (dispatch "hl.dsp.window.move({ workspace = 2 })"))
            (args2 (key "+ SHIFT + 3") (dispatch "hl.dsp.window.move({ workspace = 3 })"))
            (args2 (key "+ SHIFT + 4") (dispatch "hl.dsp.window.move({ workspace = 4 })"))
            (args2 (key "+ SHIFT + 5") (dispatch "hl.dsp.window.move({ workspace = 5 })"))
            (args2 (key "+ SHIFT + 6") (dispatch "hl.dsp.window.move({ workspace = 6 })"))
            (args2 (key "+ SHIFT + 7") (dispatch "hl.dsp.window.move({ workspace = 7 })"))
            (args2 (key "+ SHIFT + 8") (dispatch "hl.dsp.window.move({ workspace = 8 })"))
            (args2 (key "+ SHIFT + 9") (dispatch "hl.dsp.window.move({ workspace = 9 })"))
            (args2 (key "+ SHIFT + 0") (dispatch "hl.dsp.window.move({ workspace = 10 })"))

            (args3 (key "+ mouse:272") (dispatch "hl.dsp.window.drag()") { mouse = true; })
            (args3 (key "+ mouse:273") (dispatch "hl.dsp.window.resize()") { mouse = true; })
            (args3 (key "+ ALT + mouse:272") (dispatch "hl.dsp.window.drag()") { mouse = true; })
          ];
      };
  };

  catppuccin.hyprland.enable = false;

  xdg.configFile = {
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures
      save_filename_format=screenshot-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=sans-serif
      paint_mode=brush
      early_exit=true
      fill_shape=false
      auto_save=false
      custom_color=rgba(192,125,17,1)
      transparent=false
      transparency=50
    '';
  };
}
