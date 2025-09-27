return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  enabled = false,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "folke/which-key.nvim" },
  config = function()
    local harpoon = require("harpoon")
    local wk = require("which-key")

    harpoon:setup()

    -- mapping untuk slot select dan delete
    local slot_keys = { "q", "w", "e", "r", "t", "y" }

    local function refresh_harpoon_keys()
      local list = harpoon:list()
      local mappings = {
        -- Add file
        {
          "<leader>ha",
          function()
            list:add()
            refresh_harpoon_keys()
          end,
          desc = "Harpoon add file",
        },
        -- Quick menu
        {
          "<leader>hm",
          function()
            harpoon.ui:toggle_quick_menu(list)
          end,
          desc = "Harpoon quick menu",
        },
        -- Reset all
        {
          "<leader>hR",
          function()
            list:clear()
            refresh_harpoon_keys()
          end,
          desc = "Harpoon reset all slots",
        },
      }

      for i, key in ipairs(slot_keys) do
        local item = list:get(i)
        local filename = item and vim.fn.fnamemodify(item.value, ":t") or "Empty"

        -- Select slot
        table.insert(mappings, {
          "<leader>h" .. key,
          function()
            if item then
              list:select(i)
            else
              vim.notify("Harpoon slot " .. key .. " is empty", vim.log.levels.WARN)
            end
          end,
          desc = "Select: " .. filename,
        })

        -- Delete slot
        table.insert(mappings, {
          "<leader>hd" .. key,
          function()
            if item then
              list:remove(item)
              refresh_harpoon_keys()
            else
              vim.notify("Harpoon slot " .. key .. " is empty", vim.log.levels.WARN)
            end
          end,
          desc = "Delete: " .. filename,
        })
      end

      wk.add(mappings)
    end

    -- Initial register
    refresh_harpoon_keys()
  end,
}
