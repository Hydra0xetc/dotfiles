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
  opts = function(_, opts)
    opts.sections.lualine_a = { "mode" }
    opts.sections.lualine_b = {}
    opts.sections.lualine_c = { "filename" }
    opts.sections.lualine_x = { macro_recording }
    opts.sections.lualine_y = {}
    opts.sections.lualine_z = { "location" }
  end,
}
