vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorMovedI", "ModeChanged" }, {
    desc = "Refresh lualine contents",
    callback = function(_)
        require("lualine").refresh({ place = { "statusline" } });
    end,
});

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank();
    end,
})

vim.api.nvim_create_user_command("Is", function(cmd)
    vim.bo.expandtab = true;
    vim.bo.tabstop = tonumber(cmd.args);
    vim.bo.shiftwidth = 0;
end, { nargs = 1, desc = "Set indentation to <N> spaces" });

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "nix", "html", "js", "ts", "json" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 0
    end,
})
