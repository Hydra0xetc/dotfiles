return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
        vim.schedule(function()
          vim.cmd("normal! zz")
        end)
      end,
      desc = "Flash Jump",
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
        vim.schedule(function()
          vim.cmd("normal! zz")
        end)
      end,
      desc = "Flash Treesitter",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
        vim.schedule(function()
          vim.cmd("normal! zz")
        end)
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
        vim.schedule(function()
          vim.cmd("normal! zz")
        end)
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
        vim.schedule(function()
          vim.cmd("normal! zz")
        end)
      end,
      desc = "Toggle Flash Search",
    },
  },
}
