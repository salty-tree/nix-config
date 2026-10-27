{ pkgs, ... }: {
  programs.i3status-rust = {
    enable = true;
    bars.bottom = {
      blocks =
        let
          replace_color = from: to: {
            "${from}_fg" = {
              link = "${to}_fg";
            };
            "${from}_bg" = {
              link = "${to}_bg";
            };
          };
        in
        [
          {
            block = "disk_space";
            path = "/";
            format = " $icon $used/$total ";
            info_type = "available";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
            alert_unit = "GB";
          }

          {
            block = "memory";
            format = " $icon $mem_used.eng(prefix:G)/$mem_total.eng(prefix:G) ";
            warning_mem = 70.0;
            critical_mem = 90.0;
          }

          {
            block = "cpu";
            format = " $icon $utilization";
            format_alt = " $icon $barchart";
            interval = 1;
            theme_overrides = (replace_color "idle" "info") // (replace_color "info" "good");
          }

          {
            block = "temperature";
            interval = 5;
            good = 40;
            idle = 40; # never
            info = 50;
            warning = 60;
            format = "$max ";
            format_alt = "$min - $average - $max ";
            theme_overrides = (replace_color "good" "info") // (replace_color "info" "good");
          }

          {
            block = "nvidia_gpu";
            format = " $icon $utilization $temperature ";
          }

          {
            block = "net";
            format = " ^icon_net_down $speed_down.eng(prefix:K) ^icon_net_up $speed_up.eng(prefix:K) ";
            format_alt = " ^icon_net_down $graph_down ^icon_net_up $graph_up ";
            theme_overrides = replace_color "idle" "info";
          }

          {
            block = "sound";
            driver = "pulseaudio";
            format = " $icon $output_name{ $volume|} ";
            max_vol = 200;
            mappings_use_regex = true;
            mappings = {
              "alsa_output.usb-0b0e_Jabra_SPEAK_510_USB_305075A7C4D0022000-00.analog-stereo" = "Speaker";
              "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1(.[0-9]+)?" = "Monitor";
              "alsa_output.platform-snd_aloop.0.analog-stereo" = "Loopback";
            };
            theme_overrides = replace_color "idle" "info";
          }

          { block = "watson"; }

          {
            block = "pomodoro";
            message = "Work over!";
            break_message = "Break over!";
          }

          {
            block = "custom";
            command = "nc 127.0.0.1 60001 | lines | each { |x| $x | from json | get LayerChange.new -i } | each { |x| print $x }";
            persistent = true;
            interval = "once";
          }

          {
            block = "time";
            interval = 1;
            format = " $icon $timestamp.datetime(f:'%a %Y-%m-%d %T') ";
            theme_overrides = replace_color "idle" "info";
          }

          {
            block = "menu"; # System menu
            text = " hi ";
            items = [
              {
                display = " [Sleep]  Power   Reboot  ";
                cmd = "systemctl suspend";
              }
              {
                display = "  Sleep  [Power]  Reboot  ";
                cmd = "poweroff";
                confirm_msg = " Confirm power ";
              }
              {
                display = "  Sleep   Power  [Reboot] ";
                cmd = "reboot";
                confirm_msg = " Confirm reboot ";
              }
            ];
            theme_overrides = replace_color "idle" "critical";
          }
        ];
      theme = "ctp-mocha";
      icons = "material-nf";
    };
  };
}
