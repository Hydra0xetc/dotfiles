return {
    "akinsho/bufferline.nvim",
    -- if want icons
    -- dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({})
        
        -- Keymaps
        vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", {})
        vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", {})
        vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", {})
    end
}
