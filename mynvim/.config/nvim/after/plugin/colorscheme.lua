function Color(color)
  color = color or "tokyonight"

  if color == "tokyonight" then
    vim.g.tokyonight_style = "moon"
  end

  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Color()
