return {
  "romgrk/barbar.nvim",
  event = {
    "TabNewEntered",
    "BufEnter",
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },

  init = function()
    vim.g.barbar_auto_setup = false
    vim.g.barbar_pinned = 0
    vim.g.barbar_sidebar = 0
  end,

  opts = {
    animation = false,
    clickable = false,
    focus_on_close = false,
    hide = { extensions = true },
    icons = {
      button = "",
      separator = { letf = "", right = "", }
    },

    insert_at_end = true,
  },

  config = function(_, opts)
    vim.defer_fn(function()
      require("barbar").setup(opts)
    end, 100)
  end,
}
