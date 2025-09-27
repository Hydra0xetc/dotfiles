return {
  "blink.cmp",
  event = "InsertEnter",
  dependencies = {
    { "friendly-snippets", lazy = true },
    "blink-copilot",
  },

  init = function()
    vim.g.cmp_disable_cmdline = true
  end,

  opts = {
    performance = {
      debounce = 100,
      throttle = 50,
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
  },
}
