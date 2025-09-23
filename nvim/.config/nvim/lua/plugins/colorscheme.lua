return {
  "folke/tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = {
    style = "moon", -- gaya warna, bisa "storm", "night", "day", atau "moon"
    transparent = false,
  },
}

-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       flavour = "mocha", -- atau "latte", kalau kamu ingin lebih terang
--       transparent_background = true,
--       integrations = {}, -- tidak usah aktifkan integrasi plugin biar minimal
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }


-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       flavour = "mocha", -- atau latte, frappe, dst.
--       transparent_background = true, -- ini yang penting
--       integrations = {},
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }

-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       flavour = "mocha",
--       transparent_background = true,
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }
