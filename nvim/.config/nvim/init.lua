-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.diagnostic.enable(true)

vim.opt.termguicolors = true
vim.opt.guicursor = ""

-- set man number
vim.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.opt_local.number = true
  end,
})

-- Bungkus teks sesuai lebar terminal
vim.opt.wrap = true
vim.opt.linebreak = true
