{ lib, ... }:
let
  luaFunction =
    luaCode:
    lib.generators.mkLuaInline ''
      function()
        ${luaCode}
      end
    '';
in
{
  vim = {
    autocmds = [
      {
        event = [
          "BufEnter"
          "CursorMoved"
          "CursorMovedI"
          "ModeChanged"
        ];
        desc = "Refresh lualine contents";
        callback = luaFunction ''
          require("lualine").refresh({ place = { "statusline" } });
        '';
      }

      {
        event = [ "TextYankPost" ];
        desc = "Highlight yanked text";
        callback = luaFunction "vim.highlight.on_yank();";
      }

      {
        event = [ "FileType" ];
        pattern = [
          "nix"
          "html"
          "js"
          "ts"
          "json"
        ];
        callback = luaFunction ''
          vim.opt_local.expandtab = true;
          vim.opt_local.tabstop = 2;
          vim.opt_local.shiftwidth = 0;
        '';
      }
    ];

    luaConfigRC.usercmds = ''
      vim.api.nvim_create_user_command("Is", function(cmd)
          vim.bo.expandtab = true;
          vim.bo.tabstop = tonumber(cmd.args);
          vim.bo.shiftwidth = 0;
      end, { nargs = 1, desc = "Set indentation to <N> spaces" });
    '';
  };
}
