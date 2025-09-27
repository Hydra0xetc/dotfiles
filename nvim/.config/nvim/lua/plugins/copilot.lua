return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  lazy = true,
  event = "InsertEnter",
  opts = {
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 150,
    },
    panel = { enabled = false },
    filetypes = {
      python = true,
      lua = true,
      cpp = true,
      c = true,
      javascript = true,
      bash = true,
    },
  },

  config = function(_, opts)
    vim.defer_fn(function()
      require("copilot").setup(opts)
    end, 200)
  end,
}
