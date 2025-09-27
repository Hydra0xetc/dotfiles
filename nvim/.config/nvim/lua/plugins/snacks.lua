return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.picker = opts.picker or {}
    opts.picker.files = opts.picker.files or {}
    opts.picker.files.ignore = true

    opts.picker.files.transform = function(item)
      if not item.file then
        return item
      end

      -- bangun path absolut item (cwd + file)
      local cwd = item.cwd
      local item_path = vim.fn.fnamemodify(cwd .. "/" .. item.file, ":p")
      local current = vim.fn.expand("%:p")

      if item_path == current then
        item.score_add = (item.score_add or 0) + 1000
      end

      return item
    end

    return opts
  end,
}
