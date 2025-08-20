return {
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = "<C-y>"
    end,
  },
}
