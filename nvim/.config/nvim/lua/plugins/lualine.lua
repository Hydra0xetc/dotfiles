return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Hapus komponen jam di bagian kanan
    opts.sections.lualine_z = {}
    opts.sections.lualine_x = {}
  end,
}
