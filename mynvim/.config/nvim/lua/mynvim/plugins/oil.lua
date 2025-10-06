return {
    "stevearc/oil.nvim",
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {},
            -- Opsional
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ["<leader>q"] = "actions.close",
            }
        })
        
        vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Toggle Oil file explorer" })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })
    end
}
