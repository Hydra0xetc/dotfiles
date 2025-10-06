return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- if want icons
        -- "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        
        -- Setup Telescope
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<Esc>"] = "close",
                    }
                },
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        height = 0.95,
                        width = 0.9,
                        preview_height = 0.6,
                        preview_cutoff = 1,
                        mirror = true,
                        prompt_position = "top",
                    }
                },
                preview = {
                    hide_on_startup = false,
                    timeout = 500,
                }
            },
            pickers = {
                find_files = {
                    hidden = true
                },
                live_grep = {
                }
            }
        })

        -- Keymaps Anda...
        vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<C-g>', builtin.git_files, { desc = 'Telescope search git files' })

        vim.keymap.set("n", "<leader>fc", function()
            builtin.find_files({
                prompt_title = "< NVIM CONFIG >",
                cwd = vim.fn.stdpath("config"),
                layout_config = {
                    vertical = {
                        preview_height = 0.7,
                    }
                }
            })
        end, { desc = "telescope config file" })
        
        vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Telescope recent files' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
    end
}
