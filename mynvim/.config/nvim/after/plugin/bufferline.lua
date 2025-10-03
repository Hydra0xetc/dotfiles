require("bufferline").setup{}

vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to left buffer" })

vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to right buffe" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete current buffer" })
