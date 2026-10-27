{ pkgs, ... }: {
  home.packages = [ pkgs.zed-editor ];

  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    # General visual
    theme = {
      mode = "dark";
      light = "Catppuccin Latte";
      dark = "Catppuccin Mocha";
    };
    buffer_font_family = "JetBrainsMono Nerd Font";
    ui_font_family = "Inter Variable";
    tab_bar.show = false;

    # General behavior
    restore_on_startup = "none";
    when_closing_with_no_tabs = "keep_window_open";
    collaboration_panel.dock = "right";
    preview_tabs.enable_preview_from_file_finder = true;
    preview_tabs.enable_preview_from_code_navigation = true;
    file_scan_exclusions = [
      # Defaults
      "**/.git"
      "**/.svn"
      "**/.hg"
      "**/CVS"
      "**/.DS_Store"
      "**/Thumbs.db"
      "**/.classpath"
      "**/.settings"
      # Other
      "**/.idea"
      "**/.venv"
    ];
    journal.hour_format = "hour24";
    auto_install_extensions = {
      html = false;
    };

    # Editor visual
    cursor_blink = false;
    unnecessary_code_fade = 0.2;
    indent_guides.active_line_width = 2;
    wrap_guides = [
      80
      120
    ];
    soft_wrap = "bounded";
    preferred_line_length = 120;
    line_indicator_format = "long";

    # Editor behavior
    auto_signature_help = true;
    always_treat_brackets_as_autoclosed = true;
    vertical_scroll_margin = 5;
    inlay_hints.enabled = true;

    # Vim + keymaps
    vim_mode = true;
    vim.toggle_relative_line_numbers = true;
    vim.use_system_clipboard = "never";
    base_keymap = "JetBrains";
  };
}
