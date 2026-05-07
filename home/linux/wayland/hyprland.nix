{ pkgs, config, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings =
      let
        rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
      in
      {
        "$mod" = "SUPER";
        "$terminal" = "kitty";

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
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

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        input = {
          accel_profile = "flat";
          sensitivity = -0.3;
        };

        master.new_status = "master";

        monitor = [
          "DP-1, 2560x1440@144, 0x0, 1"
          "DP-4, 2560x1440@240, 0x0, 1"
        ];

        exec-once = [
          "fcitx5"
          "hyprctl setcursor HollowKnight 32"
        ];

        bind = [
          "$mod, return, exec, $terminal"
          "$mod, space, exec, ${rofi} -show drun"
          "$mod, C, exec, ${rofi} -modi calc -show calc -no-show-match -no-sort"
          "$mod, E, exec, kitty yazi"
          "$mod, F, fullscreen"

          "$mod SHIFT, Q, killactive"
          "$mod SHIFT, S, exec, flameshot gui"
          "$mod SHIFT, space, togglefloating,"

          "$mod, H, movefocus, l"
          "$mod, J, movefocus, d"
          "$mod, K, movefocus, u"
          "$mod, L, movefocus, r"
          "$mod, tab, cyclenext,"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        windowrule = [
          # "match:class .*, suppress_event fullscreen maximize fullscreenoutput"
          "match:class flameshot, float move 0 0 pin noborder stayfocused opaque fullscreen"
        ];
      };
  };
}
