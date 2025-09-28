return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      style = {
        { fg = "#806d9c" },
        { fg = "#c21f30" },
      },
      use_treesitter = true,
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        right_arrow = ">",
      },
    },
    indent = {
      enable = true,
      chars = {
        " ",
      },
    },
    line_num = {
      enable = false,
    },
    blank = {
      enable = false,
    },
  },
  config = function(_, opts)
    require("hlchunk").setup(opts)
  end
}
