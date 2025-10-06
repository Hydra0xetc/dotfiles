return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdate", "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  opts = {
    ensure_installed = {
      "bash",
      "diff",
      "html",
      "javascript",
      "json",
      "jsonc",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = true,
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
