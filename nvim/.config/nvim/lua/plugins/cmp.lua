return {
  "blink.cmp",
  event = "InsertEnter",
  dependencies = {
    { "friendly-snippets", lazy = true },
    "blink-copilot",
  },

  init = function()
    vim.g.cmp_disable_cmdline = true
    vim.g.cmp_source_cmdline = true
  end,
}
