-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.diagnostic.enable(false)

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false,
    float = { show_header = false, border = "none" },
    update_in_insert = false,
})

vim.keymap.set("n", "<leader>fo", function()
  vim.cmd("bdelete") -- tutup buffer aktif
  require("telescope.builtin").find_files() -- buka file baru
end, { desc = "Find file (one buffer only)" })

vim.opt.termguicolors = true

local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local show_hidden = false

local function toggle_hidden(prompt_bufnr)
  show_hidden = not show_hidden
  actions.close(prompt_bufnr)

  -- Panggil ulang Telescope dengan toggle hidden
  require("telescope.builtin").find_files({
    hidden = show_hidden,
    find_command = show_hidden
      and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
      or { "fd", "--type", "f", "--exclude", ".git" },
    attach_mappings = function(_, map)
      map("i", "h", toggle_hidden)
      map("n", "h", toggle_hidden)
      return true
    end,
  })
end

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local show_hidden = false

local function toggle_hidden(prompt_bufnr)
  show_hidden = not show_hidden
  actions.close(prompt_bufnr)

  builtin.find_files({
    hidden = show_hidden,
    no_ignore = true,
    attach_mappings = function(_, map)
      map("n", "h", toggle_hidden) -- hanya mode normal
      return true
    end,
  })
end

vim.keymap.set("n", "<leader>ff", function()
  show_hidden = false
  builtin.find_files({
    hidden = show_hidden,
    no_ignore = true,
    attach_mappings = function(_, map)
      map("n", "h", toggle_hidden) -- hanya mode normal
      return true
    end,
  })
end, { desc = "Telescope find_files (toggle hidden with h in normal mode only)" })

require('telescope').setup({
  defaults = {
    layout_strategy = 'vertical',
    layout_config = {
      preview_cutoff = 1,       -- supaya preview selalu muncul
      preview_height = 0.6,     -- tinggi preview (60% dari jendela)
      prompt_position = 'bottom',
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    find_files = {
      previewer = true,
    },
  },
})

vim.opt.guicursor = ""

vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })


-- set man number
vim.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.opt_local.number = true
  end,
})
