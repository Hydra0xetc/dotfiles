local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'r', '<C-r>')
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Q>', ':q!<CR>', { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- source config
vim.keymap.set("n", "<leader>so", vim.cmd.so)

-- Move selected lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search always in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set("n", "<C-x>", ":silent !chmod +x %<CR>:redraw!<CR>")

-- change word under cursor
vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute word under cursor" })

  -- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight when yank",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function() 
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>w", vim.diagnostic.open_float)
