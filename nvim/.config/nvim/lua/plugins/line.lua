return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      -- Buat warna highlight custom
      vim.api.nvim_set_hl(0, "IndentGray", { fg = "#888888", nocombine = true })
                                                                    require("ibl").setup({
        indent = {                                                      char = "|", -- Ganti dengan karakter pipe
          highlight = { "IndentGray" },
        },
        scope = { enabled = false }, -- Nonaktifkan scope highlighting jika tidak diperlukan
      })

      -- Optional: Jika Anda ingin memastikan highlight tetap ada setelah colorscheme berubah
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentGray", { fg = "#888888", nocombine = true })
      end)
    end,
  },
}
