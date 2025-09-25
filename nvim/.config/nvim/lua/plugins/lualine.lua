local function macro_recording()
  local recording = vim.fn.reg_recording()
  if recording == "" then
    return ""
  else
    return "Recording @" .. recording
  end
end

return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        refresh = { statusline = 1000 }, -- Reduce refresh rate
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { macro_recording },
        lualine_y = {},
        lualine_z = { "location" },
      },
    }
  end,
}
