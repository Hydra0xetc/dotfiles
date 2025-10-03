vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", function ()
   local bufname = vim.api.nvim_buf_get_name(0) 
   local filetype = vim.bo.filetype

   if filetype == "netrw" or bufname == "" then
    vim.cmd("bd")
else
    vim.cmd("Ex")
   end
end, { desc = "toggle netrw exploler "})

vim.keymap.set("n", "<leader>so", vim.cmd.so)
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")
vim.keymap.set("n", "<C-q>", vim.cmd.q)

vim.keymap.set('n', 'r', '<C-r>', { noremap = true, silent = true })

-- Move selected lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- search always in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- chmod
vim.keymap.set("n", "<C-x>", ":silent !chmod +x %<CR>:redraw!<CR>", { silent = true })

vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank sistem mode
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- auto pairs
local auto_pairs = {
  ['"'] = '"',
  ["'"] = "'",
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
}

for open, close in pairs(auto_pairs) do
  -- insert pasangan
  vim.keymap.set("i", open, open .. close .. "<Left>")
end

-- smart backspace
vim.keymap.set("i", "<BS>", function()
  local col = vim.fn.col(".")
  if col <= 1 then
    return "<BS>"
  end

  local line = vim.fn.getline(".")
  local prev = line:sub(col - 1, col - 1) -- karakter sebelum kursor
  local next = line:sub(col, col)         -- karakter di kursor

  if auto_pairs[prev] == next then
    -- kalau ketemu pasangan valid → hapus keduanya
    return "<Del><BS>"
  else
    return "<BS>"
  end
end, { expr = true })
