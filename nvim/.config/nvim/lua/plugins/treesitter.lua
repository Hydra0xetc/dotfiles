return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- Hanya install parser untuk bahasa yang sering digunakan
    ensure_installed = {
      "lua",
      "python",
      "javascript",
      "typescript",
      "json",
      "bash",
    },
    -- Nonaktifkan fitur yang tidak急需
    auto_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false, -- penting!
    },
  },
}
