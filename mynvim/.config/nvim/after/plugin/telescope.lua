local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader> ', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<C-g>', builtin.git_files, { desc = 'Telescope search git files' })

-- telescope config

vim.keymap.set("n", "<leader>fc", function ()
    builtin.find_files({
        prompt_title = "< NVIM CONFIG >",
        cwd = vim.fn.stdpath("config"),
    })
end, { desc = "telescope config file" })
